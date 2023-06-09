namespace Common.Models
{
    public class PortfolioDTO
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public string Valuation { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}