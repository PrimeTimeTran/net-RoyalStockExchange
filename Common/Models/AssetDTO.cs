using Common.Models;

namespace Common.Models
{
    public class AssetDTO
    {
        public int? Id { get; set; }
        public decimal? O { get; set; }
        public decimal? L { get; set; }
        public decimal? H { get; set; }
        public decimal? C { get; set; }
        public decimal? V { get; set; }
        public String? Sym { get; set; }
        public decimal? Mc { get; set; }
        public decimal? Pe { get; set; }
        public decimal? Dy { get; set; }
        public decimal? Av { get; set; }
        public decimal? Vwa { get; set; }
        public string? Live { get; set; }
        public decimal? HiDay { get; set; }
        public decimal? LoDay { get; set; }
        public string? OneDay { get; set; }
        public decimal? HiYear { get; set; }
        public decimal? LoYear { get; set; }
        public string? OneWeek { get; set; }
        public string? OneYear { get; set; }
        public string? AllData { get; set; }
        public string? OneMonth { get; set; }
        public string? YearToDate { get; set; }
        public string? ThreeMonths { get; set; }

        public CompanyDTO Company { get; set; }

        public AssetDTO()
        {
        }

        public AssetDTO(int? id, string? sym, decimal? mc, decimal? pe, decimal? dy, decimal? av,
            decimal? hiDay, decimal? loDay, decimal? hiYear, decimal? loYear, decimal? vwa, String? live,
            String? oneDay, String? oneWeek, String? oneMonth, String? threeMonths, String? oneYear, String? yearToDate,
            String? allData,
            CompanyDTO? company
        )
        {
            Id = id;
            Mc = mc;
            Pe = pe;
            Dy = dy;
            Av = av;
            Sym = sym;
            Vwa = vwa;
            Live = live;
            HiDay = hiDay;
            LoDay = loDay;
            HiYear = hiYear;
            LoYear = loYear;
            OneDay = oneDay;
            OneYear = oneYear;
            AllData = allData;
            OneWeek = oneWeek;
            OneMonth = oneMonth;
            YearToDate = yearToDate;
            ThreeMonths = threeMonths;
            Company = company;
        }
    }
}
