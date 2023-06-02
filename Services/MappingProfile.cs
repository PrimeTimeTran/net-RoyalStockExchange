using AutoMapper;
using DataAccess.Entities;
using Common.Models;

namespace Services;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<Stock, StockDTO>();
        CreateMap<StockDTO, Stock>();
        CreateMap<Price, PriceDTO>();
        CreateMap<PriceDTO, Price>();
    }
}
