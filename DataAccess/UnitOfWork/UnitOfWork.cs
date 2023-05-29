using AutoMapper;

using DataAccess.Context;
using DataAccess.Repositories;

namespace DataAccess.UnitOfWork;
public class UnitOfWork : IUnitOfWork
    {
        private readonly RseContext _context;
        private readonly IMapper _mapper;
        private IStockRepository _stockRepository;

        public UnitOfWork(RseContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
            _stockRepository = new StockRepository(_context, _mapper);
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
