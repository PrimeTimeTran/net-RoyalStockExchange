using Common.Models;

namespace Common.Models
{
    public class AssetDTO
    {
        public int? Id { get; set; }
        public String? Sym { get; set; }
        public string? Meta { get; set; }
        public CompanyDTO? Company { get; set; }
        public string? Current { get; set; }
        public double? O { get; set; }
    }
}
