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
                case "1d":
                    portfolio = portfolioQuery.Select(p => new Portfolio { OneDay = p.OneDay }).FirstOrDefault();
                    break;
                case "1w":
                    portfolio = portfolioQuery.Select(p => new Portfolio { OneWeek = p.OneWeek }).FirstOrDefault();
                    break;
                case "1m":
                    portfolio = portfolioQuery.Select(p => new Portfolio { OneMonth = p.OneMonth }).FirstOrDefault();
                    break;
                case "3m":
                    portfolio = portfolioQuery.Select(p => new Portfolio { ThreeMonths = p.ThreeMonths }).FirstOrDefault();
                    break;
                case "ytd":
                    portfolio = portfolioQuery.Select(p => new Portfolio { YTD = p.YTD }).FirstOrDefault();
                    break;                
                case "1y":
                    portfolio = portfolioQuery.Select(p => new Portfolio { OneYear = p.OneYear }).FirstOrDefault();
                    break;
                case "all":
                    portfolio = portfolioQuery.Select(p => new Portfolio { AllData = p.AllData }).FirstOrDefault();
                    break;
                default:
                    portfolio = portfolioQuery.Select(p => new Portfolio { Live = p.Live, Valuation = p.Valuation }).FirstOrDefault();
                    break;
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
