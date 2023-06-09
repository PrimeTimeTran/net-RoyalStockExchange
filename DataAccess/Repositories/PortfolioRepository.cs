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

        public Portfolio GetPortfolioById(int id)
        {
            return _context.Portfolios.FirstOrDefault(p => p.Id == id);
        }

        public Portfolio Add(PortfolioDTO portfolioDTO)
        {
            var portfolio = _mapper.Map<Portfolio>(portfolioDTO);
            var addedPortfolio = _context.Portfolios.Add(portfolio).Entity;
            _context.SaveChanges();
            return addedPortfolio;
        }

        public Portfolio Update(int id, PortfolioDTO portfolioDTO)
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
                if (portfolioProp != null && prop.GetValue(portfolioDTO) != null)
                {
                    portfolioProp.SetValue(portfolio, prop.GetValue(portfolioDTO));
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
