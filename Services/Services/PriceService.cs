using AutoMapper;
using Common.Models;
using DataAccess.UnitOfWork;
using Services.Interfaces;

namespace Services.Services
{
    public class PriceService : IPriceService
    {
        private readonly IMapper _mapper;
        private readonly IUnitOfWork _unitOfWork;
        
        public PriceService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
        }
        
        public PriceDTO GetPriceById(int id)
        {
            var price = _unitOfWork.PriceRepository.GetById(id);
            return _mapper.Map<PriceDTO>(price);
        }

        public PriceDTO Add(PriceDTO priceDto)
        {
            var price = _unitOfWork.PriceRepository.Add(priceDto);
            return _mapper.Map<PriceDTO>(price);
        }

        public PriceDTO Update(int id, PriceDTO priceDto)
        {
            var price = _unitOfWork.PriceRepository.Update(id, priceDto);
            return _mapper.Map<PriceDTO>(price);
        }

        public void Delete(int id)
        {
            _unitOfWork.PriceRepository.Delete(id);
        }

        public IEnumerable<PriceDTO> GetAll()
        {
            var prices = _unitOfWork.PriceRepository.GetAll();
            var priceDTOs = _mapper.Map<IEnumerable<PriceDTO>>(prices);
            return priceDTOs;
        }
    }
}
