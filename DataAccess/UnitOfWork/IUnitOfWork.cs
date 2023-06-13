using System;
using DataAccess.Repositories;

namespace DataAccess.UnitOfWork;

public interface IUnitOfWork : IDisposable
{
    IStockRepository StockRepository { get; }
    IAssetRepository AssetRepository { get; }
    IPortfolioRepository PortfolioRepository { get; }
}