namespace Common.Models
{
    public class PortfolioDTO
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public string Valuation { get; set; }
        public string Live { get; set; }
        public string OneDay { get; set ; }
        public string OneWeek { get; set; }
        public string OneMonth { get; set; }
        public string ThreeMonths { get; set; }
        public string Ytd { get; set; }
        public string OneYear { get; set; }
        public string All { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}