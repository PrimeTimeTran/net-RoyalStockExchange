DROP TABLE IF EXISTS Portfolios;

CREATE TABLE Portfolios (
    UserId INT NOT NULL,
    Id INT PRIMARY KEY IDENTITY(1, 1),
    CreatedAt DATETIME DEFAULT GETDATE(),
    Valuation NVARCHAR(MAX) NOT NULL DEFAULT N'{}',
    CONSTRAINT FK_Portfolio_Users FOREIGN KEY (UserId) REFERENCES Users(Id)
);

DECLARE @userId INT;
DECLARE @portfolioId INT;
DECLARE @userCursor CURSOR;

SET @userCursor = CURSOR FOR
SELECT Id
FROM Users;

OPEN @userCursor;

FETCH NEXT FROM @userCursor INTO @userId;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO Portfolios (UserId, Valuation)
    VALUES (@userId, N'{}');

    SET @portfolioId = SCOPE_IDENTITY();

    DECLARE @intervalMinutes INT = -5;
    DECLARE @startTime DATETIME = GETDATE();
    DECLARE @endTime DATETIME = DATEADD(DAY, -1, GETDATE());
    
    DECLARE @selectedStocks TABLE (
        StockId INT,
        Symbol NVARCHAR(50),
        Price DECIMAL(18, 2)
    );

    DECLARE @numStocks INT = ABS(CHECKSUM(NEWID()) % 3) + 3;

    WITH RandomizedStocks AS (
        SELECT TOP (@numStocks) Id, Symbol, Price
        FROM (
            SELECT DISTINCT Id, Symbol, Price
            FROM Stocks
            WHERE Price >= 10 AND Price <= 500
        ) AS DistinctStocks
        ORDER BY NEWID()
    )
    INSERT INTO @selectedStocks (StockId, Symbol, Price)
    SELECT Id, Symbol, Price
    FROM RandomizedStocks;

    DECLARE @stocks NVARCHAR(MAX) = N'[';

    DECLARE @stockId INT, @symbol NVARCHAR(50), @price DECIMAL(18, 2), @quantity DECIMAL(18, 2);

    DECLARE stockCursor CURSOR FOR
    SELECT DISTINCT StockId, Symbol, Price
    FROM @selectedStocks;

    OPEN stockCursor;

    FETCH NEXT FROM stockCursor INTO @stockId, @symbol, @price;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @quantity = ((ABS(CHECKSUM(NEWID()) % 50) + 1) * 20);

        SET @stocks += N'{"symbol": "' + @symbol + N'", "quantity": ' + CONVERT(NVARCHAR(MAX), @quantity) + N', "price": ' + CONVERT(NVARCHAR(MAX), @price) + N'},';

        FETCH NEXT FROM stockCursor INTO @stockId, @symbol, @price;
    END

    CLOSE stockCursor;
    DEALLOCATE stockCursor;

    SET @stocks = LEFT(@stocks, LEN(@stocks) - 1) + N']';

    DECLARE @cryptos NVARCHAR(MAX) = N'[
        {"symbol": "BTC", "quantity": ' + CONVERT(NVARCHAR(MAX), ABS(CHECKSUM(NEWID()) % 5) + 10) + ', "price": 40000.00},
        {"symbol": "ETH", "quantity": ' + CONVERT(NVARCHAR(MAX), ABS(CHECKSUM(NEWID()) % 491) + 10) + ', "price": 2500.00}
    ]';

    DECLARE @previousValue DECIMAL(18, 2) = (
        SELECT SUM(quantity * price)
        FROM OPENJSON(@stocks) WITH (
            symbol NVARCHAR(50),
            quantity DECIMAL(18, 2),
            price DECIMAL(18, 2)
        )
    ) + (
        SELECT SUM(quantity * price)
        FROM OPENJSON(@cryptos) WITH (
            symbol NVARCHAR(50),
            quantity DECIMAL(18, 2),
            price DECIMAL(18, 2)
        )
    );

    DECLARE @stocksAndOptionsValue DECIMAL(18, 2) = (
        SELECT SUM(quantity * price)
        FROM OPENJSON(@stocks) WITH (
            quantity DECIMAL(18, 2),
            price DECIMAL(18, 2)
        )
    );

    DECLARE @cryptoValue DECIMAL(18, 2) = (
        SELECT SUM(quantity * price)
        FROM OPENJSON(@cryptos) WITH (
            quantity DECIMAL(18, 2),
            price DECIMAL(18, 2)
        )
    );

    DECLARE @portfolioValue DECIMAL(18, 2) = @stocksAndOptionsValue + @cryptoValue;

    DECLARE @current NVARCHAR(MAX) = N'{
        "stocks_and_options": {
            "percentage": ' + CONVERT(NVARCHAR(MAX), CAST(ROUND((@stocksAndOptionsValue / @portfolioValue) * 100, 2) AS DECIMAL(18, 2))) + ',
            "value": ' + CONVERT(NVARCHAR(MAX), @stocksAndOptionsValue) + '
        },
        "cryptocurrencies": {
            "percentage": ' + CONVERT(NVARCHAR(MAX), CAST(ROUND((@cryptoValue / @portfolioValue) * 100, 2) AS DECIMAL(18, 2))) + ',
            "value": ' + CONVERT(NVARCHAR(MAX), @cryptoValue) + '
        },
        "totalValue": ' + CONVERT(NVARCHAR(MAX), @portfolioValue) + '
    }';

    UPDATE Portfolios
    SET Valuation = JSON_MODIFY(Valuation, '$.current', JSON_QUERY(@current))
    WHERE Id = @portfolioId;

    UPDATE Portfolios
    SET Valuation = JSON_MODIFY(Valuation, '$.stocks', JSON_QUERY(@stocks))
    WHERE Id = @portfolioId;

    UPDATE Portfolios
    SET Valuation = JSON_MODIFY(Valuation, '$.cryptocurrencies', JSON_QUERY(@cryptos))
    WHERE Id = @portfolioId;

    DECLARE @timeSeries NVARCHAR(MAX) = N'[';

    DECLARE @changeFactor DECIMAL(6, 2) = 0.01;
    DECLARE @trendDirection INT = 1;

    DECLARE @currentValue DECIMAL(18, 2) = @previousValue;

    WHILE @startTime >= @endTime
    BEGIN
        DECLARE @changePercent DECIMAL(6, 2) = @trendDirection * ((ABS(CHECKSUM(NEWID()) % 200) - 100) / 100.0) * @changeFactor;
        DECLARE @change DECIMAL(18, 2) = @previousValue * @changePercent;
        SET @currentValue += @change;
        SET @previousValue = @currentValue;

        SET @timeSeries += N'{"timestamp": "' + REPLACE(CONVERT(NVARCHAR(19), @startTime, 126), 'T', ' ') + N'", "value": ' + CONVERT(NVARCHAR(MAX), @currentValue) + N'},';

        SET @startTime = DATEADD(MINUTE, @intervalMinutes, @startTime);
    END

    SET @timeSeries = LEFT(@timeSeries, LEN(@timeSeries) - 1) + N']}';

    UPDATE Portfolios
    SET Valuation = JSON_MODIFY(Valuation, '$.timeSeries', JSON_QUERY(@timeSeries))
    WHERE Id = @portfolioId;

    FETCH NEXT FROM @userCursor INTO @userId;
