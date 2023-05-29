using AutoMapper;
using DataAccess.Context;
using DataAccess.Entities;
using Common.Models;

namespace DataAccess.Repositories;
public class StockRepository : IStockRepository
{
    private readonly IMapper _mapper;
    private readonly RseContext _context;

    public StockRepository(RseContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
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

    public StockDTO Add(StockDTO s)
    {
        Stock stock = _mapper.Map<Stock>(s);
        Stock addedStock = _context.Stocks.Add(stock).Entity;
        _context.SaveChanges();
        return _mapper.Map<StockDTO>(addedStock);
    }

    public StockDTO Update(int id, StockDTO s)
    {
        Stock stockToUpdate = _context.Stocks.Find(id);
        if (stockToUpdate == null)
        {
            // Stock not found, handle the error accordingly
            // For example, throw an exception or return an error response
            // ...
        }

        stockToUpdate.Name = s.Name;
        stockToUpdate.Price = s.Price;
        stockToUpdate.Quantity = s.Quantity;

        _context.SaveChanges();

        StockDTO updatedStockDTO = _mapper.Map<StockDTO>(stockToUpdate);

        return updatedStockDTO;
    }

    public void Delete(int id)
    {
        Stock stockToDelete = _context.Stocks.Find(id);
        if (stockToDelete == null)
        {
            // Stock not found, handle the error accordingly
            // For example, throw an exception or return an error response
            // ...
        }

        _context.Stocks.Remove(stockToDelete);
        _context.SaveChanges();
    }

}