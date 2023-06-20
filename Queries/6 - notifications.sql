DROP TABLE IF EXISTS Notifications;

-- Create Notifications table
CREATE TABLE Notifications (
    UserId INT,
    Id INT PRIMARY KEY,
    Time DATETIME,
    Status BIT,
    Body VARCHAR(255),
    CompanyId INT
);

-- Generate 100 notifications for all users in the database
INSERT INTO Notifications (UserId, Id, Time, Status, Body, CompanyId)
SELECT TOP 100
    Users.Id AS UserId,
    ROW_NUMBER() OVER (ORDER BY Users.Id) AS Id,
    GETDATE() AS Time,
    0 AS Status,
    CONCAT('Hello, ', Users.FirstName, ' ', Users.LastName, '!') AS Body,
    Companies.Id AS CompanyId
FROM Users, Companies;