END

CLOSE @userCursor;
DEALLOCATE @userCursor;


-- Update here because we don't know the total value of cryptos until after the previous loops.
-- Now we know the total value of cryptos in the portfolio so we can calculate each cryptos percentage 
-- relative to the total value of cryptos
UPDATE Portfolios
SET Valuation = JSON_MODIFY(
    Valuation,
    '$.cryptocurrencies',
    JSON_QUERY(
        CONCAT(
            '{"numUnique": ', (
                SELECT COUNT(*)
                FROM OPENJSON(Valuation, '$.cryptocurrencies')
            ), ',',
            '"totalValue": ', (
                SELECT CAST(ROUND(SUM(quantity * price), 2) AS DECIMAL(18, 2))
                FROM OPENJSON(Valuation, '$.cryptocurrencies')
                WITH (
                    symbol NVARCHAR(50),
                    quantity DECIMAL(18, 2),
                    price DECIMAL(18, 2)
                )
            ), ',',
            '"percentOfPort": ', (
                SELECT CAST(ROUND(SUM(quantity * price) / JSON_VALUE(Valuation, '$.current.totalValue') * 100, 2) AS DECIMAL(18, 2))
                FROM OPENJSON(Valuation, '$.cryptocurrencies')
                WITH (
                    symbol NVARCHAR(50),
                    quantity DECIMAL(18, 2),
                    price DECIMAL(18, 2)
                )
            ), ',',
            '"items": ', (
                SELECT JSON_QUERY(
                    (
                        SELECT 
                            symbol, 
                            quantity, 
                            price, 
                            CAST(ROUND(quantity * price, 2) AS DECIMAL(18, 2)) AS totalValue,
                            CAST(ROUND((quantity * price) / (
                                SELECT SUM(quantity * price)
                                FROM OPENJSON(Valuation, '$.cryptocurrencies')
                                WITH (
                                    symbol NVARCHAR(50),
                                    quantity DECIMAL(18, 2),
                                    price DECIMAL(18, 2)
                                )
                            ) * 100, 2) AS DECIMAL(18, 2)) AS percentOfGroup
                        FROM OPENJSON(Valuation, '$.cryptocurrencies')
                        WITH (
                            symbol NVARCHAR(50),
                            quantity DECIMAL(18, 2),
                            price DECIMAL(18, 2)
                        )
                        FOR JSON PATH
                    )
                )
            ), '}'
        )
    )
)
WHERE Valuation IS NOT NULL;


