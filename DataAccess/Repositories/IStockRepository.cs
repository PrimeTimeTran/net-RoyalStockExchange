using DataAccess.Entities;

namespace DataAccess.Repositories;

public interface IStockRepository
{
    Stock GetById(int id);
    IEnumerable<Stock> GetAll();
    void Add(Stock stock);
    void Update(Stock stock);
    void Delete(Stock stock);
}