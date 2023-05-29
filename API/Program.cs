using AutoMapper;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Identity.Web;
using Microsoft.EntityFrameworkCore;

using DataAccess.Context;
using Services.Services;
using Services.Interfaces;
using DataAccess.UnitOfWork;

using DataAccess.Entities;
using Common.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddMicrosoftIdentityWebApi(builder.Configuration.GetSection("AzureAdB2C"));

builder.Services.AddScoped<IStockService, StockService>();
builder.Services.AddDbContext<RseContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("hmmm")));

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<IStockService, StockService>();
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();

var mapperConfig = new MapperConfiguration(config =>
{
    config.CreateMap<Stock, StockDTO>();
    // Add other mappings as needed
});

// Create an instance of IMapper using the configured mapper configuration
var mapper = mapperConfig.CreateMapper();

// Register the IMapper instance with the service collection
builder.Services.AddSingleton(mapper);

var app = builder.Build();

if (app.Environment.IsDevelopment())
    app.MapControllers().AllowAnonymous();
else
    app.MapControllers();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();