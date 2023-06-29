DECLARE @id INT;
DECLARE @end DATETIME = GETDATE();
DECLARE @endPrice DECIMAL(10, 2) = 1000000 + (RAND() * 1000000);
DECLARE @columnName NVARCHAR(50);

DECLARE @columnNames TABLE (ColumnName NVARCHAR(50));

INSERT INTO @columnNames
    (ColumnName)
VALUES
    ('Live'),
    ('OneDay'),
    ('OneWeek'),
    ('OneMonth'),
    ('ThreeMonths'),
    ('YTD'),
    ('OneYear');

DECLARE userCursor CURSOR FOR
SELECT id
FROM Users;

OPEN userCursor;

FETCH NEXT FROM userCursor INTO @id;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @start DATETIME = DATEADD(HOUR, -1, GETDATE());
    SET @start = DATEADD(HOUR, DATEDIFF(HOUR, 0, @start), 0);
    SET @start = DATEADD(MINUTE, -DATEPART(MINUTE, @start), @start);
    SET @start = DATEADD(SECOND, -DATEPART(SECOND, @start), @start);

    DECLARE columnCursor CURSOR FOR
SELECT ColumnName
    FROM @columnNames;

    OPEN columnCursor;

    FETCH NEXT FROM columnCursor INTO @columnName;

    WHILE @@FETCH_STATUS = 0
BEGIN
        SET @start = CASE
            WHEN @columnName = 'Live' THEN DATEADD(HOUR, -1, GETDATE())
            WHEN @columnName = 'OneDay' THEN DATEADD(DAY, -1, GETDATE())
            WHEN @columnName = 'OneWeek' THEN DATEADD(WEEK, -1, GETDATE())
            WHEN @columnName = 'OneMonth' THEN DATEADD(MONTH, -1, GETDATE())
            WHEN @columnName = 'ThreeMonths' THEN DATEADD(MONTH, -3, GETDATE())
            WHEN @columnName = 'YTD' THEN DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0)
            WHEN @columnName = 'OneYear' THEN DATEADD(YEAR, -1, GETDATE())
END;

    print @start

        EXEC GenerateTimePeriod
            @userId = @id,
            @startTime = @start,
            @endTime = @end,
            @endPrice = @endPrice,
            @columnName = @columnName;

        FETCH NEXT FROM columnCursor INTO @columnName;
    END;

    CLOSE columnCursor;
    DEALLOCATE columnCursor;

    FETCH NEXT FROM userCursor INTO @id;
END;

CLOSE userCursor;
DEALLOCATE userCursor;




