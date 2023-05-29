using AutoMapper;
using DataAccess.Entities;
using Common.Models;

namespace Services;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<Stock, StockDTO>();  // Map Stock entity to StockDTO
        CreateMap<StockDTO, Stock>();  // Map StockDTO to Stock entity
    }
}
