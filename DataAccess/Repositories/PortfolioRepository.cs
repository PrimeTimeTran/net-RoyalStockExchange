using AutoMapper;
using DataAccess.Context;
using DataAccess.Entities;
using Common.Models;

namespace DataAccess.Repositories
{
    public class PortfolioRepository : IPortfolioRepository
    {
        private readonly IMapper _mapper;
        private readonly RseContext _context;

        public PortfolioRepository(RseContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public IEnumerable<Portfolio> GetAll()
        {
            var portfolios = _context.Portfolios;
            return portfolios;
        }

        public Portfolio GetPortfolioById(int id, String period = "live")
        {
            var portfolioQuery = _context.Portfolios.Where(p => p.Id == id);
            
            Portfolio portfolio;

            switch (period)
            {
                case "live":
                    portfolio = portfolioQuery.Select(p => new Portfolio { Valuation = p.Valuation, Live = p.Live }).FirstOrDefault();
                    break;
                case "1d":
                    portfolio = portfolioQuery.Select(p => new Portfolio { Valuation = p.Valuation, OneDay = p.OneDay }).FirstOrDefault();
                    break;
                case "1w":
                    portfolio = portfolioQuery.Select(p => new Portfolio { Valuation = p.Valuation, OneWeek = p.OneWeek }).FirstOrDefault();
                    break;
                case "1m":
                    portfolio = portfolioQuery.Select(p => new Portfolio { Valuation = p.Valuation, OneMonth = p.OneMonth }).FirstOrDefault();
                    break;
                case "3m":
                    portfolio = portfolioQuery.Select(p => new Portfolio { Valuation = p.Valuation, ThreeMonths = p.ThreeMonths }).FirstOrDefault();
                    break;
                case "ytd":
                    portfolio = portfolioQuery.Select(p => new Portfolio { Valuation = p.Valuation, YTD = p.YTD }).FirstOrDefault();
                    break;                
                case "1y":
                    portfolio = portfolioQuery.Select(p => new Portfolio { Valuation = p.Valuation, OneYear = p.OneYear }).FirstOrDefault();
                    break;
                default:
                    return null;
            }

            return portfolio;
        }

        public Portfolio Add(PortfolioDTO dto)
        {
            var portfolio = _mapper.Map<Portfolio>(dto);
            var addedPortfolio = _context.Portfolios.Add(portfolio).Entity;
            _context.SaveChanges();
            return addedPortfolio;
        }

        public Portfolio Update(int id, PortfolioDTO dto)
        {
            var portfolio = _context.Portfolios.Find(id);
            if (portfolio == null)
            {
                // Handle not found case
                return null;
            }

            var portfolioProps = typeof(Portfolio).GetProperties();
            var dtoProps = typeof(PortfolioDTO).GetProperties();

            foreach (var prop in dtoProps)
            {
                if (prop.Name == "Id")
                    continue;

                var portfolioProp = portfolioProps.FirstOrDefault(p => p.Name == prop.Name);
                if (portfolioProp != null && prop.GetValue(dto) != null)
                {
                    portfolioProp.SetValue(portfolio, prop.GetValue(dto));
                }
            }

            _context.SaveChanges();

            return portfolio;
        }

        public void Delete(int id)
        {
            var portfolio = _context.Portfolios.Find(id);
            if (portfolio == null)
            {
                // Handle not found case
                return;
            }

            _context.Portfolios.Remove(portfolio);
            _context.SaveChanges();
        }
    }
}
