using AutoMapper;

using Common.Models;
using DataAccess.UnitOfWork;
using Services.Interfaces;
using DataAccess.Entities;

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

    public StockDTO Add(StockDTO s)
    {
        var stock = _unitOfWork.StockRepository.Add(s);
        return _mapper.Map<StockDTO>(stock);
    }

    public StockDTO Update(int id, StockDTO s)
    {
        return _unitOfWork.StockRepository.Update(id, s);
    }

    public void Delete(int id)
    {
        _unitOfWork.StockRepository.Delete(id);
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