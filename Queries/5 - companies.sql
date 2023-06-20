-- Drop tables if they exist
IF OBJECT_ID('Companies', 'U') IS NOT NULL
DROP TABLE Companies;

IF OBJECT_ID('Assets', 'U') IS NOT NULL
DROP TABLE Assets;

IF OBJECT_ID('OrderBooks', 'U') IS NOT NULL
DROP TABLE OrderBooks;

-- Create Companies table
CREATE TABLE Companies (
                           EC INT,                                     -- Employee count
                           F DATE,                                     -- Founded
                           HQ VARCHAR(255),                            -- Headquarters
                           CEO VARCHAR(255),                           -- 
                           EH VARCHAR(255),                            -- Earnings History
                           SYM VARCHAR(255),                           -- 
                           Name VARCHAR(255),                          --
                           Id INT PRIMARY KEY,                         --
                           Industry VARCHAR(255),                      --
                           Description NVARCHAR(MAX),                  --
);

INSERT INTO Companies (Id, F, SYM, Industry, Name, HQ, CEO, EH, EC, Description)
VALUES
    (1, '2000-09-04', 'GOOGL', 'Technology', 'Google', 'Mountain View, California, United States', 'Sundar Pichai', 'Impressive', 1000, 'Google is a multinational technology company specializing in Internet-related services and products. It offers a wide range of services including search engines, online advertising technologies, cloud computing, software, and hardware.'),
    (2, '2004-02-04', 'META', 'Social Media', 'Meta', 'Menlo Park, California, United States', 'Mark Zuckerberg', 'Thriving', 2000, 'Meta, formerly known as Facebook, is a social media and technology company. It operates a range of social networking services, including Facebook, Instagram, WhatsApp, and more. Meta''s mission is to connect people and bring the world closer together.'),
    (3, '2003-07-01', 'TSLA', 'Automotive', 'Tesla', 'Palo Alto, California, United States', 'Elon Musk', 'Impressive', 5000, 'Tesla is an innovative electric vehicle and clean energy company. It designs, manufactures, and sells electric cars, solar energy products, and energy storage solutions. Tesla''s goal is to accelerate the world''s transition to sustainable energy.'),
    (4, '1987-02-21', 'TSM', 'Semiconductors', 'Taiwan Semiconductor', 'Hsinchu, Taiwan', 'C.C. Wei', 'Strong', 1500, 'Taiwan Semiconductor is a leading semiconductor foundry. It manufactures integrated circuits and provides chip design services for various industries. TSMC plays a crucial role in advancing semiconductor technology worldwide.'),
    (5, '1993-01-22', 'NVDA', 'Technology', 'NVIDIA', 'Santa Clara, California, United States', 'Jensen Huang', 'Impressive', 3000, 'NVIDIA is a leading technology company that specializes in designing graphics processing units (GPUs) for gaming, professional visualization, data centers, and automotive markets. Its advanced GPU technology powers a wide range of applications.'),
    (6, '2013-04-18', 'HOOD', 'Finance', 'Robinhood', 'Menlo Park, California, United States', 'Vlad Tenev', 'Growth', 2500, 'Robinhood is a popular commission-free stock trading and investing app. It provides an intuitive platform for buying and selling stocks, cryptocurrencies, and exchange-traded funds (ETFs). Robinhood aims to democratize finance and make investing accessible to all.'),
    (7, '2012-06-20', 'COIN', 'Cryptocurrency', 'Coinbase', 'San Francisco, California, United States', 'Brian Armstrong', 'Evolving', 4000, 'Coinbase is a leading cryptocurrency exchange platform. It allows users to buy, sell, and trade various cryptocurrencies securely. Coinbase also offers a range of financial services and solutions for individuals and businesses in the crypto space.'),
    (8, '2000-12-01', 'JPM', 'Banking', 'JPMorgan Chase', 'New York City, New York, United States', 'Jamie Dimon', 'Thriving', 4000, 'JPMorgan Chase is one of the largest and oldest banking institutions in the United States. It provides a wide range of financial services, including investment banking, asset management, and retail banking. JPMorgan Chase is recognized for its global presence and diverse offerings.'),
    (9, '1962-07-02', 'WMT', 'Retail', 'Walmart', 'Bentonville, Arkansas, United States', 'Doug McMillon', 'Profitable', 3500, 'Walmart is a multinational retail corporation known for its chain of hypermarkets, discount department stores, and grocery stores. It offers a wide range of products at affordable prices, aiming to provide convenient shopping experiences for customers worldwide.'),
    (10, '1999-11-30', 'XOM', 'Energy', 'ExxonMobil', 'Irving, Texas, United States', 'Darren Woods', 'Robust',  2800, 'ExxonMobil is a leading international oil and gas company. It is involved in various aspects of the energy industry, including exploration, production, refining, and marketing of petroleum products. ExxonMobil has a strong global presence and contributes to meeting the worlds energy needs.'),
    (11, '1994-07-05', 'AMZN', 'Technology', 'Amazon', 'Seattle, Washington, United States', 'Andy Jassy', 'Profitable', 2500, 'Amazon is an American multinational technology company that focuses on e-commerce, cloud computing, digital streaming, and artificial intelligence. It is one of the worlds largest online marketplaces and is known for its fast and reliable delivery services.'),
    (12, '1976-04-01', 'AAPL', 'Technology', 'Apple', 'Cupertino, California, United States', 'Tim Cook', 'Impressive', 3000, 'Apple is a multinational technology company known for designing, manufacturing, and selling consumer electronics, computer software, and online services. It is widely recognized for its innovative products, including the iPhone, iPad, Mac, Apple Watch, and Apple TV.'),
    (13, '1975-04-04', 'MSFT', 'Technology', 'Microsoft', 'Redmond, Washington, United States', 'Satya Nadella', 'Robust',  4000, 'Microsoft is a leading technology corporation that develops, manufactures, licenses, supports, and sells computer software, consumer electronics, personal computers, and related services. It is known for its popular software products like Windows, Office, and Azure.'),
    (14, '1839-05-10', 'BRK.A', 'Conglomerate', 'Berkshire Hathaway', 'Omaha, Nebraska, United States', 'Warren Buffett',  'Stable', 3500, 'Berkshire Hathaway is a multinational conglomerate holding company. It owns a diverse range of businesses across various industries, including insurance, energy, manufacturing, retail, and transportation. Berkshire Hathaway is led by its chairman and CEO, Warren Buffett.'),
    (15, '1852-03-18', 'WFC', 'Banking', 'Wells Fargo', 'San Francisco, California, United States', 'Charles Scharf', 'Profitable', 2000, 'Wells Fargo is one of the largest banks in the United States, offering a wide range of financial services including banking, investment, mortgage, and consumer and commercial finance. It operates a vast network of branches and ATMs throughout the country.'),
    (16, '1958-09-18', 'V', 'Financial Services', 'Visa', 'Foster City, California, United States', 'Al Kelly', 'Robust', 1500, 'Visa is a global payments technology company that facilitates electronic funds transfers throughout the world. It provides secure and convenient digital payment solutions for individuals, businesses, and governments. Visa operates one of the largest electronic payment networks globally.'),
    (17, '1886-01-01', 'JNJ', 'Healthcare', 'Johnson & Johnson', 'New Brunswick, New Jersey, United States', 'Alex Gorsky', 'Stable', 2300, 'Johnson & Johnson is a global healthcare company that specializes in pharmaceuticals, medical devices, and consumer healthcare products. It is committed to improving the health and well-being of people worldwide through its innovative solutions.'),
    (18, '1837-10-31', 'PG', 'Consumer Goods', 'Procter & Gamble', 'Cincinnati, Ohio, United States', 'David Taylor', 'Profitable', 3200, 'Procter & Gamble (P&G) is a multinational consumer goods company that offers a wide range of products including cleaning agents, personal care products, and pet supplies. P&G is known for its well-established brands such as Pampers, Tide, Gillette, and Crest.'),
    (19, '1904-10-17', 'BAC', 'Banking', 'Bank of America', 'Charlotte, North Carolina, United States', 'Brian Moynihan', 'Profitable', 2100, 'Bank of America is one of the largest banks in the United States, providing a comprehensive range of financial services to individual consumers, small and middle-market businesses, and large corporations. It operates through multiple business segments.'),
    (20, '1966-12-16', 'MA', 'Financial Services', 'Mastercard', 'Purchase, New York, United States', 'Michael Miebach', 'Robust', 1600, 'Mastercard is a global financial technology company that provides payment solutions and services. It operates one of the world''s largest payment networks, enabling secure and convenient transactions for consumers, businesses, and governments.'),
    (21, '1983-10-07', 'VZ', 'Telecommunications', 'Verizon Communications', 'New York City, New York, United States', 'Hans Vestberg', 'Stable', 1900, 'Verizon Communications is a leading telecommunications company that provides wireless communication, internet access, and other telecommunications services to consumers, businesses, and governments. It operates a robust network infrastructure across the United States.'),
    (22, '1885-10-05', 'T', 'Telecommunications', 'AT&T', 'Dallas, Texas, United States', 'John Stankey', 'Profitable', 2200, 'AT&T is a multinational telecommunications conglomerate that provides wireless communication, video, broadband, and other telecommunications services to consumers, businesses, and government agencies. It operates a vast network infrastructure across the United States and beyond.'),
    (23, '1886-01-29', 'KO', 'Beverages', 'Coca-Cola', 'Atlanta, Georgia, United States', 'James Quincey', 'Profitable', 2700, 'The Coca-Cola Company is a multinational beverage corporation known for its iconic carbonated soft drink, Coca-Cola. It offers a wide range of non-alcoholic beverages, including sparkling drinks, juices, teas, coffees, and energy drinks.'),
    (24, '1849-04-02', 'PFE', 'Pharmaceuticals', 'Pfizer', 'New York City, New York, United States', 'Albert Bourla', 'Robust', 1400, 'Pfizer is a global pharmaceutical company that develops, manufactures, and markets a wide range of prescription drugs, vaccines, and consumer healthcare products. It focuses on improving the health and well-being of people through innovative medical solutions.'),
    (25, '1978-06-22', 'HD', 'Retail', 'Home Depot', 'Atlanta, Georgia, United States', 'Craig Menear', 'Profitable', 2700, 'The Home Depot is a multinational home improvement retailer that offers a wide range of construction products, tools, and services. It operates a chain of large warehouse-style stores, catering to both professional contractors and do-it-yourself customers.'),
    (26, '1923-10-16', 'DIS', 'Entertainment', 'Walt Disney', 'Burbank, California, United States', 'Bob Chapek', 'Impressive', 2100, 'The Walt Disney Company is a global entertainment and media conglomerate. It operates a diverse portfolio of businesses, including theme parks, film production, television networks, and streaming services. Disney is known for its beloved characters and storytelling.'),
    (27, '1984-12-10', 'CSCO', 'Technology', 'Cisco Systems', 'San Jose, California, United States', 'Chuck Robbins', 'Stable', 1500, 'Cisco Systems is a multinational technology company that designs, manufactures, and sells networking equipment and related services. It provides solutions for networking, security, collaboration, and the Internet of Things (IoT) to businesses of all sizes.'),
    (28, '1963-06-28', 'CMCSA', 'Telecommunications', 'Comcast', 'Philadelphia, Pennsylvania, United States', 'Brian Roberts', 'Robust', 1900, 'Comcast Corporation is a global media and technology company that provides cable television, internet, telephone, and other telecommunications services. It operates through various business segments, including cable communications, filmed entertainment, and theme parks.'),
    (29, '1964-01-25', 'NKE', 'Apparel', 'Nike', 'Beaverton, Oregon, United States', 'John Donahoe', 'Impressive', 2400, 'Nike is a multinational corporation that designs, manufactures, and markets athletic footwear, apparel, equipment, and accessories. It is one of the world''s largest suppliers of athletic shoes and apparel, catering to athletes and sports enthusiasts globally.'),
    (30, '1940-04-15', 'MCD', 'Food Services', 'McDonald''s', 'Chicago, Illinois, United States', 'Chris Kempczinski', 'Profitable', 3600, 'McDonald''s is a global fast-food restaurant chain known for its hamburgers, french fries, and other fast-food items. It operates thousands of restaurants worldwide, serving millions of customers each day. McDonald''s is a symbol of the fast-food industry.'),
    (31, '1977-06-16', 'ORCL', 'Technology', 'Oracle', 'Redwood City, California, United States', 'Safra Catz', 'Stable', 1700, 'Oracle Corporation is a multinational technology company that specializes in developing and marketing database software, cloud infrastructure, and enterprise software products. It provides solutions for various industries, including finance, manufacturing, and retail.'),
    (32, '1911-06-16', 'IBM', 'Technology', 'IBM', 'Armonk, New York, United States', 'Arvind Krishna', 'Robust', 2800, 'IBM is a multinational technology company that provides hardware, software, and related services. It is known for its expertise in areas such as artificial intelligence, cloud computing, cybersecurity, and data analytics. IBM has a long history of technological innovation.'),
    (33, '1997-08-29', 'NFLX', 'Entertainment', 'Netflix', 'Los Gatos, California, United States', 'Reed Hastings', 'Growth', 1800, 'Netflix is a global streaming entertainment service that offers a wide variety of TV shows, movies, documentaries, and more. It revolutionized the way people consume entertainment by introducing the concept of streaming media on-demand.'),
    (34, '1982-12-01', 'ADBE', 'Technology', 'Adobe', 'San Jose, California, United States', 'Shantanu Narayen', 'Impressive', 1300, 'Adobe Inc. is a multinational software company known for its creative software products. It offers industry-leading tools for graphic design, web development, video editing, and digital document management. Adobes software is widely used by creative professionals worldwide.');

