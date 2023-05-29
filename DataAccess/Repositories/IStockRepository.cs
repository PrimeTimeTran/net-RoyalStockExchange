using Common.Models;
using DataAccess.Entities;

namespace DataAccess.Repositories;
public interface IStockRepository
{
    Stock GetById(int id);
    IEnumerable<Stock> GetAll();
    StockDTO Add(StockDTO stock);
    StockDTO Update(int id, StockDTO stock);
    void Delete(int id);
}