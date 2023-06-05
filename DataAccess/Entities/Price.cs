using System;

namespace DataAccess.Entities;
public class Price
{
    public int Id { get; set; }
    public int PriceableId { get; set; }
    public string PriceableType { get; set; }
    public int TransactionCount { get; set; }
    public DateTime DateOfAggregation { get; set; }
    public decimal O { get; set; }          // open
    public decimal L { get; set; }          // lo
    public decimal H { get; set; }          // hi
    public decimal C { get; set; }          // close
    public decimal V { get; set; }          // volume
    public decimal Vwa { get; set; }        // volume weighted average
}