CREATE TABLE Assets (
                        O DECIMAL(18, 2),                           -- Open price
                        L DECIMAL(18, 2),                           -- Open low
                        H DECIMAL(18, 2),                           -- Open high
                        C DECIMAL(18, 2),                           -- Open close
                        V DECIMAL(18, 2),                           -- Volume
                        MC DECIMAL(18, 2),                          -- Market cap
                        PE DECIMAL(18, 2),                          -- P/E Ratio
                        DY DECIMAL(18, 2),                          -- Dividend
                        AV DECIMAL(18, 2),                          -- Average Volume
                        HiDay DECIMAL(18, 2),                       -- Daily High
                        LoDay DECIMAL(18, 2),                       -- Daily Low
                        HiYear DECIMAL(18, 2),                      -- Yearly High
                        LoYear DECIMAL(18, 2),                      -- Yearly Low
                        VWA DECIMAL(18, 2),                         -- Volume Weighted Average
                        CompanyId INT,
                        SYM VARCHAR(10),
                        Id INT IDENTITY(1, 1) PRIMARY KEY,
                        Live NVARCHAR(MAX),                         -- Price history from last 3 hours
                        OneDay NVARCHAR(MAX),                       -- Price history from start of day starting 12:00am
                        AllData NVARCHAR(MAX),                      -- Price history all time
                        OneWeek NVARCHAR(MAX),                      -- Price history from minus 7 days ago til today
                        OneYear NVARCHAR(MAX),                      -- Price history from today minus 1 year to today
                        OneMonth NVARCHAR(MAX),                     -- Price history from today minus 1 month to today
                        YearToDate NVARCHAR(MAX),                   -- Price history from start of this year til today
                        ThreeMonths NVARCHAR(MAX)                   -- Price history from three months ago til today
);

