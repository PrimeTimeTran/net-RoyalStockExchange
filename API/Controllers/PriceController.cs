using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Common.Models;
using Services.Interfaces;
using System;

namespace API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("prices")]
    public class PriceController : ControllerBase
    {
        private readonly ILogger<PriceController> _logger;
        private readonly IPriceService _priceService;

        public PriceController(ILogger<PriceController> logger, IPriceService priceService)
        {
            _logger = logger;
            _priceService = priceService;
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            try
            {
                var prices = _priceService.GetAll();
                return Ok(prices);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while fetching prices.");
            }
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            try
            {
                return Ok(_priceService.GetPriceById(id));
            }
            catch (KeyNotFoundException)
            {
                return NotFound();
            }
        }

        [HttpPost]
        public IActionResult Create([FromBody] PriceDTO dto)
        {
            try
            {
                PriceDTO price = _priceService.Add(dto);
                return CreatedAtAction(nameof(GetById), new { id = price.Id }, price);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while creating the price.");
            }
        }

        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody] PriceDTO dto)
        {
            try
            {
                PriceDTO price = _priceService.Update(id, dto);
                return Ok(price);
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
                _priceService.Delete(id);
                return NoContent();
            }
            catch (KeyNotFoundException)
            {
                return NotFound();
            }
        }
    }
}
