CREATE TABLE Lists (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    UserId INT NOT NULL,
    Symbols NVARCHAR(MAX) NOT NULL
        CONSTRAINT DF_Lists_Symbols DEFAULT '[]' 
);

INSERT INTO Lists (Name, UserId, Symbols)
VALUES ('My List', 1, '["AAPL", "GOOGL", "BAC"]');