-- Insert assets for each company
INSERT INTO Assets (SYM, CompanyId, MC, PE, DY, AV, HiDay, HiYear, LoDay, LoYear, O, V, L, H, C, Live, OneDay, AllData, OneWeek, OneYear, OneMonth, YearToDate, ThreeMonths)
SELECT
    c.SYM AS SYM,
    c.Id AS CompanyId,
    100.2 * c.Id AS MC,
    10.5 * c.Id AS PE,
    2.5 * c.Id AS DY,
    50.2 * c.Id AS AV,
    55.2 * c.Id AS HiDay,
    60.2 * c.Id AS HiYear,
    30.2 * c.Id AS LoDay,
    10.2 * c.Id AS LoYear,
    32.2 * c.Id AS O,
    10000.2 * c.Id AS V,
    10.3 * c.Id As [L],
    51.3 * c.Id As [H],
    61.2 * c.Id As [C],
    N'{
        "sym": "' + c.SYM + '",
        "period": "live",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }',
    N'{
        "sym": "' + c.SYM + '",
        "period": "1d",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }',
    N'{
        "sym": "' + c.SYM + '",
        "period": "all",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }',
    N'{
        "sym": "' + c.SYM + '",
        "period": "1w",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }',
    N'{
        "sym": "' + c.SYM + '",
        "period": "1y",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }',
    N'{
        "sym": "' + c.SYM + '",
        "period": "1m",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }',
    N'{
        "sym": "' + c.SYM + '",
        "period": "ytd",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }',
    N'{
        "sym": "' + c.SYM + '",
        "period": "3m",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }'
