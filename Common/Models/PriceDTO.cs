namespace Common.Models;

public class PriceDTO
{
    public int? Id { get; set; }
    public int? StockId { get; set; }
    public int? TransactionCount { get; set; }
    public DateTime? DateOfAggregation { get; set; }
    public decimal? o { get; set; } // open
    public decimal? l { get; set; } // low
    public decimal? h { get; set; } // high
    public decimal? c { get; set; } // close
    public decimal? v { get; set; } // volume
    public decimal? vwa { get; set; } // volume weighted average
    
    // Parameterless constructor
    public PriceDTO()
    {
    }

    public PriceDTO(int? id, int? stockId, int? transactionCount, DateTime? dateOfAggregation,
                    decimal? open, decimal? low, decimal? high, decimal? close,
                    decimal? volume, decimal? volumeWeightedAverage)
    {
        Id = id;
        StockId = stockId;
        TransactionCount = transactionCount;
        DateOfAggregation = dateOfAggregation;
        o = open;
        l = low;
        h = high;
        c = close;
        v = volume;
        vwa = volumeWeightedAverage;
    }
}