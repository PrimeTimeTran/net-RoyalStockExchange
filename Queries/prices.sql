DROP TABLE IF EXISTS Prices;

CREATE TABLE Prices (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    PriceableId INT NOT NULL,
    PriceableType VARCHAR(10) NOT NULL CHECK (PriceableType IN ('Stock', 'Option', 'Bond')),

    TransactionCount INT NOT NULL,
    DateOfAggregation DATETIME NOT NULL,
    O DECIMAL(18, 2) NOT NULL,              -- open
    L DECIMAL(18, 2) NOT NULL,              -- lo
    H DECIMAL(18, 2) NOT NULL,              -- hi
    C DECIMAL(18, 2) NOT NULL,              -- close
    V DECIMAL(18, 2) NOT NULL,              -- volume
    Vwa DECIMAL(18, 2) NOT NULL             -- volume weighted average
);

DECLARE @count INT = 0;
DECLARE @weekAgo DATETIME = GETDATE() - 7;

DECLARE @price DECIMAL(10, 2) = 27.00;
DECLARE @open DECIMAL(10, 2) = @price;
DECLARE @lo DECIMAL(10, 2) = 0.0;
DECLARE @hi DECIMAL(10, 2) = 0.0;
DECLARE @close DECIMAL(10, 2) = 0.0;

WHILE @count < 30
BEGIN    
    SET @price = @price -0.10 + (RAND() * (.10 - (-0.15)));
    SET @close = @price;

    SET @lo = @price -0.05 + (RAND() * (-0.1));
    SET @hi = @price -0.05 + (RAND() * (.1));

    INSERT INTO Prices (
        PriceableId,
        PriceableType,
        TransactionCount,
        DateOfAggregation,
        O,
        L,
        V,
        H,
        C,
        Vwa
    )
    VALUES (
        1,
        'Stock',
        100,
        @weekAgo,
        @open,
        CASE WHEN @open < @lo THEN @open ELSE @lo END,
        1000,
        CASE WHEN @close > @hi THEN @close ELSE @hi END,
        @close,
        140
    );

    SET @open = @close;

    SET @count = @count + 1;
    SET @weekAgo = DATEADD(HOUR, 1, @weekAgo);
END;