using Common.Models;
using DataAccess.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Web.Resource;
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
    public IEnumerable<StockDTO> Get()
    {
        try
        {
            var stocks = _stockService.GetAll();
            return stocks;
        }
        catch (Exception ex)
        {
            return StatusCode(500, "An error occurred while creating the stock.");
        }
    }
    
    [HttpGet("{id}")]
    public StockDTO GetById(int id)
    {
        try
        {
            return _stockService.GetStockById(id);;
        }
        catch (KeyNotFoundException)
        {
            return NotFound();
        }
    }
    
    [HttpPost]
    public IActionResult Create([FromBody] StockDTO s)
    {
        try
        {
            StockDTO createdStock = _stockService.Add(s);
            return CreatedAtAction(nameof(GetById), new { id = createdStock.Id }, createdStock);
        }
        catch (Exception ex)
        {
            return StatusCode(500, "An error occurred while creating the stock.");
        }
    }

    [HttpPut("{id}")]
    public IActionResult Update(int id, [FromBody] StockDTO stockDto)
    {
        try
        {
            StockDTO s = _stockService.Update(id, stockDto);
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