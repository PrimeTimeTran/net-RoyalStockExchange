using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Common.Models;
using Services.Interfaces;

namespace API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("assets")]
    public class AssetController : ControllerBase
    {
        private readonly ILogger<AssetController> _logger;
        private readonly IAssetService _assetService;

        public AssetController(ILogger<AssetController> logger, IAssetService assetService)
        {
            _logger = logger;
            _assetService = assetService;
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            try
            {
                var assets = _assetService.GetAll();
                return Ok(assets);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while fetching Assets.");
            }
        }

        [HttpGet("{sym}")]
        public IActionResult GetById(string sym, [FromQuery] string period)
        {
            try
            {
                var asset = _assetService.GetAssetBySym(sym, period);
                return Ok(asset);
            }
            catch (KeyNotFoundException)
            {
                return NotFound();
            }
        }

        [HttpPost]
        public IActionResult Create([FromBody] AssetDTO dto)
        {
            try
            {
                AssetDTO asset = _assetService.Add(dto);
                return CreatedAtAction(nameof(GetById), new { id = asset.Id }, asset);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while creating the Asset.");
            }
        }

        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody] AssetDTO dto)
        {
            try
            {
                AssetDTO asset = _assetService.Update(id, dto);
                return Ok(asset);
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
                _assetService.Delete(id);
                return NoContent();
            }
            catch (KeyNotFoundException)
            {
                return NotFound();
            }
        }
    }
}
