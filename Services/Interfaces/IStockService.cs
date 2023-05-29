using Common.Models;
using System.Collections.Generic;

namespace Services.Interfaces;

public interface IStockService
{
    StockDTO GetStockById(int id);
    void CreateStock(StockDTO stockDto);
    void UpdateStock(int id, StockDTO stockDto);
    void DeleteStock(int id);
    IEnumerable<StockDTO> GetAll();
    // Other service methods
}
