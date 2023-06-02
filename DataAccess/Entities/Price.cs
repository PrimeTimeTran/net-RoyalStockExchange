using System;

namespace DataAccess.Entities;
public class Price
{
    public int Id { get; set; }
    public int StockId { get; set; }
    public int TransactionCount { get; set; }
    public DateTime DateOfAggregation { get; set; }
    public decimal o { get; set; }          // open
    public decimal l { get; set; }          // lo
    public decimal h { get; set; }          // hi
    public decimal c { get; set; }          // close
    public decimal v { get; set; }          // volume
    public decimal vwa { get; set; }        // volume weighted average
}