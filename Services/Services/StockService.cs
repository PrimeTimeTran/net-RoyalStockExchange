using AutoMapper;

using Common.Models;
using DataAccess.UnitOfWork;
using Services.Interfaces;

namespace Services.Services;

public class StockService : IStockService
{
    private readonly IMapper _mapper;
    private readonly IUnitOfWork _unitOfWork;
    
    public StockService(IUnitOfWork unitOfWork, IMapper mapper)
    {
        _unitOfWork = unitOfWork;
        _mapper = mapper;
    }
    
    public StockDTO GetStockById(int id)
    {
        var stock = _unitOfWork.StockRepository.GetById(id);

        return _mapper.Map<StockDTO>(stock);
    }

    public void CreateStock(StockDTO stockDto)
    {
        throw new NotImplementedException();
    }

    public void UpdateStock(int id, StockDTO stockDto)
    {
        throw new NotImplementedException();
    }

    public void DeleteStock(int id)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<StockDTO> GetAll()
    {
        try
        {
            var stocks = _unitOfWork.StockRepository.GetAll();
            var stockDTOs = _mapper.Map<IEnumerable<StockDTO>>(stocks);
            return stockDTOs;
        }
        catch (Exception ex)
        {
            // Log or handle the exception appropriately
            // You can also throw a custom exception or return an error response
            throw new Exception("An error occurred while retrieving stocks.", ex);
        }
    }
}