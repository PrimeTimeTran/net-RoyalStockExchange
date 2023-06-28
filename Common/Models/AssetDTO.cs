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

        public AssetDTO()
        {
        }

        public AssetDTO(int? id, string? sym, String? live, String? oneDay, String? oneWeek, String? meta,
            String? oneMonth, String? threeMonths, String? oneYear, String? yearToDate, String? allData, CompanyDTO? company
        )
        {
            Id = id;
            Sym = sym;
            Meta = meta;
            Live = live;
            OneDay = oneDay;
            OneWeek = oneWeek;
            OneMonth = oneMonth;
            ThreeMonths = threeMonths;
            YearToDate = yearToDate;
            OneYear = oneYear;
            AllData = allData;
            Company = company;
        }
    }
}
