using Common.Models;
using DataAccess.Entities;

namespace Services.Interfaces;
public interface IStockService
{
    StockDTO GetStockById(int id);
    StockDTO Add(StockDTO stockDto);
    StockDTO Update(int id, StockDTO stockDto);
    void Delete(int id);
    IEnumerable<StockDTO> GetAll();
}
