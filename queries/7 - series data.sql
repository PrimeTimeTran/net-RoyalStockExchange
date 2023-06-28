CREATE PROCEDURE UpdateLiveSeriesForCompany
    @companyId INT,
    @price DECIMAL(10, 2),
    @outputValue INT OUTPUT,
    @fieldToUpdate NVARCHAR(50)
AS
BEGIN
    SET @outputValue = @companyId;
    DECLARE @beginningOfDay DATETIME = DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0);
    DECLARE @count INT = 0;
    DECLARE @interval INT = 0;
    DECLARE @startTime DATETIME;

    IF @fieldToUpdate IN ('Live', 'OneDay')
    BEGIN
        SET @count = DATEDIFF(MINUTE, @startTime, GETDATE()) / 5;
        SET @interval = 5;
        SET @startTime = CASE
                            WHEN @fieldToUpdate = 'Live' THEN DATEADD(HOUR, -1, GETDATE())
                            WHEN @fieldToUpdate = 'OneDay' THEN @beginningOfDay
                        END;
    END
    ELSE IF @fieldToUpdate IN ('OneWeek', 'OneMonth')
    BEGIN
        SET @count = DATEDIFF(HOUR, @startTime, GETDATE());
        SET @interval = 60;
        SET @startTime = CASE
                            WHEN @fieldToUpdate = 'OneWeek' THEN DATEADD(DAY, -7, GETDATE())
                            WHEN @fieldToUpdate = 'OneMonth' THEN DATEADD(MONTH, -1, GETDATE())
                        END;
    END
    ELSE IF @fieldToUpdate IN ('ThreeMonths', 'YearToDate', 'OneYear')
    BEGIN
        SET @count = DATEDIFF(DAY, @startTime, GETDATE());
        SET @interval = 1440;
        SET @startTime = CASE
                            WHEN @fieldToUpdate = 'ThreeMonths' THEN DATEADD(MONTH, -3, GETDATE())
                            WHEN @fieldToUpdate = 'YearToDate' THEN DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0)
                            WHEN @fieldToUpdate = 'OneYear' THEN DATEADD(YEAR, -1, GETDATE())
                        END;
    END
    ELSE IF @fieldToUpdate = 'AllData'
    BEGIN
        SET @count = DATEDIFF(WEEK, @startTime, GETDATE());
        SET @interval = 10080;
    END

    DECLARE @open DECIMAL(10, 2) = @price;
    DECLARE @lo DECIMAL(10, 2) = 0.0;
    DECLARE @hi DECIMAL(10, 2) = 0.0;
    DECLARE @close DECIMAL(10, 2) = 0.0;

    DECLARE @existingSeries NVARCHAR(MAX);

    -- Retrieve the existing series value for the specified companyId and fieldToUpdate
    SELECT @existingSeries = CASE
                                WHEN @fieldToUpdate = 'Live' THEN Live
                                WHEN @fieldToUpdate = 'OneDay' THEN OneDay
                                WHEN @fieldToUpdate = 'OneWeek' THEN OneWeek
                                WHEN @fieldToUpdate = 'OneMonth' THEN OneMonth
                                WHEN @fieldToUpdate = 'ThreeMonths' THEN ThreeMonths
                                WHEN @fieldToUpdate = 'YearToDate' THEN YearToDate
                                WHEN @fieldToUpdate = 'OneYear' THEN OneYear
                                WHEN @fieldToUpdate = 'AllData' THEN AllData
                            END
    FROM Assets
    WHERE Id = @companyId;

    -- Remove the closing square brackets
    SET @existingSeries = REPLACE(@existingSeries, ']}', '');

    WHILE @count > 0
    BEGIN
        SET @price = @price - 0.10 + (RAND() * (.10 - (-0.15)));
        SET @close = @price;

        SET @lo = @price - 0.05 + (RAND() * (-0.1));
        SET @hi = @price - 0.05 + (RAND() * 0.1);
        SET @open = @lo + (RAND() * (@hi - @lo));
        SET @startTime = DATEADD(MINUTE, @interval, @startTime);
        SET @count = @count - 1;
        -- Round the @startTime to the hour if @fieldToUpdate is OneWeek or OneMonth
        IF @fieldToUpdate IN ('OneWeek', 'OneMonth')
            SET @startTime = DATEADD(HOUR, DATEDIFF(HOUR, 0, @startTime), 0);

        -- Append a new JSON object to the series array
        SET @existingSeries = JSON_MODIFY(
            @existingSeries,
            'append $.series',
            JSON_QUERY('{
                "o": ' + CAST(@open AS NVARCHAR(50)) + ',
                "l": ' + CAST(CASE WHEN @open < @lo THEN @open ELSE @lo END AS NVARCHAR(50)) + ',
                "h": ' + CAST(CASE WHEN @close > @hi THEN @close ELSE @hi END AS NVARCHAR(50)) + ',
                "c": ' + CAST(@close AS NVARCHAR(50)) + ',
                "vwa": ' + CAST(1000 AS NVARCHAR(50)) + ',
                "time": "' + CONVERT(NVARCHAR(50), @startTime, 120) + '"
            }')
        );

        SET @open = @close;

        SET @count = @count - 1;
        SET @startTime = DATEADD(MINUTE, @interval, @startTime);
    END;

    -- Update the specified field for the specified companyId
    UPDATE Assets
    SET
        Live = CASE WHEN @fieldToUpdate = 'Live' THEN @existingSeries ELSE Live END,
        OneDay = CASE WHEN @fieldToUpdate = 'OneDay' THEN @existingSeries ELSE OneDay END,
        OneWeek = CASE WHEN @fieldToUpdate = 'OneWeek' THEN @existingSeries ELSE OneWeek END,
        OneMonth = CASE WHEN @fieldToUpdate = 'OneMonth' THEN @existingSeries ELSE OneMonth END,
        ThreeMonths = CASE WHEN @fieldToUpdate = 'ThreeMonths' THEN @existingSeries ELSE ThreeMonths END,
        YearToDate = CASE WHEN @fieldToUpdate = 'YearToDate' THEN @existingSeries ELSE YearToDate END,
        OneYear = CASE WHEN @fieldToUpdate = 'OneYear' THEN @existingSeries ELSE OneYear END,
        AllData = CASE WHEN @fieldToUpdate = 'AllData' THEN @existingSeries ELSE AllData END
    WHERE Id = @companyId;
