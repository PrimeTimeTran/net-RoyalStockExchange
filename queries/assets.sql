IF
EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateLiveSeriesForCompany]') AND type = N'P')
    DROP PROCEDURE
[dbo].[UpdateLiveSeriesForCompany];
GO

CREATE PROCEDURE UpdateLiveSeriesForCompany @companyId INT,
    @outputValue INT OUTPUT,
    @fieldToUpdate NVARCHAR(50),
    @price DECIMAL(10, 2),
    @industry NVARCHAR(50)
AS
BEGIN
    DECLARE
@random DECIMAL(5, 2) = RAND();

    IF
@random <= 0.05
BEGIN
        IF
@industry = 'Technology'
BEGIN
            DECLARE
@randomDirection INT = ABS(CHECKSUM(NEWID())) % 2; -- Randomly choose between 0 or 1

            IF
@randomDirection = 0 -- Decrement price
                SET @price = @price * 0.75; -- Decrease price by 25%
ELSE
                SET @price = @price * 1.25; -- Increase price by 25%
END
END
    SET
@outputValue = @companyId;
    DECLARE
@beginningOfDay DATETIME = DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0);
    DECLARE
@count INT = 0;
    DECLARE
@interval INT = 0;
    DECLARE
@startTime DATETIME;

IF
@fieldToUpdate = 'Live'
BEGIN
        SET
@count = DATEDIFF(MINUTE, DATEADD(HOUR, -1, GETDATE()), GETDATE()) / 5;
        SET
@interval = 5;
        SET
@startTime = DATEADD(HOUR, -1, GETDATE());
END
ELSE IF @fieldToUpdate = 'OneDay'
BEGIN
        SET
@count = DATEDIFF(MINUTE, @beginningOfDay, GETDATE()) / 5;
        SET
@interval = 5;
        SET
@startTime = @beginningOfDay;
END
ELSE IF @fieldToUpdate = 'OneWeek'
BEGIN
        SET
@count = DATEDIFF(HOUR, DATEADD(DAY, -7, GETDATE()), GETDATE());
        SET
@interval = 60;
        SET
@startTime = DATEADD(DAY, -7, GETDATE());
END
ELSE IF @fieldToUpdate = 'OneMonth'
BEGIN
        SET
@count = DATEDIFF(HOUR, DATEADD(MONTH, -1, GETDATE()), GETDATE());
        SET
@interval = 60;
        SET
@startTime = DATEADD(MONTH, -1, GETDATE());
END
ELSE IF @fieldToUpdate = 'ThreeMonths'
BEGIN
        SET
@count = DATEDIFF(DAY, DATEADD(MONTH, -3, GETDATE()), GETDATE());
        SET
@interval = 1440;
        SET
@startTime = DATEADD(MONTH, -3, GETDATE());
END
ELSE IF @fieldToUpdate = 'YearToDate'
BEGIN
        SET
@count = DATEDIFF(DAY, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0), GETDATE());
        SET
@interval = 1440;
        SET
@startTime = DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0);
END
ELSE IF @fieldToUpdate = 'OneYear'
BEGIN
        SET
@count = DATEDIFF(DAY, DATEADD(YEAR, -1, GETDATE()), GETDATE());
        SET
@interval = 1440;
        SET
@startTime = DATEADD(YEAR, -1, GETDATE());
END
ELSE IF @fieldToUpdate = 'AllData'
BEGIN
        SET
@count = DATEDIFF(WEEK, @startTime, GETDATE());
        SET
@interval = 10080;
END

    
    DECLARE
@open DECIMAL(10, 2) = @price;
    DECLARE
@lo DECIMAL(10, 2) = 0.0;
    DECLARE
@hi DECIMAL(10, 2) = 0.0;
    DECLARE
@close DECIMAL(10, 2) = 0.0;

    DECLARE
@existingSeries NVARCHAR(MAX);

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
SET
@existingSeries = REPLACE(@existingSeries, ']}', '');

    WHILE
@count > 0
BEGIN
        SET
@price = @price - 0.10 + (RAND() * (.10 - (-0.15)));
        SET
@close = @price;

        SET
@lo = @price - 0.05 + (RAND() * (-0.1));
        SET
@hi = @price - 0.05 + (RAND() * (.1));

        -- Round the @startTime to the hour if @fieldToUpdate is OneWeek or OneMonth
        IF
@fieldToUpdate IN ('OneWeek', 'OneMonth')
            SET @startTime = DATEADD(HOUR, DATEDIFF(HOUR, 0, @startTime), 0);

        -- Append a new JSON object to the series array
        SET
