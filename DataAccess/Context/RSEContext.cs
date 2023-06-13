using DataAccess.Entities;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;

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
        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            var decimalProperties = typeof(Asset)
                .GetProperties()
                .Where(p => p.PropertyType == typeof(decimal));

            foreach (var property in decimalProperties)
            {
                modelBuilder.Entity<Asset>()
                    .Property<decimal>(property.Name)
                    .HasColumnType("decimal(18, 2)");
            }
        }
    }
}
