using System;
using DataAccess.Repositories;

namespace DataAccess.UnitOfWork;

public interface IUnitOfWork : IDisposable
{
    IStockRepository StockRepository { get; }
    // void Save() {};
}