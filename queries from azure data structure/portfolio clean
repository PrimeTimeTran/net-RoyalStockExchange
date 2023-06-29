-- SETUP table and portfolios
DROP TABLE IF EXISTS Portfolios;

CREATE TABLE Portfolios
(
    UserId      INT NOT NULL,
    Id          INT PRIMARY KEY IDENTITY(1, 1),
    CreatedAt   DATETIME DEFAULT GETDATE(),
    Valuation   NVARCHAR( MAX) NOT NULL DEFAULT N'{}',
    CONSTRAINT FK_Portfolio_Users FOREIGN KEY (UserId) REFERENCES Users (Id),
    Live        NVARCHAR( MAX),
    OneDay      NVARCHAR( MAX),
    OneWeek     NVARCHAR( MAX),
    OneMonth    NVARCHAR( MAX),
    ThreeMonths NVARCHAR( MAX),
    YTD         NVARCHAR( MAX),
    OneYear     NVARCHAR( MAX),
    AllData     NVARCHAR( MAX)
);

DECLARE @id INT;

DECLARE userCursor CURSOR FOR
SELECT id
FROM Users;

OPEN userCursor;

FETCH NEXT FROM userCursor INTO @id;

WHILE @@FETCH_STATUS = 0
BEGIN
INSERT INTO [Portfolios] (UserId)
VALUES (@id);

FETCH NEXT FROM userCursor INTO @id;
END;

CLOSE userCursor;
DEALLOCATE userCursor;

select top (5) * from portfolios;