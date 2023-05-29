using Common.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Web.Resource;
using Services.Interfaces;

namespace API.Controllers;

[Authorize]
[ApiController]
[Route("[controller]")]
// [RequiredScope(RequiredScopesConfigurationKey = "AzureAd:Scopes")]
public class WeatherForecastController : ControllerBase
{
    private static readonly string[] Summaries = new[]
    {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    };

    private readonly ILogger<WeatherForecastController> _logger;
    private readonly IStockService _stockService;

    public WeatherForecastController(ILogger<WeatherForecastController> logger, IStockService stockService)
    {
        _logger = logger;
        _stockService = stockService;
    }

    [HttpGet(Name = "GetWeatherForecast")]
    public IEnumerable<StockDTO> Get()
    {
        var stocks = _stockService.GetAll();
        return stocks;
    }
}