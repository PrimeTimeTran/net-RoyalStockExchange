using AutoMapper;
using Common.Models;
using DataAccess.UnitOfWork;
using Services.Interfaces;

namespace Services.Services
{
    public class AssetService : IAssetService
    {
        private readonly IMapper _mapper;
        private readonly IUnitOfWork _unitOfWork;
        
        public AssetService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
        }

        public AssetDTO Add(AssetDTO dto)
        {
            var asset = _unitOfWork.AssetRepository.Add(dto);
            return _mapper.Map<AssetDTO>(asset);
        }

        public AssetDTO Update(int id, AssetDTO dto)
        {
            var asset = _unitOfWork.AssetRepository.Update(id, dto);
            return _mapper.Map<AssetDTO>(asset);
        }

        public void Delete(int id)
        {
            _unitOfWork.AssetRepository.Delete(id);
        }

        public IEnumerable<AssetDTO> GetAll()
        {
            var assets = _unitOfWork.AssetRepository.GetAll();
            var dtos = _mapper.Map<IEnumerable<AssetDTO>>(assets);
            return dtos;
        }
        public AssetDTO GetAssetBySym(string sym, string period)
        {
            var asset = _unitOfWork.AssetRepository.GetBySym(sym, period);
            var assetDto = _mapper.Map<AssetDTO>(asset);
            
            switch (period)
            {
                case "live":
                    assetDto.Live = asset.Live;
                    break;
                case "1d":
                    assetDto.OneDay = asset.OneDay;
                    break;
                case "1w":
                    assetDto.OneWeek = asset.OneWeek;
                    break;
                case "1m":
                    assetDto.OneMonth = asset.OneMonth;
                    break;
                case "3m":
                    assetDto.ThreeMonths = asset.ThreeMonths;
                    break;
                case "1y":
                    assetDto.OneYear = asset.OneYear;
                    break;
                case "ytd":
                    assetDto.YearToDate = asset.YearToDate;
                    break;
                case "all":
                    assetDto.AllData = asset.AllData;
                    break;
                default:
                    break;
            }
            
            return assetDto;
        }
    }
}
