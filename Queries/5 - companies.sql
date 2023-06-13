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

CREATE TABLE Assets (
    O DECIMAL(18, 2),                           -- Open price
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

INSERT INTO Companies (Id, SYM, Name, Description, Industry, EC, CEO, HQ, F, EH)
VALUES
    (1, 'GOOGL', 'Google', 'Google is a multinational technology company specializing in Internet-related services and products. It offers a wide range of services including search engines, online advertising technologies, cloud computing, software, and hardware.', 'Technology', 1000, 'Sundar Pichai', 'Mountain View, California, United States', '2000-09-04', 'Impressive'),
    (2, 'META', 'Meta', 'Meta, formerly known as Facebook, is a social media and technology company. It operates a range of social networking services, including Facebook, Instagram, WhatsApp, and more. Meta''s mission is to connect people and bring the world closer together.', 'Social Media', 2000, 'Mark Zuckerberg', 'Menlo Park, California, United States', '2004-02-04', 'Thriving'),
    (3, 'TSLA', 'Tesla', 'Tesla is an innovative electric vehicle and clean energy company. It designs, manufactures, and sells electric cars, solar energy products, and energy storage solutions. Tesla''s goal is to accelerate the world''s transition to sustainable energy.', 'Automotive', 5000, 'Elon Musk', 'Palo Alto, California, United States', '2003-07-01', 'Impressive'),
    (4, 'TSM', 'Taiwan Semiconductor', 'Taiwan Semiconductor is a leading semiconductor foundry. It manufactures integrated circuits and provides chip design services for various industries. TSMC plays a crucial role in advancing semiconductor technology worldwide.', 'Semiconductors', 1500, 'C.C. Wei', 'Hsinchu, Taiwan', '1987-02-21', 'Strong'),
    (5, 'NVDA', 'NVIDIA', 'NVIDIA is a leading technology company that specializes in designing graphics processing units (GPUs) for gaming, professional visualization, data centers, and automotive markets. Its advanced GPU technology powers a wide range of applications.', 'Technology', 3000, 'Jensen Huang', 'Santa Clara, California, United States', '1993-01-22', 'Impressive'),
    (6, 'HOOD', 'Robinhood', 'Robinhood is a popular commission-free stock trading and investing app. It provides an intuitive platform for buying and selling stocks, cryptocurrencies, and exchange-traded funds (ETFs). Robinhood aims to democratize finance and make investing accessible to all.', 'Finance', 2500, 'Vlad Tenev', 'Menlo Park, California, United States', '2013-04-18', 'Growth'),
    (7, 'COIN', 'Coinbase', 'Coinbase is a leading cryptocurrency exchange platform. It allows users to buy, sell, and trade various cryptocurrencies securely. Coinbase also offers a range of financial services and solutions for individuals and businesses in the crypto space.', 'Cryptocurrency', 4000, 'Brian Armstrong', 'San Francisco, California, United States', '2012-06-20', 'Evolving'),
    (8, 'JPM', 'JPMorgan Chase', 'JPMorgan Chase is one of the largest and oldest banking institutions in the United States. It provides a wide range of financial services, including investment banking, asset management, and retail banking. JPMorgan Chase is recognized for its global presence and diverse offerings.', 'Banking', 1800, 'Jamie Dimon', 'New York City, New York, United States', '2000-12-01', 'Stable'),
    (9, 'WMT', 'Walmart', 'Walmart is a multinational retail corporation known for its chain of hypermarkets, discount department stores, and grocery stores. It offers a wide range of products at affordable prices, aiming to provide convenient shopping experiences for customers worldwide.', 'Retail', 3500, 'Doug McMillon', 'Bentonville, Arkansas, United States', '1962-07-02', 'Profitable'),
    (10, 'XOM', 'ExxonMobil', 'ExxonMobil is a leading international oil and gas company. It is involved in various aspects of the energy industry, including exploration, production, refining, and marketing of petroleum products. ExxonMobil has a strong global presence and contributes to meeting the world''s energy needs.', 'Energy', 2800, 'Darren Woods', 'Irving, Texas, United States', '1999-11-30', 'Robust'),
    (11, 'AMZN', 'Amazon', 'Amazon is an American multinational technology company that focuses on e-commerce, cloud computing, digital streaming, and artificial intelligence. It is one of the world''s largest online marketplaces and is known for its fast and reliable delivery services.', 'Technology', 2500, 'Andy Jassy', 'Seattle, Washington, United States', '1994-07-05', 'Profitable'),
    (12, 'AAPL', 'Apple', 'Apple is a multinational technology company known for designing, manufacturing, and selling consumer electronics, computer software, and online services. It is widely recognized for its innovative products, including the iPhone, iPad, Mac, Apple Watch, and Apple TV.', 'Technology', 3000, 'Tim Cook', 'Cupertino, California, United States', '1976-04-01', 'Impressive'),
    (13, 'MSFT', 'Microsoft', 'Microsoft is a leading technology corporation that develops, manufactures, licenses, supports, and sells computer software, consumer electronics, personal computers, and related services. It is known for its popular software products like Windows, Office, and Azure.', 'Technology', 4000, 'Satya Nadella', 'Redmond, Washington, United States', '1975-04-04', 'Robust'),
    (14, 'BRK.A', 'Berkshire Hathaway', 'Berkshire Hathaway is a multinational conglomerate holding company. It owns a diverse range of businesses across various industries, including insurance, energy, manufacturing, retail, and transportation. Berkshire Hathaway is led by its chairman and CEO, Warren Buffett.', 'Conglomerate', 3500, 'Warren Buffett', 'Omaha, Nebraska, United States', '1839-05-10', 'Stable'),
    (15, 'WFC', 'Wells Fargo', 'Wells Fargo is one of the largest banks in the United States, offering a wide range of financial services including banking, investment, mortgage, and consumer and commercial finance. It operates a vast network of branches and ATMs throughout the country.', 'Banking', 2000, 'Charles Scharf', 'San Francisco, California, United States', '1852-03-18', 'Profitable'),
    (16, 'V', 'Visa', 'Visa is a global payments technology company that facilitates electronic funds transfers throughout the world. It provides secure and convenient digital payment solutions for individuals, businesses, and governments. Visa operates one of the largest electronic payment networks globally.', 'Financial Services', 1500, 'Al Kelly', 'Foster City, California, United States', '1958-09-18', 'Robust'),
    (17, 'JNJ', 'Johnson & Johnson', 'Johnson & Johnson is a global healthcare company that specializes in pharmaceuticals, medical devices, and consumer healthcare products. It is committed to improving the health and well-being of people worldwide through its innovative solutions.', 'Healthcare', 2300, 'Alex Gorsky', 'New Brunswick, New Jersey, United States', '1886-01-01', 'Stable'),
    (18, 'PG', 'Procter & Gamble', 'Procter & Gamble (P&G) is a multinational consumer goods company that offers a wide range of products including cleaning agents, personal care products, and pet supplies. P&G is known for its well-established brands such as Pampers, Tide, Gillette, and Crest.', 'Consumer Goods', 3200, 'David Taylor', 'Cincinnati, Ohio, United States', '1837-10-31', 'Profitable'),
    (19, 'BAC', 'Bank of America', 'Bank of America is one of the largest banks in the United States, providing a comprehensive range of financial services to individual consumers, small and middle-market businesses, and large corporations. It operates through multiple business segments.', 'Banking', 2100, 'Brian Moynihan', 'Charlotte, North Carolina, United States', '1904-10-17', 'Profitable'),
    (20, 'MA', 'Mastercard', 'Mastercard is a global financial technology company that provides payment solutions and services. It operates one of the world''s largest payment networks, enabling secure and convenient transactions for consumers, businesses, and governments.', 'Financial Services', 1600, 'Michael Miebach', 'Purchase, New York, United States', '1966-12-16', 'Robust'),
    (21, 'VZ', 'Verizon Communications', 'Verizon Communications is a leading telecommunications company that provides wireless communication, internet access, and other telecommunications services to consumers, businesses, and governments. It operates a robust network infrastructure across the United States.', 'Telecommunications', 1900, 'Hans Vestberg', 'New York City, New York, United States', '1983-10-07', 'Stable'),
    (22, 'T', 'AT&T', 'AT&T is a multinational telecommunications conglomerate that provides wireless communication, video, broadband, and other telecommunications services to consumers, businesses, and government agencies. It operates a vast network infrastructure across the United States and beyond.', 'Telecommunications', 2200, 'John Stankey', 'Dallas, Texas, United States', '1885-10-05', 'Profitable'),
    (23, 'KO', 'Coca-Cola', 'The Coca-Cola Company is a multinational beverage corporation known for its iconic carbonated soft drink, Coca-Cola. It offers a wide range of non-alcoholic beverages, including sparkling drinks, juices, teas, coffees, and energy drinks.', 'Beverages', 2700, 'James Quincey', 'Atlanta, Georgia, United States', '1886-01-29', 'Profitable'),
    (24, 'PFE', 'Pfizer', 'Pfizer is a global pharmaceutical company that develops, manufactures, and markets a wide range of prescription drugs, vaccines, and consumer healthcare products. It focuses on improving the health and well-being of people through innovative medical solutions.', 'Pharmaceuticals', 1400, 'Albert Bourla', 'New York City, New York, United States', '1849-04-02', 'Robust'),
    (25, 'HD', 'Home Depot', 'The Home Depot is a multinational home improvement retailer that offers a wide range of construction products, tools, and services. It operates a chain of large warehouse-style stores, catering to both professional contractors and do-it-yourself customers.', 'Retail', 2700, 'Craig Menear', 'Atlanta, Georgia, United States', '1978-06-22', 'Profitable'),
    (26, 'DIS', 'Walt Disney', 'The Walt Disney Company is a global entertainment and media conglomerate. It operates a diverse portfolio of businesses, including theme parks, film production, television networks, and streaming services. Disney is known for its beloved characters and storytelling.', 'Entertainment', 2100, 'Bob Chapek', 'Burbank, California, United States', '1923-10-16', 'Impressive'),
    (27, 'CSCO', 'Cisco Systems', 'Cisco Systems is a multinational technology company that designs, manufactures, and sells networking equipment and related services. It provides solutions for networking, security, collaboration, and the Internet of Things (IoT) to businesses of all sizes.', 'Technology', 1500, 'Chuck Robbins', 'San Jose, California, United States', '1984-12-10', 'Stable'),
    (28, 'CMCSA', 'Comcast', 'Comcast Corporation is a global media and technology company that provides cable television, internet, telephone, and other telecommunications services. It operates through various business segments, including cable communications, filmed entertainment, and theme parks.', 'Telecommunications', 1900, 'Brian Roberts', 'Philadelphia, Pennsylvania, United States', '1963-06-28', 'Robust'),
    (29, 'NKE', 'Nike', 'Nike is a multinational corporation that designs, manufactures, and markets athletic footwear, apparel, equipment, and accessories. It is one of the world''s largest suppliers of athletic shoes and apparel, catering to athletes and sports enthusiasts globally.', 'Apparel', 2400, 'John Donahoe', 'Beaverton, Oregon, United States', '1964-01-25', 'Impressive'),
    (30, 'MCD', 'McDonald''s', 'McDonald''s is a global fast-food restaurant chain known for its hamburgers, french fries, and other fast-food items. It operates thousands of restaurants worldwide, serving millions of customers each day. McDonald''s is a symbol of the fast-food industry.', 'Food Services', 3600, 'Chris Kempczinski', 'Chicago, Illinois, United States', '1940-04-15', 'Profitable'),
    (31, 'ORCL', 'Oracle', 'Oracle Corporation is a multinational technology company that specializes in developing and marketing database software, cloud infrastructure, and enterprise software products. It provides solutions for various industries, including finance, manufacturing, and retail.', 'Technology', 1700, 'Safra Catz', 'Redwood City, California, United States', '1977-06-16', 'Stable'),
    (32, 'IBM', 'IBM', 'IBM is a multinational technology company that provides hardware, software, and related services. It is known for its expertise in areas such as artificial intelligence, cloud computing, cybersecurity, and data analytics. IBM has a long history of technological innovation.', 'Technology', 2800, 'Arvind Krishna', 'Armonk, New York, United States', '1911-06-16', 'Robust'),
    (33, 'NFLX', 'Netflix', 'Netflix is a global streaming entertainment service that offers a wide variety of TV shows, movies, documentaries, and more. It revolutionized the way people consume entertainment by introducing the concept of streaming media on-demand.', 'Entertainment', 1800, 'Reed Hastings', 'Los Gatos, California, United States', '1997-08-29', 'Growth'),
    (34, 'ADBE', 'Adobe', 'Adobe Inc. is a multinational software company known for its creative software products. It offers industry-leading tools for graphic design, web development, video editing, and digital document management. Adobes software is widely used by creative professionals worldwide.', 'Technology', 1300, 'Shantanu Narayen', 'San Jose, California, United States', '1982-12-01', 'Impressive');

-- Insert assets for each companycompa
INSERT INTO Assets (SYM, CompanyId, MC, PE, DY, AV, HiDay, HiYear, LoDay, LoYear, O, V, Live, OneDay, AllData, OneWeek, OneYear, OneMonth, YearToDate, ThreeMonths)
SELECT
    c.SYM AS SYM,
    c.Id AS CompanyId,
    100.2 * c.Id AS MC,
    10.5 * c.Id AS PE,
    2.5 * c.Id AS DY,
    50.2 * c.Id AS AV,
    100.2 * c.Id AS HiDay,
    200.2 * c.Id AS HiYear,
    80.2 * c.Id AS LoDay,
    150.2 * c.Id AS LoYear,
    90.2 * c.Id AS O,
    10000.2 * c.Id AS V,
    N'{
        "sym": "' + c.SYM + '",
        "period": "live",
        "name": "' + c.Name + '",
        "o": 0.00,
        "l": 0.00,
        "h": 0.00,
        "c": 0.00,
        "vwa": 0.00,
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
    }'
FROM Companies AS c;

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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
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
        "series": [
            {
                "o": 0.00,
                "l": 0.00,
                "h": 0.00,
                "c": 0.00,
                "vwa": 0.00,
                "time": ""
            }
        ]
    }' AS AllData
FROM Assets AS a
JOIN Companies AS c ON a.CompanyId = c.Id;

SELECT * FROM OrderBooks;


