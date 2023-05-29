namespace DataAccess.Entities;
public class Stock
{
    public Stock(string name)
    {
        Name = name;
    }

    public int Id { get; set; }
    public string Name { get; set; }
    public decimal Price { get; set; }
    public int Quantity { get; set; }
}