UPDATE Portfolios
SET Valuation = JSON_MODIFY(
    Valuation,
    '$.stocks',
    JSON_QUERY(
        CONCAT(
            '{"numUnique": ', (
                SELECT COUNT(*)
                FROM OPENJSON(Valuation, '$.stocks')
            ), ',',
            '"totalValue": ', (
                SELECT CAST(ROUND(SUM(quantity * price), 2) AS DECIMAL(18, 2))
                FROM OPENJSON(Valuation, '$.stocks')
                WITH (
                    symbol NVARCHAR(50),
                    quantity DECIMAL(18, 2),
                    price DECIMAL(18, 2)
                )
            ), ',',
            '"percentOfPort": ', (
                SELECT CAST(ROUND(SUM(quantity * price) / JSON_VALUE(Valuation, '$.current.totalValue') * 100, 2) AS DECIMAL(18, 2))
                FROM OPENJSON(Valuation, '$.stocks')
                WITH (
                    symbol NVARCHAR(50),
                    quantity DECIMAL(18, 2),
                    price DECIMAL(18, 2)
                )
            ), ',',
            '"items": ', (
                SELECT JSON_QUERY(
                    (
                        SELECT 
                            symbol, 
                            quantity, 
                            price, 
                            CAST(ROUND(quantity * price, 2) AS DECIMAL(18, 2)) AS totalValue,
                            CAST(ROUND((quantity * price) / (
                                SELECT SUM(quantity * price)
                                FROM OPENJSON(Valuation, '$.stocks')
                                WITH (
                                    symbol NVARCHAR(50),
                                    quantity DECIMAL(18, 2),
                                    price DECIMAL(18, 2)
                                )
                            ) * 100, 2) AS DECIMAL(18, 2)) AS percentOfGroup
                        FROM OPENJSON(Valuation, '$.stocks')
                        WITH (
                            symbol NVARCHAR(50),
                            quantity DECIMAL(18, 2),
                            price DECIMAL(18, 2)
                        )
                        FOR JSON PATH
                    )
                )
            ), '}'
        )
    )
)
WHERE Valuation IS NOT NULL;
