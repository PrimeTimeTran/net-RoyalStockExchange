using DataAccess.Context;
using DataAccess.Repositories;

namespace DataAccess.UnitOfWork;
public class UnitOfWork : IUnitOfWork
    {
        private readonly RseContext _context;
        private IStockRepository _stockRepository;

        public UnitOfWork(RseContext context)
        {
            _context = context;
        }

        public IStockRepository StockRepository
        {
            get
            {
                if (_stockRepository == null)
                {
                    _stockRepository = new StockRepository(_context);
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
