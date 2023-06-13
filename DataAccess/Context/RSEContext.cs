using Microsoft.EntityFrameworkCore;
using DataAccess.Entities;

namespace DataAccess.Context
{
    public class RseContext : DbContext
    {
        public DbSet<Stock> Stocks { get; set; }
        public DbSet<Asset> Assets { get; set; }
        public DbSet<Portfolio> Portfolios { get; set; }

        
        public RseContext(DbContextOptions<RseContext> options) : base(options)
        {
        }
    }
}
