using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

using Common.Models;
using Services.Interfaces;

namespace API.Controllers;

[Authorize]
[ApiController]
[Route("stocks")]
// [RequiredScope(RequiredScopesConfigurationKey = "AzureAd:Scopes")]
public class StockController : ControllerBase
{
    private readonly ILogger<StockController> _logger;
    private readonly IStockService _stockService;

    public StockController(ILogger<StockController> logger, IStockService stockService)
    {
        _logger = logger;
        _stockService = stockService;
    }

    [HttpGet]
    public IActionResult GetAll()
    {
        try
        {
            var stocks = _stockService.GetAll();
            return Ok(stocks);
        }
        catch (Exception ex)
        {
            return StatusCode(500, "An error occured fetching stocks.");
        }
    }
    
    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        try
        {
            return Ok(_stockService.GetStockById(id));
        }
        catch (KeyNotFoundException)
        {
            return NotFound();
        }
    }
    
    [HttpPost]
    public IActionResult Create([FromBody] StockDTO dto)
    {
        try
        {
            StockDTO s = _stockService.Add(dto);
            return CreatedAtAction(nameof(GetById), new { id = s.Id }, s);
        }
        catch (Exception ex)
        {
            return StatusCode(500, "An error occurred while creating the stock.");
        }
    }

    [HttpPut("{id}")]
    public IActionResult Update(int id, [FromBody] StockDTO dto)
    {
        try
        {
            StockDTO s = _stockService.Update(id, dto);
            return Ok(s);
        }
        catch (KeyNotFoundException)
        {
            return NotFound();
        }
    }

    [HttpDelete("{id}")]
    public IActionResult Delete(int id)
    {
        try
        {
            _stockService.Delete(id);
            return NoContent();
        }
        catch (KeyNotFoundException)
        {
            return NotFound();
        }
    }
}