namespace DataAccess.Entities;

public class Portfolio
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string Valuation { get; set; }
    public string Live { get; set; }
    public string OneDay { get; set; }
    public string OneWeek { get; set; }
    public string OneMonth { get; set; }
    public string ThreeMonths { get; set; }
    public string YTD { get; set; }
    public string OneYear{ get; set; }
    public DateTime CreatedAt { get; set; }
}
