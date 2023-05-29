using Moq;
using Xunit;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

using Common.Models;
using API.Controllers;
using Services.Interfaces;

namespace tests.API.Tests.Controllers
{
    public class StockControllerTests
    {
        private readonly StockController _stockController;
        private Mock<ILogger<StockController>> _loggerMock;
        private readonly Mock<IStockService> _stockServiceMock;

        public StockControllerTests()
        {
            _stockServiceMock = new Mock<IStockService>();
            _loggerMock = new Mock<ILogger<StockController>>();
            _stockController = new StockController(_loggerMock.Object, _stockServiceMock.Object);
        }

        [Fact]
        public void GetAll_ReturnsOkResultWithData()
        {
            // Arrange
            var stocks = new List<StockDTO>
            {
                new StockDTO(1, "Stock 1", 100, 10.0m),
                new StockDTO(2, "Stock 2", 200,  20.0m)
            };
            _stockServiceMock.Setup(s => s.GetAll()).Returns(stocks);

            // Act
            var result = _stockController.GetAll();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var model = Assert.IsType<List<StockDTO>>(okResult.Value);
            Assert.Equal(stocks.Count, model.Count);
        }

        [Fact]
        public void GetById_ReturnsOkResultWithStock()
        {
            // Arrange
            int stockId = 1;
            var stock = new StockDTO(1, "Stock 1", 100, 10.0m);
            _stockServiceMock.Setup(s => s.GetStockById(stockId)).Returns(stock);

            // Act
            var result = _stockController.GetById(stockId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var model = Assert.IsType<StockDTO>(okResult.Value);
            Assert.Equal(stockId, model.Id);
        }

        [Fact]
        public void Create_ReturnsCreatedAtActionResultWithStock()
        {
            // Arrange
            var stockDto = new StockDTO(1, "Stock 1", 100, 10.0m);
            var createdStockDto = new StockDTO(1, "Stock 1", 100, 10.0m);
            _stockServiceMock.Setup(s => s.Add(stockDto)).Returns(createdStockDto);

            // Act
            var result = _stockController.Create(stockDto);

            // Assert
            var createdAtActionResult = Assert.IsType<CreatedAtActionResult>(result);
            var model = Assert.IsType<StockDTO>(createdAtActionResult.Value);
            Assert.Equal(createdStockDto.Id, model.Id);
        }

        [Fact]
        public void Update_ReturnsOkResultWithUpdatedStock()
        {
            // Arrange
            int stockId = 1;
            var stockDto = new StockDTO(1, "Stock 1", 100, 10.0m);
            var updatedStockDto = new StockDTO(1, "Stock 1", 100, 10.0m);
            _stockServiceMock.Setup(s => s.Update(stockId, stockDto)).Returns(updatedStockDto);

            // Act
            var result = _stockController.Update(stockId, stockDto);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var model = Assert.IsType<StockDTO>(okResult.Value);
            Assert.Equal(stockId, model.Id);
            Assert.Equal(updatedStockDto.Name, model.Name);
        }

        [Fact]
        public void Delete_ReturnsNoContentResult()
        {
            // Arrange
            int stockId = 1;
            _stockServiceMock.Setup(s => s.Delete(stockId));

            // Act
            var result = _stockController.Delete(stockId);

            // Assert
            Assert.IsType<NoContentResult>(result);
        }
    }
}
