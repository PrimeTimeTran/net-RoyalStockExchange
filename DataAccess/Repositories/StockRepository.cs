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
        _mapper = mapper;
        _context = context;
    }

    public IEnumerable<Stock> GetAll()
    {
        var stocks = _context.Stocks;
        
        return stocks;
    }

    public Stock GetById(int id)
    {
        return _context.Stocks.FirstOrDefault(s => s.Id == id);
    }

    public Stock Add(StockDTO s)
    {
        Stock stock = _mapper.Map<Stock>(s);
        Stock addedStock = _context.Stocks.Add(stock).Entity;
        _context.SaveChanges();
        return addedStock;
    }
    
    public Stock Update(int id, StockDTO s)
    {
        Stock stock = _context.Stocks.Find(id);
        if (stock == null)
        {
        }

        var stockProps = typeof(Stock).GetProperties();
        var dtoProps = typeof(StockDTO).GetProperties();

        foreach (var prop in dtoProps)
        {
            if (prop.Name == "Id")
                continue;

            var stockProp = stockProps.FirstOrDefault(p => p.Name == prop.Name);
            if (stockProp != null && prop.GetValue(s) != null)
            {
                stockProp.SetValue(stock, prop.GetValue(s));
            }
        }

        _context.SaveChanges();

        return stock;
    }

    public void Delete(int id)
    {
        Stock s = _context.Stocks.Find(id);
        if (s == null)
        {
        }
        _context.Stocks.Remove(s);
        _context.SaveChanges();
    }
}