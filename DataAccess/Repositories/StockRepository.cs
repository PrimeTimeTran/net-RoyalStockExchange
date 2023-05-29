using System.Linq;
using DataAccess.Context;
using DataAccess.Entities;

namespace DataAccess.Repositories;

public class StockRepository : IStockRepository
{
    private readonly RseContext _context;

    public StockRepository(RseContext context)
    {
        _context = context;
    }

    public IEnumerable<Stock> GetAll()
    {
        var stocks = _context.Stocks;
        
        foreach (var stock in stocks)
        {
            Console.WriteLine($"Stock Id: {stock.Id}, Name: {stock.Name}, Price: {stock.Price}, Quantity: {stock.Quantity}");
        }

        return stocks;
    }

    public Stock GetById(int id)
    {
        return _context.Stocks.FirstOrDefault(s => s.Id == id);
    }

    public void Add(Stock stock)
    {
        _context.Stocks.Add(stock);
    }

    public void Update(Stock stock)
    {
        _context.Stocks.Update(stock);
    }

    public void Delete(Stock stock)
    {
        _context.Stocks.Remove(stock);
    }
}