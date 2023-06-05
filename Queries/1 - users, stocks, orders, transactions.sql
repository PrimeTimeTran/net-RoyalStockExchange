DROP TABLE IF EXISTS Portfolios;
DROP TABLE IF EXISTS Trades;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Stocks;
DROP TABLE IF EXISTS Lists;
DROP TABLE IF EXISTS Users;

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

CREATE TABLE Stocks (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    Name NVARCHAR(30),
    Price DECIMAL(18, 2),
    Quantity DECIMAL(18, 2),
    Symbol NVARCHAR(20)
);

INSERT INTO Stocks (Name, Price, Quantity, Symbol)
VALUES
    ('Ford', 12.51, 75, 'F'),
    ('Coinbase', 64.21, 100, 'COIN'),
    ('Bank of America', 28.5, 100, 'BAC'),
    ('Google', 124.03, 100, 'GOOGL'),
    ('Meta', 270.14, 100, 'META'),
    ('Apple', 181.32, 100, 'AAPL'),
    ('Amazon', 124.25, 100, 'AMZN'),
    ('Tesla', 212.87, 100, 'TSLA');

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

CREATE TABLE Trades (
    BuyerId INT,
    SellerId INT,
    UserId INT NOT NULL,
    OrderId INT NOT NULL,
    Timestamp DATETIME,
    Symbol NVARCHAR(20),
    Price DECIMAL(18, 2),
    Quantity DECIMAL(18, 2) NOT NULL,
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (BuyerId) REFERENCES Users(Id),
    FOREIGN KEY (SellerId) REFERENCES Users(Id)
);

INSERT INTO Trades (UserId, Timestamp, Symbol, Price, OrderId, BuyerId, SellerId, Quantity)
SELECT
    O.UserId AS UserId,
    GETDATE() AS Timestamp,
    S.Symbol AS Symbol,
    S.Price AS Price,
    O.Id AS OrderId,
    CASE WHEN O.Intent = 'buy' THEN O.UserId END AS BuyerId,
    CASE WHEN O.Intent = 'sell' THEN O.UserId ELSE NULL END AS SellerId,
    O.Quantity AS Quantity
FROM
    Orders AS O
    INNER JOIN Stocks AS S ON O.OrderableId = S.Id
WHERE
    O.Status = 'filled'
    AND O.Quantity > 0
    AND O.Id NOT IN (SELECT OrderId FROM Trades)
    AND (O.Intent = 'sell' OR (O.Intent = 'buy' AND O.Status <> 'cancelled'));
