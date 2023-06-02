-- Cleanse
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Stocks;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Prices;

-- Users
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FName VARCHAR(255) NOT NULL,
    LName VARCHAR(255) NOT NULL
);

INSERT INTO Users (FName, LName)
VALUES 
    ('Loi', 'Tran'), 
    ('Thao', 'Tran');

-- Orders
CREATE TABLE Orders (
    Expires DATETIME,
    Shares INT NOT NULL,
    UserId INT NOT NULL,
    StopPrice DECIMAL(10, 2),
    OrderableId INT NOT NULL,
    Type VARCHAR(20) NOT NULL,
    LimitPrice DECIMAL(10, 2),
    Status VARCHAR(20) NOT NULL,
    Id INT PRIMARY KEY IDENTITY(1, 1),
    OrderType VARCHAR(10) NOT NULL CHECK (OrderType IN ('Buy', 'Sell'))
    OrderableType VARCHAR(10) NOT NULL CHECK (OrderableType IN ('Stock', 'Option', 'Bond')),
);

-- Stocks
CREATE TABLE Stocks (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    Name NVARCHAR(30),
    Price DECIMAL(18, 2),
    Quantity INT,
    Symbol NVARCHAR(20)
);

-- Seed Stocks Data
INSERT INTO Stocks (Name, Price, Quantity, Symbol)
VALUES
    ('ABC Company', 150.00, 100, 'ABC'),
    ('XYZ Corporation', 75.50, 50, 'XYZ'),
    ('DEF Inc.', 120.25, 75, 'DEF');

-- Seed Orders Data
INSERT INTO Orders (UserId, OrderableId, OrderableType, Status, Type, StopPrice, LimitPrice, Shares, Expires, OrderType)
VALUES
    (1, 1, 'Stock', 'Filled', 'Buy', NULL, 100.00, 10, '2023-05-31 12:00:00', 'Buy'),
    (2, 2, 'Option', 'Non-filled', 'Limit', NULL, 50.00, 5, '2023-06-01 15:30:00', 'Buy'),
    (1, 3, 'Bond', 'Cancelled', 'Stop Loss', 70.00, NULL, 8, '2023-06-02 10:45:00', 'Buy');

-- Prices
CREATE TABLE Prices (
    StockId INT NOT NULL,
    DailyPrice DECIMAL(18, 2),
    HourlyPrice DECIMAL(18, 2),
    WeeklyPrice DECIMAL(18, 2),
    YearlyPrice DECIMAL(18, 2),
    MonthlyPrice DECIMAL(18, 2),
    FiveYearsPrice DECIMAL(18, 2),
    TransactionCount INT NOT NULL,
    FiveMinutePrice DECIMAL(18, 2),
    Volume DECIMAL(18, 2) NOT NULL,
    ThreeMonthsPrice DECIMAL(18, 2),
    Id INT PRIMARY KEY IDENTITY(1, 1),
    LowPrice DECIMAL(18, 2) NOT NULL,
    OpenPrice DECIMAL(18, 2) NOT NULL,
    ClosePrice DECIMAL(18, 2) NOT NULL,
    HighPrice DECIMAL(18, 2) NOT NULL,
    DateOfAggregation DATETIME NOT NULL,
    VolumeWeightedAverage DECIMAL(18, 2) NOT NULL
);

