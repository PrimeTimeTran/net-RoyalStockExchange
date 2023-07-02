namespace DataAccess.Entities;

public class Asset
{

    public int Id { get; set; }
    public String? Sym { get; set; }

    public String? Meta { get; set; }
    public String? Live { get; set; }
    public int CompanyId { get; set; }
    public String? OneDay { get; set; }
    public String? OneWeek { get; set; }
    public String? OneYear { get; set; }
    public String? AllData { get; set; }
    public String? OneMonth { get; set; }
    public String? Ytd { get; set; }
    public String? ThreeMonths { get; set; }
    public Company? Company { get; set; }
}