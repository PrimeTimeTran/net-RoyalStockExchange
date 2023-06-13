using System.Dynamic;
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

        public Asset GetById(int id)
        {
            return _context.Assets.FirstOrDefault(p => p.Id == id);
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
