using AutoMapper;
using Common.Models;
using DataAccess.UnitOfWork;
using Services.Interfaces;

namespace Services.Services
{
    public class PortfolioService : IPortfolioService
    {
        private readonly IMapper _mapper;
        private readonly IUnitOfWork _unitOfWork;
        
        public PortfolioService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
        }
        
        public PortfolioDTO GetPortfolioById(int id, String period)
        {
            var portfolio = _unitOfWork.PortfolioRepository.GetPortfolioById(id, period);
            return _mapper.Map<PortfolioDTO>(portfolio);
        }

        public PortfolioDTO AddPortfolio(PortfolioDTO portfolioDto)
        {
            var portfolio = _unitOfWork.PortfolioRepository.Add(portfolioDto);
            return _mapper.Map<PortfolioDTO>(portfolio);
        }

        public PortfolioDTO UpdatePortfolio(int id, PortfolioDTO portfolioDto)
        {
            var portfolio = _unitOfWork.PortfolioRepository.Update(id, portfolioDto);
            return _mapper.Map<PortfolioDTO>(portfolio);
        }

        public void DeletePortfolio(int id)
        {
            _unitOfWork.PortfolioRepository.Delete(id);
        }

        public IEnumerable<PortfolioDTO> GetAllPortfolios()
        {
            var portfolios = _unitOfWork.PortfolioRepository.GetAll();
            var portfolioDTOs = _mapper.Map<IEnumerable<PortfolioDTO>>(portfolios);
            return portfolioDTOs;
        }
    }
}