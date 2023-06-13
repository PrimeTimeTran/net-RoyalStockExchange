using AutoMapper;
using System.Linq;
using System.Linq.Dynamic.Core;

using DataAccess.Context;
using DataAccess.Entities;
using Common.Models;


namespace DataAccess.Repositories
{
    public class AssetRepository : IAssetRepository
    {
        private readonly IMapper _mapper;
        private readonly RseContext _context;

        public AssetRepository(RseContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }

        public IEnumerable<Asset> GetAll()
        {
            var assets = _context.Assets;
            return assets;
        }
        
        public Asset GetById(int id, string period = null)
        {
            var assetQuery = _context.Assets.Where(p => p.Id == id);
            if (assetQuery == null)
            {
                return null;
            }

            var selectedProperties = new List<string> { "O", "Mc", "Pe", "Dy", "Av", "Sym", "HiDay", "LoDay", "CompanyId", "HiYear", "LoYear" };
            var assetProperties = new List<string> { "OneDay", "OneWeek", "OneMonth", "ThreeMonths", "OneYear", "YearToDate", "AllData" };

            if (assetQuery == null)
            {
                return null;
            }

            var asset = new Asset();

            foreach (var property in selectedProperties)
            {
                var propertyInfo = typeof(Asset).GetProperty(property);
                if (propertyInfo != null)
                {
                    var value = propertyInfo.GetValue(assetQuery.FirstOrDefault());
                    propertyInfo.SetValue(asset, value);
                }
            }

            var periodPropertyMap = new Dictionary<string, string>()
            {
                { "live", "OneDay" },
                { "1d", "OneDay" },
                { "1w", "OneWeek" },
                { "1m", "OneMonth" },
                { "3m", "ThreeMonths" },
                { "1y", "OneYear" },
                { "ytd", "YearToDate" },
                { "all", "AllData" }
            };

            if (periodPropertyMap.TryGetValue(period, out var periodProperty))
            {
                var periodPropertyInfo = typeof(Asset).GetProperty(periodProperty);
                if (periodPropertyInfo != null)
                {
                    var periodValue = periodPropertyInfo.GetValue(assetQuery.FirstOrDefault());
                    periodPropertyInfo.SetValue(asset, periodValue);
                }
            }

            return asset;

        }



        public Asset Add(AssetDTO assetDto)
        {
            Asset asset = _mapper.Map<Asset>(assetDto);
            Asset addedAsset = _context.Assets.Add(asset).Entity;
            _context.SaveChanges();
            return addedAsset;
        }

        public Asset Update(int id, AssetDTO assetDto)
        {
            Asset asset = _context.Assets.Find(id);
            if (asset == null)
            {
                // Handle not found scenario
            }

            var assetProps = typeof(Asset).GetProperties();
            var dtoProps = typeof(AssetDTO).GetProperties();

            foreach (var prop in dtoProps)
            {
                if (prop.Name == "Id")
                    continue;

                var assetProp = assetProps.FirstOrDefault(p => p.Name == prop.Name);
                if (assetProp != null && prop.GetValue(assetDto) != null)
                {
                    assetProp.SetValue(asset, prop.GetValue(assetDto));
                }
            }

            _context.SaveChanges();

            return asset;
        }

        public void Delete(int id)
        {
            Asset asset = _context.Assets.Find(id);
            if (asset == null)
            {
                // Handle not found scenario
            }

            _context.Assets.Remove(asset);
            _context.SaveChanges();
        }
    }
}
