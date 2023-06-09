using AutoMapper;

using DataAccess.Context;
using DataAccess.Repositories;

namespace DataAccess.UnitOfWork;
public class UnitOfWork : IUnitOfWork
    {
        private readonly RseContext _context;
        private readonly IMapper _mapper;
        private IStockRepository _stockRepository;
        private IPriceRepository _priceRepository;
        private IPortfolioRepository _portfolioRepository;

        public UnitOfWork(RseContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
            _stockRepository = new StockRepository(_context, _mapper);
            _priceRepository = new PriceRepository(_context, _mapper);
            _portfolioRepository = new PortfolioRepository(_context, _mapper);
        }

        public IStockRepository StockRepository
        {
            get
            {
                if (_stockRepository == null)
                {
                    _stockRepository = new StockRepository(_context, _mapper);
                }
                return _stockRepository;
            }
        }
        
        public IPriceRepository PriceRepository
        {
            get
            {
                if (_priceRepository == null)
                {
                    _priceRepository = new PriceRepository(_context, _mapper);
                }
                return _priceRepository;
            }
        }

        public IPortfolioRepository PortfolioRepository 
        {
            get
            {
                if (_portfolioRepository == null)
                {
                    _portfolioRepository = new PortfolioRepository(_context, _mapper);
                }
                return _portfolioRepository;
            }
        }
        
        public void Save()
        {
            throw new NotImplementedException();
        }

        // Other repositories or additional methods, if applicable

        public void SaveChanges()
        {
            _context.SaveChanges();
        }

        public void Dispose()
        {
            // throw new NotImplementedException();
        }
    }