@existingSeries = JSON_MODIFY(
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

        SET
@open = @close;

        SET
@count = @count - 1;
        SET
@startTime = DATEADD(MINUTE, @interval, @startTime);
END;

    -- Update the specified field for the specified companyId
UPDATE Assets
SET Live        = CASE WHEN @fieldToUpdate = 'Live' THEN @existingSeries ELSE Live END,
    OneDay      = CASE WHEN @fieldToUpdate = 'OneDay' THEN @existingSeries ELSE OneDay END,
    OneWeek     = CASE WHEN @fieldToUpdate = 'OneWeek' THEN @existingSeries ELSE OneWeek END,
    OneMonth    = CASE WHEN @fieldToUpdate = 'OneMonth' THEN @existingSeries ELSE OneMonth END,
    ThreeMonths = CASE WHEN @fieldToUpdate = 'ThreeMonths' THEN @existingSeries ELSE ThreeMonths END,
    YearToDate  = CASE WHEN @fieldToUpdate = 'YearToDate' THEN @existingSeries ELSE YearToDate END,
    OneYear     = CASE WHEN @fieldToUpdate = 'OneYear' THEN @existingSeries ELSE OneYear END,
    AllData     = CASE WHEN @fieldToUpdate = 'AllData' THEN @existingSeries ELSE AllData END
WHERE Id = @companyId;
END;
GO


-- So we don't have to drop and recreate the table
-- When we want to run this script again.
UPDATE Assets
SET [Meta] = N'{
    "MC": "",
    "PE": "",
    "DY": "",
    "O": "",
    "V": "",
    "AV": "",
    "VWA": "",
    "HiDay": "",
    "HiYear": "",
    "LoDay": "",
    "LoYear": ""
}';

UPDATE Assets
SET [Live] = N'{
    "sym": "",
    "period": "live",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [OneDay] = N'{
    "sym": "",
    "period": "1d",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [OneWeek] = N'{
    "sym": "",
    "period": "1w",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [OneMonth] = N'{
    "sym": "",
    "period": "1m",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [ThreeMonths] = N'{
    "sym": "",
    "period": "3m",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [YearToDate] = N'{
    "sym": "",
    "period": "ytd",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';
UPDATE Assets
SET [OneYear] = N'{
    "sym": "",
    "period": "1y",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [AllData] = N'{
    "sym": "",
    "period": "all",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

DECLARE
@id INT;
DECLARE
@result INT;
DECLARE
@companyId INT;
DECLARE
@price DECIMAL(10, 2);
DECLARE
@industry NVARCHAR(255);

DECLARE
companyCursor CURSOR FOR
SELECT id, price, industry
FROM Companies;

OPEN companyCursor;

FETCH NEXT FROM companyCursor INTO @companyId, @price, @industry;

WHILE
@@FETCH_STATUS = 0
BEGIN
EXEC UpdateLiveSeriesForCompany 
    @companyId, 
    @outputValue = @result OUTPUT, 
    @fieldToUpdate = 'Live',
    @price = @price,
    @industry = @industry;
EXEC UpdateLiveSeriesForCompany 
    @companyId, 
    @outputValue = @result OUTPUT, 
    @fieldToUpdate = 'OneDay',
    @price = @price,
    @industry = @industry;
EXEC UpdateLiveSeriesForCompany 
    @companyId, 
    @outputValue = @result OUTPUT, 
    @fieldToUpdate = 'OneWeek',
    @price = @price,
    @industry = @industry;
EXEC UpdateLiveSeriesForCompany 
    @companyId, 
    @outputValue = @result OUTPUT, 
    @fieldToUpdate = 'OneMonth',
    @price = @price,
    @industry = @industry;
EXEC UpdateLiveSeriesForCompany 
    @companyId, 
    @outputValue = @result OUTPUT, 
    @fieldToUpdate = 'ThreeMonths',
    @price = @price,
    @industry = @industry;
EXEC UpdateLiveSeriesForCompany 
    @companyId, 
    @outputValue = @result OUTPUT, 
    @fieldToUpdate = 'YearToDate',
    @price = @price,
    @industry = @industry;
EXEC UpdateLiveSeriesForCompany 
    @companyId, 
    @outputValue = @result OUTPUT, 
    @fieldToUpdate = 'OneYear',
    @price = @price,
    @industry = @industry;

FETCH NEXT FROM companyCursor INTO @companyId, @price, @industry;
END

CLOSE companyCursor;
DEALLOCATE
companyCursor;
