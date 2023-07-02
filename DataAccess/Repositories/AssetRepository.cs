using AutoMapper;
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

        public Asset GetBySym(string sym, string period)
        {
                var assetQuery = _context.Assets.Where(p => p.Sym == sym);
                if (assetQuery == null || period == "")
                {
                    return null;
                }

                Asset asset;

                switch (period)
                {
                    case "live":
                        asset = assetQuery.Select(a => new Asset { Live = a.Live, Sym = a.Sym, CompanyId = a.CompanyId, Meta = a.Meta }).FirstOrDefault();
                        break;
                    case "1d":
                        asset = assetQuery.Select(a => new Asset { OneDay = a.OneDay, Sym = a.Sym, CompanyId = a.CompanyId, Meta = a.Meta }).FirstOrDefault();
                        break;
                    case "1w":
                        asset = assetQuery.Select(a => new Asset { OneWeek = a.OneWeek, Sym = a.Sym, CompanyId = a.CompanyId, Meta = a.Meta }).FirstOrDefault();
                        break;
                    case "1m":
                        asset = assetQuery.Select(a => new Asset { OneMonth = a.OneMonth, Sym = a.Sym, CompanyId = a.CompanyId, Meta = a.Meta }).FirstOrDefault();
                        break;
                    case "3m":
                        asset = assetQuery.Select(a => new Asset { ThreeMonths = a.ThreeMonths, Sym = a.Sym, CompanyId = a.CompanyId, Meta = a.Meta }).FirstOrDefault();
                        break;
                    case "1y":
                        asset = assetQuery.Select(a => new Asset { OneYear = a.OneYear, Sym = a.Sym, CompanyId = a.CompanyId, Meta = a.Meta }).FirstOrDefault();
                        break;
                    case "ytd":
                        asset = assetQuery.Select(a => new Asset { Ytd = a.Ytd, Sym = a.Sym, CompanyId = a.CompanyId, Meta = a.Meta }).FirstOrDefault();
                        break;
                    case "all":
                        asset = assetQuery.Select(a => new Asset { AllData = a.AllData, Sym = a.Sym, CompanyId = a.CompanyId, Meta = a.Meta }).FirstOrDefault();
                        break;
                    default:
                        return null;
                }
                
                if (asset != null)
                {
                    asset.Company = _context.Companies.FirstOrDefault(c => c.Id == asset.CompanyId);
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
