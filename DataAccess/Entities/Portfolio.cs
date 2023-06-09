namespace DataAccess.Entities;

public class Portfolio
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string Valuation { get; set; }
    public DateTime CreatedAt { get; set; }
}
