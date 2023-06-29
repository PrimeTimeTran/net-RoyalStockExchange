using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Common.Models;
using Services.Interfaces;
using System;

namespace API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("portfolios")]
    public class PortfolioController : ControllerBase
    {
        private readonly ILogger<PortfolioController> _logger;
        private readonly IPortfolioService _portfolioService;

        public PortfolioController(ILogger<PortfolioController> logger, IPortfolioService portfolioService)
        {
            _logger = logger;
            _portfolioService = portfolioService;
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            try
            {
                var portfolios = _portfolioService.GetAllPortfolios();
                return Ok(portfolios);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while fetching portfolios.");
            }
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id, String period)
        {
            try
            {
                return Ok(_portfolioService.GetPortfolioById(id, period));
            }
            catch (KeyNotFoundException)
            {
                return NotFound();
            }
        }

        [HttpPost]
        public IActionResult Create([FromBody] PortfolioDTO dto)
        {
            try
            {
                PortfolioDTO portfolio = _portfolioService.AddPortfolio(dto);
                return CreatedAtAction(nameof(GetById), new { id = portfolio.Id }, portfolio);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while creating the portfolio.");
            }
        }

        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody] PortfolioDTO dto)
        {
            try
            {
                PortfolioDTO portfolio = _portfolioService.UpdatePortfolio(id, dto);
                return Ok(portfolio);
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
                _portfolioService.DeletePortfolio(id);
                return NoContent();
            }
            catch (KeyNotFoundException)
            {
                return NotFound();
            }
        }
    }
}


