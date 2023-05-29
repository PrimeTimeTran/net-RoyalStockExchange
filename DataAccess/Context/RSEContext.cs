using Microsoft.EntityFrameworkCore;
using DataAccess.Entities;

namespace DataAccess.Context
{
    public class RseContext : DbContext
    {
        public DbSet<Stock> Stocks { get; set; }
        // Add DbSet properties for other entities

        public RseContext(DbContextOptions<RseContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configure entity mappings and relationships
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(RseContext).Assembly);

            base.OnModelCreating(modelBuilder);
        }
    }
}
