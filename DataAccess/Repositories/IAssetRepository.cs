using Common.Models;
using DataAccess.Entities;
using System.Collections.Generic;

namespace DataAccess.Repositories
{
    public interface IAssetRepository
    {
        Asset GetById(int id, String period);
        IEnumerable<Asset> GetAll();
        Asset Add(AssetDTO price);
        Asset Update(int id, AssetDTO price);
        void Delete(int id);
    }
}
