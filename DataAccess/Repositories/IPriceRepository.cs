using Common.Models;
using DataAccess.Entities;
using System.Collections.Generic;

namespace DataAccess.Repositories
{
    public interface IPriceRepository
    {
        Price GetById(int id);
        IEnumerable<Price> GetAll();
        Price Add(PriceDTO price);
        Price Update(int id, PriceDTO price);
        void Delete(int id);
    }
}
