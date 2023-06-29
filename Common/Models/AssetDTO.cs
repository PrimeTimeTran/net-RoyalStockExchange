using Common.Models;

namespace Common.Models
{
    public class AssetDTO
    {
        public int? Id { get; set; }
        public String? Sym { get; set; }
        public string? Live { get; set; }
        public string? OneDay { get; set; }
        public string? OneWeek { get; set; }
        public string? OneYear { get; set; }
        public string? AllData { get; set; }
        public string? OneMonth { get; set; }
        public string? YearToDate { get; set; }
        public string? ThreeMonths { get; set; }
        public string? Meta { get; set; }
        public CompanyDTO? Company { get; set; }
    }
}
