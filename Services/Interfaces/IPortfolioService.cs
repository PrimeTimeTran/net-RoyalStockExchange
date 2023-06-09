using Common.Models;
using System.Collections.Generic;

namespace Services.Interfaces
{
    public interface IPortfolioService 
    {
        PortfolioDTO GetPortfolioById(int id);
        PortfolioDTO AddPortfolio(PortfolioDTO portfolioDto);
        PortfolioDTO UpdatePortfolio(int id, PortfolioDTO portfolioDto);
        void DeletePortfolio(int id);
        IEnumerable<PortfolioDTO> GetAllPortfolios();
    }
}