IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[GenerateTimePeriod]') AND type = N'P')
    DROP PROCEDURE [dbo].[GenerateTimePeriod];
GO

CREATE PROCEDURE [dbo].[GenerateTimePeriod]
    @userId INT,
    @startTime DATETIME,
    @endTime DATETIME,
    @endPrice DECIMAL(18, 2),
    @columnName VARCHAR(50)
AS
BEGIN
    DECLARE @timeSeries TABLE (
        [time] DATETIME,
        [value] DECIMAL(18, 2)
    );
    DECLARE @i INT = 1;
    DECLARE @timeIncrement INT;
    DECLARE @intervals INT = 288;
    DECLARE @priceFluctuation DECIMAL(18, 2);
    DECLARE @previousPrice DECIMAL(18, 2) = @endPrice;

    -- Set time increment and price fluctuation based on the column name
    IF @columnName IN ('Live', 'OneDay')
        SET @timeIncrement = 5;
    ELSE IF @columnName IN ('OneWeek', 'OneMonth')
        SET @timeIncrement = 1;
    ELSE
        SET @timeIncrement = 1440;

    -- From start time time on each iteration
    -- of the loop until we get to the end time, now.
    WHILE @startTime <= @endTime
    BEGIN
    INSERT INTO @timeSeries ([time])
    VALUES (@startTime);
         
    IF @columnName IN ('Live', 'OneDay')
        SET @startTime = DATEADD(MINUTE, 5, @startTime);
    ELSE IF @columnName IN ('OneWeek', 'OneMonth')
        SET @startTime = DATEADD(HOUR, 1, @startTime);
    ELSE
        SET @startTime = DATEADD(DAY, 1, @startTime);
        SET @i += 1;
    END;
    
    -- Use a second table here because we can't update values
    -- using a cursor. Cursor is read only.         
    DECLARE @updatedTimeSeries TABLE (
        [time] DATETIME,
        [value] DECIMAL(18, 2)
    );

    DECLARE @time DATETIME;
    DECLARE @value DECIMAL(18, 2);
    
    -- Work backwards from now until the start.
    -- Decrease the price by a random amount between 0.5% and 1.5%.
    -- So that we end on the same price for each period, now.         
    DECLARE myCursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT [time], [value]
    FROM @timeSeries
    ORDER BY [time] DESC;
    
    OPEN myCursor;
    
    FETCH NEXT FROM myCursor INTO @time, @value;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO @updatedTimeSeries ([time], [value])
        VALUES (@time, @previousPrice);
        
        SET @priceFluctuation = @previousPrice * (RAND() * - 0.015 + 0.005);
                SET @previousPrice = ROUND(@previousPrice + @priceFluctuation, 2);
        
        FETCH NEXT FROM myCursor INTO @time, @value;
    END;

    CLOSE myCursor;
    DEALLOCATE myCursor;

    DECLARE @jsonArray NVARCHAR(MAX);
    SET @jsonArray = (
        SELECT [time] AS [time], [value] AS [value]
        FROM @updatedTimeSeries
        ORDER BY [time] ASC
        FOR JSON PATH
    );

    DECLARE @sql NVARCHAR(MAX) = N'
        UPDATE [Portfolios]
        SET ' + QUOTENAME(@columnName) + ' = @jsonArray
        WHERE UserId = @userId;
    ';

EXEC sp_executesql @sql, N'@userId INT, @jsonArray NVARCHAR(MAX)', @userId = @userId, @jsonArray = @jsonArray;
END;

