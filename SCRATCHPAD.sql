-- Add asset histories to each company
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateLiveSeriesForCompany]') AND type = N'P')
    DROP PROCEDURE [dbo].[UpdateLiveSeriesForCompany];
GO

CREATE PROCEDURE UpdateLiveSeriesForCompany
    @companyId INT,
    @outputValue INT OUTPUT,
    @fieldToUpdate NVARCHAR(50)
AS
BEGIN
    SET @outputValue = @companyId;
    DECLARE @beginningOfDay DATETIME = DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0);
    DECLARE @count INT = 0;
    DECLARE @interval INT = 0;
    DECLARE @startTime DATETIME;

IF @fieldToUpdate = 'Live'
BEGIN
        SET @count = DATEDIFF(MINUTE, DATEADD(HOUR, -1, GETDATE()), GETDATE()) / 5;
        SET @interval = 5;
        SET @startTime = DATEADD(HOUR, -1, GETDATE());
END
ELSE IF @fieldToUpdate = 'OneDay'
BEGIN
        SET @count = DATEDIFF(MINUTE, @beginningOfDay, GETDATE()) / 5;
        SET @interval = 5;
        SET @startTime = @beginningOfDay;
END
ELSE IF @fieldToUpdate = 'OneWeek'
BEGIN
        SET @count = DATEDIFF(HOUR, DATEADD(DAY, -7, GETDATE()), GETDATE());
        SET @interval = 60;
        SET @startTime = DATEADD(DAY, -7, GETDATE());
END
ELSE IF @fieldToUpdate = 'OneMonth'
BEGIN
        SET @count = DATEDIFF(HOUR, DATEADD(MONTH, -1, GETDATE()), GETDATE());
        SET @interval = 60;
        SET @startTime = DATEADD(MONTH, -1, GETDATE());
END
ELSE IF @fieldToUpdate = 'ThreeMonths'
BEGIN
        SET @count = DATEDIFF(DAY, DATEADD(MONTH, -3, GETDATE()), GETDATE());
        SET @interval = 1440;
        SET @startTime = DATEADD(MONTH, -3, GETDATE());
END
ELSE IF @fieldToUpdate = 'YearToDate'
BEGIN
        SET @count = DATEDIFF(DAY, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0), GETDATE());
        SET @interval = 1440;
        SET @startTime = DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0);
END
ELSE IF @fieldToUpdate = 'OneYear'
BEGIN
        SET @count = DATEDIFF(DAY, DATEADD(YEAR, -1, GETDATE()), GETDATE());
        SET @interval = 1440;
        SET @startTime = DATEADD(YEAR, -1, GETDATE());
END
ELSE IF @fieldToUpdate = 'AllData'
BEGIN
        SET @count = DATEDIFF(WEEK, @startTime, GETDATE());
        SET @interval = 10080;
END

    DECLARE @price DECIMAL(10, 2) = 250.00;
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
        SET @hi = @price - 0.05 + (RAND() * (.1));

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
    Live = CASE WHEN @fieldToUpdate = 'Live' THEN @existingSeries ELSE Live END
WHERE Id = @companyId;
END;
GO

DECLARE @id INT;
DECLARE @result INT;
DECLARE @companyId INT;

DECLARE companyCursor CURSOR FOR
SELECT id FROM Companies;

OPEN companyCursor;

FETCH NEXT FROM companyCursor INTO @companyId;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update Live field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'Live';

FETCH NEXT FROM companyCursor INTO @companyId;
END

CLOSE companyCursor;
DEALLOCATE companyCursor;


