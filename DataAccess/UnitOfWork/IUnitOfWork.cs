using System;
using DataAccess.Repositories;

namespace DataAccess.UnitOfWork;

public interface IUnitOfWork : IDisposable
{
    IStockRepository StockRepository { get; }
    IPriceRepository PriceRepository { get; }
    IPortfolioRepository PortfolioRepository { get; }

    // void Save() {};
}