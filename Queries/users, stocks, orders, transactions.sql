DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Stocks;

CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FName VARCHAR(255) NOT NULL,
    LName VARCHAR(255) NOT NULL
);

INSERT INTO Users (FName, LName)
VALUES 
    ('Loi', 'Tran'), 
    ('Tai', 'Tran'),
    ('Thao', 'Tran'), 
    ('Hieu', 'Tran'), 
    ('Doug', 'Tran');

CREATE TABLE Stocks (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    Name NVARCHAR(30),
    Price DECIMAL(18, 2),
    Quantity INT,
    Symbol NVARCHAR(20)
);

INSERT INTO Stocks (Name, Price, Quantity, Symbol)
VALUES
    ('Ford', 12.51, 75, 'F'),
    ('Coinbase', 64.21, 100, 'COIN'),
    ('Bank of America', 28.5, 100, 'BAC');

CREATE TABLE Orders (
    Expires DATETIME,
    UserId INT NOT NULL,
    Shares INT NOT NULL,
    OrderableId INT NOT NULL,
    StopPrice DECIMAL(10, 2),
    LimitPrice DECIMAL(10, 2),
    Status VARCHAR(20) NOT NULL,
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    OrderType VARCHAR(10) NOT NULL CHECK (OrderType IN ('buy', 'sell')),
    OrderableType VARCHAR(10) NOT NULL CHECK (OrderableType IN ('stock', 'option', 'bond')),
    Type VARCHAR(10) NOT NULL CHECK (Type IN ('market', 'limit', 'stop loss', 'stop limit', 'trailing stop'))
);

INSERT INTO Orders (UserId, OrderableId, OrderableType, Status, Type, StopPrice, LimitPrice, Shares, Expires, OrderType)
VALUES
    (1, 1, 'stock', 'filled', 'market', NULL, 15.0, 10, '2023-05-31 12:00:00', 'buy'),
    (2, 2, 'stock', 'filled', 'limit', 50.00, 50.00, 5, '2023-06-01 15:30:00', 'buy'),
    (1, 3, 'stock', 'cancelled', 'limit', 28.0, 28.10, 8, '2023-06-02 10:45:00', 'buy');

CREATE TABLE Transactions (
    user_id INT,
    timestamp DATETIME,
    symbol NVARCHAR(20),
    price DECIMAL(18, 2),
    order_id INT NOT NULL,
    buyer_id INT NOT NULL,
    seller_id INT NOT NULL,
    quantity DECIMAL(18, 2),
    transaction_type NVARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES [Users](Id),
    FOREIGN KEY (order_id) REFERENCES Orders(Id),
    Id INT PRIMARY KEY IDENTITY(1, 1)
);

-- Insert transactions corresponding to the orders
INSERT INTO Transactions (user_id, timestamp, symbol, price, order_id, buyer_id, seller_id, quantity, transaction_type)
SELECT
    O.UserId AS user_id,
    GETDATE() AS timestamp,
    S.Symbol AS symbol,
    S.Price AS price,
    O.Id AS order_id,
    CASE WHEN O.OrderType = 'buy' THEN O.UserId ELSE NULL END AS buyer_id,
    CASE WHEN O.OrderType = 'sell' THEN O.UserId ELSE -1 END AS seller_id,
    O.Shares AS quantity,
    'filled' AS transaction_type
FROM
    Orders AS O
    INNER JOIN Stocks AS S ON O.OrderableId = S.Id
WHERE
    O.Status = 'filled'
    AND O.Shares > 0
    AND O.Id NOT IN (SELECT order_id FROM Transactions)
    AND (O.OrderType = 'sell' OR O.OrderType = 'buy' AND O.Status <> 'cancelled');
