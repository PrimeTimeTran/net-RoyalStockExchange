# Royal Stock Exchange(RSE)

## Dependencies

- .NET Core 7
- Docker(for SQL Server/Azure SQL Edge db)
- Rider/Visual Studio
- Azure Data Studio

## TODO

- Create routes

## Database

How to setup dev database(db).

Use [Docker SQL Server](https://github.com/microsoft/mssql-docker/issues/668)

Run db container

```sh
docker run -d --name mssql-server --platform linux/arm64/v8 -e ACCEPT_EULA=Y -e SA_PASSWORD=reallyStrongPwd123 -p 1433:1433 mcr.microsoft.com/azure-sql-edge
```

SSH into db

```sh
sqlcmd -U sa -P reallyStrongPwd123 -S 127.0.0.1,1433 -C
```

Create db

```sh
create database RSE;
GO
```

Use db

```sh
use RSE;
GO
```

View all db tables
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
