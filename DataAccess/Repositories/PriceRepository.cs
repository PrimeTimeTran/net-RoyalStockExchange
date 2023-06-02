using AutoMapper;
using DataAccess.Context;
using DataAccess.Entities;
using Common.Models;
using System.Collections.Generic;
using System.Linq;

namespace DataAccess.Repositories
{
    public class PriceRepository : IPriceRepository
    {
        private readonly IMapper _mapper;
        private readonly RseContext _context;

        public PriceRepository(RseContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }

        public IEnumerable<Price> GetAll()
        {
            var prices = _context.Prices;
            return prices;
        }

        public Price GetById(int id)
        {
            return _context.Prices.FirstOrDefault(p => p.Id == id);
        }

        public Price Add(PriceDTO priceDto)
        {
            Price price = _mapper.Map<Price>(priceDto);
            Price addedPrice = _context.Prices.Add(price).Entity;
            _context.SaveChanges();
            return addedPrice;
        }

        public Price Update(int id, PriceDTO priceDto)
        {
            Price price = _context.Prices.Find(id);
            if (price == null)
            {
                // Handle not found scenario
            }

            var priceProps = typeof(Price).GetProperties();
            var dtoProps = typeof(PriceDTO).GetProperties();

            foreach (var prop in dtoProps)
            {
                if (prop.Name == "Id")
                    continue;

                var priceProp = priceProps.FirstOrDefault(p => p.Name == prop.Name);
                if (priceProp != null && prop.GetValue(priceDto) != null)
                {
                    priceProp.SetValue(price, prop.GetValue(priceDto));
                }
            }

            _context.SaveChanges();

            return price;
        }

        public void Delete(int id)
        {
            Price price = _context.Prices.Find(id);
            if (price == null)
            {
                // Handle not found scenario
            }

            _context.Prices.Remove(price);
            _context.SaveChanges();
        }
    }
}
