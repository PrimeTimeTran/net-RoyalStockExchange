using System.Collections.Generic;
using Common.Models;
using DataAccess.Entities;

namespace DataAccess.Repositories
{
    public interface IPortfolioRepository
    {
        IEnumerable<Portfolio> GetAll();
        Portfolio GetPortfolioById(int id);
        Portfolio Add(PortfolioDTO portfolioDTO);
        Portfolio Update(int id, PortfolioDTO portfolioDTO);
        void Delete(int id);
    }
}