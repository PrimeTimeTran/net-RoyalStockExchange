DROP TABLE IF EXISTS OrderBooks;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Assets;
DROP TABLE IF EXISTS Companies;
DROP TABLE IF EXISTS Lists;
DROP TABLE IF EXISTS Portfolios;

DROP TABLE IF EXISTS Trades;
DROP TABLE IF EXISTS Notifications;
DROP TABLE IF EXISTS Users;

-- Add asset histories to each company
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateLiveSeriesForCompany]') AND type = N'P')
    DROP PROCEDURE [dbo].[UpdateLiveSeriesForCompany];
GO
    
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GeneratePortfolioItems]') AND type = N'P')
    DROP PROCEDURE [dbo].[GeneratePortfolioItems];
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GenerateTimePeriod]') AND type = N'P')
    DROP PROCEDURE [dbo].[GenerateTimePeriod];
GO

UPDATE Assets
SET [Meta] = N'{
    "MC": "100.0",
    "PE": "",
    "DY": "",
    "O": "100.0",
    "V": "",
    "AV": "",
    "VWA": "",
    "HiDay": "",
    "HiYear": "",
    "LoDay": "",
    "LoYear": ""
}';

UPDATE Assets
SET [Live] = N'{
    "sym": "",
    "period": "live",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [OneDay] = N'{
    "sym": "",
    "period": "1d",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [OneWeek] = N'{
    "sym": "",
    "period": "1w",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [OneMonth] = N'{
    "sym": "",
    "period": "1m",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [ThreeMonths] = N'{
    "sym": "",
    "period": "3m",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [YearToDate] = N'{
    "sym": "",
    "period": "ytd",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';
UPDATE Assets
SET [OneYear] = N'{
    "sym": "",
    "period": "1y",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';

UPDATE Assets
SET [AllData] = N'{
    "sym": "",
    "period": "all",
    "name": "",
    "o": 0.00,
    "l": 0.00,
    "h": 0.00,
    "c": 0.00,
    "vwa": 0.00,
    "v": 0.00,
    "series": []
}';