END;
GO

DECLARE @id INT;
DECLARE @result INT;
DECLARE @companyId INT;
DECLARE @outputValue INT;
DECLARE @price DECIMAL(10, 2);

DECLARE companyCursor CURSOR FOR
SELECT id FROM Companies;

OPEN companyCursor;

FETCH NEXT FROM companyCursor INTO @companyId;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Fetch the first asset's price for the company
    SELECT TOP 1 @price = O FROM Assets WHERE CompanyId = @companyId ORDER BY Assets.Id ASC;

    EXEC UpdateLiveSeriesForCompany @companyId, @price, @outputValue = @result OUTPUT, @fieldToUpdate = 'Live';

    -- Update OneDay field
    EXEC UpdateLiveSeriesForCompany @companyId, @price, @outputValue = @result OUTPUT, @fieldToUpdate = 'OneDay';

    -- Update OneWeek field
    EXEC UpdateLiveSeriesForCompany @companyId, @price, @outputValue = @result OUTPUT, @fieldToUpdate = 'OneWeek';

    -- Update OneMonth field
    EXEC UpdateLiveSeriesForCompany @companyId, @price, @outputValue = @result OUTPUT, @fieldToUpdate = 'OneMonth';

    -- Update ThreeMonths field
    EXEC UpdateLiveSeriesForCompany @companyId, @price, @outputValue = @result OUTPUT, @fieldToUpdate = 'ThreeMonths';

    -- Update YearToDate field
    EXEC UpdateLiveSeriesForCompany @companyId, @price, @outputValue = @result OUTPUT, @fieldToUpdate = 'YearToDate';

    -- Update OneYear field
    EXEC UpdateLiveSeriesForCompany @companyId, @price, @outputValue = @result OUTPUT, @fieldToUpdate = 'OneYear';

    -- Update AllData field
    EXEC UpdateLiveSeriesForCompany @companyId, @price, @outputValue = @result OUTPUT, @fieldToUpdate = 'AllData';

FETCH NEXT FROM companyCursor INTO @companyId;
END

CLOSE companyCursor;
DEALLOCATE companyCursor;

SELECT TOP (10) [O]
     ,[CompanyId]
     ,[SYM]
     ,[Id]
     ,[Live]
     ,[OneDay]
     ,[AllData]
     ,[OneWeek]
     ,[OneYear]
     ,[OneMonth]
     ,[YearToDate]
     ,[ThreeMonths]
FROM [RSE].[dbo].[Assets]
