namespace DataAccess.Entities;

public class Asset
{
    public int Id { get; set; }
    public decimal O { get; set; }
    public decimal Mc { get; set; }
    public decimal Pe { get; set; }
    public decimal Dy { get; set; }
    public decimal Av { get; set; }
    public String? Sym { get; set; }
    public String? Live { get; set; }
    public decimal HiDay { get; set; }
    public decimal LoDay { get; set; }
    public int CompanyId { get; set; }
    public decimal HiYear { get; set; }
    public decimal LoYear { get; set; }
    public String? OneDay { get; set; }
    public String? OneWeek { get; set; }
    public String? OneYear { get; set; }
    public String? AllData { get; set; }
    public String? OneMonth { get; set; }
    public String? YearToDate { get; set; }
    public String? ThreeMonths { get; set; }
    
}