FROM Companies AS c;

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

DECLARE companyCursor CURSOR FOR
SELECT id FROM Companies;

OPEN companyCursor;

FETCH NEXT FROM companyCursor INTO @companyId;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update Live field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'Live';

    -- Update OneDay field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'OneDay';

    -- Update OneWeek field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'OneWeek';

    -- Update OneMonth field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'OneMonth';

    -- Update ThreeMonths field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'ThreeMonths';

    -- Update YearToDate field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'YearToDate';

    -- Update OneYear field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'OneYear';

    -- Update AllData field
EXEC UpdateLiveSeriesForCompany @companyId, @outputValue = @result OUTPUT, @fieldToUpdate = 'AllData';

FETCH NEXT FROM companyCursor INTO @companyId;
END

CLOSE companyCursor;
DEALLOCATE companyCursor;

-- Create OrderBooks table
CREATE TABLE OrderBooks (
                            AssetId INT,
                            Live NVARCHAR(MAX),                         -- Price history from last 3 hours
                            OneDay NVARCHAR(MAX),                       -- Price history from start of day starting 12:00am
                            AllData NVARCHAR(MAX),                      -- Price history all time
                            OneWeek NVARCHAR(MAX),                      -- Price history from minus 7 days ago til today
                            OneYear NVARCHAR(MAX),                      -- Price history from today minus 1 year to today
                            OneMonth NVARCHAR(MAX),                     -- Price history from today minus 1 month to today
                            YearToDate NVARCHAR(MAX),                   -- Price history from start of this year til today
                            ThreeMonths NVARCHAR(MAX),                  -- Price history from three months ago til today
                            Id INT IDENTITY(1, 1) PRIMARY KEY,
);

-- Insert order books for each asset
INSERT INTO OrderBooks (assetId, Live, OneDay, OneWeek, OneMonth, ThreeMonths, YearToDate, OneYear, AllData)
SELECT
    a.Id AS AssetId,
    N'{
        "sym": "' + a.SYM + '",
        "period": "live",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }' AS Live,
    N'{
        "sym": "' + a.SYM + '",
        "period": "1d",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }' AS OneDay,
    N'{
        "sym": "' + a.SYM + '",
        "period": "1w",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }' AS OneWeek,
    N'{
        "sym": "' + a.SYM + '",
        "period": "1m",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }' AS OneMonth,
    N'{
        "sym": "' + a.SYM + '",
        "period": "3m",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }' AS ThreeMonths,
    N'{
        "sym": "' + a.SYM + '",
        "period": "ytd",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }' AS YearToDate,
    N'{
        "sym": "' + a.SYM + '",
        "period": "1y",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }' AS OneYear,
    N'{
        "sym": "' + a.SYM + '",
        "period": "all",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": []
    }' AS AllData
FROM Assets AS a
         JOIN Companies AS c ON a.CompanyId = c.Id;

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


