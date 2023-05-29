namespace Common.Models;

public class StockDTO
{
    public int Id { get; set; }
    public string Name { get; set; }
    public int Quantity { get; set; }
    public decimal Price { get; set; }
    
    public StockDTO()
    {
    }

    public StockDTO(int id, string name, int quantity, decimal price)
    {
        Id = id;
        Name = name;
        Quantity = quantity;
        Price = Price;
    }
}