# Royal Stock Exchange(RSE)

## Dependencies

- Docker
- .NET Core 7
- Azure SQL Edge
- Rider/Visual Studio

## TODO

- Run project
- Initialize DB
- Create routes
- Create models

## Database

How to setup dev DB.

Use [Docker SQL Server](https://github.com/microsoft/mssql-docker/issues/668)

Run container

```sh
docker run -d --name mssql-server --platform linux/arm64/v8 -e ACCEPT_EULA=Y -e SA_PASSWORD=reallyStrongPwd123 -p 1433:1433 mcr.microsoft.com/azure-sql-edge
```

SSH into db

```sh
sqlcmd -U sa -P reallyStrongPwd123 -S 127.0.0.1,1433 -C
```

[Cheatsheet](https://www.mssqltips.com/sqlservertip/7432/sql-cheat-sheet-sql-server-tsql-commands/)

create database RSE;
GO

use RSE;
GO

SELECT name FROM sys.tables;
GO


Setup DB with Entity framework
https://www.youtube.com/watch?v=qkJ9keBmQWo&ab_channel=IAmTimCorey

Query DB from controller
https://makingloops.com/refactoring-db-calls-out-of-controllers/

Connection string for dev
> Server=localhost; Database=RSE; User Id=sa; Password=reallyStrongPwd123; TrustServerCertificate=true