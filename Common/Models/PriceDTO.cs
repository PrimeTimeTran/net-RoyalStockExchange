namespace Common.Models;

public class PriceDTO
{
    public int? Id { get; set; }
    public int? PriceableId { get; set; }
    public string? PriceableType { get; set; }
    public int? TransactionCount { get; set; }
    public DateTime? DateOfAggregation { get; set; }
    public decimal? O { get; set; } // open
    public decimal? L { get; set; } // low
    public decimal? H { get; set; } // high
    public decimal? C { get; set; } // close
    public decimal? V { get; set; } // volume
    public decimal? Vwa { get; set; } // volume weighted average
    
    // Parameterless constructor
    public PriceDTO()
    {
    }

    public PriceDTO(int? id, int? priceableId, string? priceableType, int? transactionCount, DateTime? dateOfAggregation,
                    decimal? open, decimal? low, decimal? high, decimal? close,
                    decimal? volume, decimal? volumeWeightedAverage)
    {
        Id = id;
        PriceableId = priceableId;
        PriceableType = priceableType;
        TransactionCount = transactionCount;
        DateOfAggregation = dateOfAggregation;
        O = open;
        L = low;
        H = high;
        C = close;
        V = volume;
        Vwa = volumeWeightedAverage;
    }
}