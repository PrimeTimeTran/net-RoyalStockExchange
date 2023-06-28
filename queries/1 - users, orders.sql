CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    BillingAddress VARCHAR(255),
    PhoneNumber VARCHAR(20),
    SocialSecurityNumber VARCHAR(11) NOT NULL,
    Email VARCHAR(255) NOT NULL
);

INSERT INTO Users (FirstName, LastName, SocialSecurityNumber, Email)
VALUES 
    ('Loi', 'Tran', '000-00-0000', 'loi@mail.com'), 
    ('Tai', 'Tran', '000-00-0000', 'tai@mail.com'), 
    ('Thao', 'Tran', '000-00-0000', 'thao@mail.com'), 
    ('Hieu', 'Tran', '000-00-0000', 'hieu@mail.com'), 
    ('Doug', 'Tran', '000-00-0000', 'doug@mail.com');

CREATE TABLE Orders (
    UserId INT NOT NULL,
    OrderableId INT NOT NULL,
    StopVal DECIMAL(10, 2),
    LimitVal DECIMAL(10, 2),
    StrikeVal DECIMAL(10, 2),
    TotalVal DECIMAL(10, 2),
    OrderableVal DECIMAL(10, 2),
    Expires DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Quantity DECIMAL(10, 2) NOT NULL,
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    Intent VARCHAR(10) NOT NULL CHECK (Intent IN ('buy', 'sell')),
    OrderableType VARCHAR(10) NOT NULL CHECK (OrderableType IN ('stock', 'option', 'bond', 'crypto')),
    Type VARCHAR(10) NOT NULL CHECK (Type IN ('market', 'limit', 'stop loss', 'stop limit', 'trailing stop')),
);

INSERT INTO Orders (UserId, OrderableId, OrderableType, Status, Type, StopVal, LimitVal, Quantity, Expires, Intent)
VALUES
    (1, 1, 'stock', 'filled', 'market', NULL, 15.0, 10.0, '2023-05-31 12:00:00', 'buy'),
    (2, 2, 'stock', 'filled', 'limit', 50.00, 50.00, 5.0, '2023-06-01 15:30:00', 'buy'),
    (1, 3, 'stock', 'cancelled', 'limit', 28.0, 28.10, 8.0, '2023-06-02 10:45:00', 'buy');

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