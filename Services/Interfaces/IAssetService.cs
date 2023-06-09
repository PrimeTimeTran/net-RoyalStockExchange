using Common.Models;
using System.Collections.Generic;

namespace Services.Interfaces;
public interface IAssetService
{
    AssetDTO GetAssetBySym(string sym, string period);
    AssetDTO Add(AssetDTO assetDto);
    AssetDTO Update(int id, AssetDTO assetDto);
    void Delete(int id);
    IEnumerable<AssetDTO> GetAll();
}
