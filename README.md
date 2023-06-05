# Royal Stock Exchange(RSE)

Entry point is API/Program.cs

## Dependencies

- .NET 7
- Azure Data Studio
- Rider/Visual Studio
- Docker(for SQL Server/Azure SQL Edge db)

## Database

How to setup the SQL Server using Docker & Azure SQL Edge image.

- Run SQL Server Container

  ```sh
  docker run -d --name mssql-server --platform linux/arm64/v8 -e ACCEPT_EULA=Y -e SA_PASSWORD=reallyStrongPwd123 -p 1433:1433 mcr.microsoft.com/azure-sql-edge
  ```

- SSH into db

  ```sh
  sqlcmd -U sa -P reallyStrongPwd123 -S 127.0.0.1,1433 -C
  ```

- Create db

  ```sh
  create database RSE;
  GO
  ```

- Use db

  ```sh
  use RSE;
  GO
  ```

- View all db tables

  ```sh
  SELECT name FROM sys.tables;
  GO
  ```

Connection string for dev using DB GUI(Rider, Azure Data Studio, etc.)

> Server=localhost; Database=RSE; User Id=sa; Password=reallyStrongPwd123; TrustServerCertificate=true

## References

[SQL Server Commands](https://www.mssqltips.com/sqlservertip/7432/sql-cheat-sheet-sql-server-tsql-commands/)
[Setup DB with Entity framework](https://www.youtube.com/watch?v=qkJ9keBmQWo&ab_channel=IAmTimCorey)
[Query DB from controller](https://makingloops.com/refactoring-db-calls-out-of-controllers/)

## Testing

## Math

- Expected stock price records per year.

  start time - close time = number of trading hours per day

        9:30am - 4:00pm = 6.5

  hours per trading day x minutes per hour = minutes in trading day

        6.5 x 60 = 390

  minutes trading day x trading days per year = number of minute prices of stock per year

        390 x 252 = 98280

- Number of companies on NYSE & NASDAQ.

  Nasdaq count + NYSE count = Total Stocks

        3,300 + 2800 = 6100
