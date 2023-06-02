using Common.Models;
using System.Collections.Generic;

namespace Services.Interfaces;
public interface IPriceService
{
    PriceDTO GetPriceById(int id);
    PriceDTO Add(PriceDTO priceDto);
    PriceDTO Update(int id, PriceDTO priceDto);
    void Delete(int id);
    IEnumerable<PriceDTO> GetAll();
}
