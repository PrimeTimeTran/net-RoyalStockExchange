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
        _mapper = mapper;
        _unitOfWork = unitOfWork;
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
        var stock = _unitOfWork.StockRepository.Update(id, s);
        return _mapper.Map<StockDTO>(stock);

    }

    public void Delete(int id)
    {
        _unitOfWork.StockRepository.Delete(id);
    }

    public IEnumerable<StockDTO> GetAll()
    {
        var stocks = _unitOfWork.StockRepository.GetAll();
        var stockDTOs = _mapper.Map<IEnumerable<StockDTO>>(stocks);
        return stockDTOs;
    }
}