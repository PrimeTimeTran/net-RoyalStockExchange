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
builder.Services.ConfigureSwaggerGen(setup =>
{
    setup.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "Royal Stock Exchange",
        Version = "v1"
    });
});

builder.Services.AddScoped<IStockService, StockService>();
builder.Services.AddScoped<IAssetService, AssetService>();
builder.Services.AddScoped<IPortfolioService, PortfolioService>();
builder.Services.AddScoped<ICompanyService, CompanyService>();
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();

var  MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: MyAllowSpecificOrigins,
        policy  =>
        {
            policy.WithOrigins(
                "http://localhost:53490/")
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader();
                ;
        });
});

var mapperConfig = new MapperConfiguration(config =>
{
    config.CreateMap<Stock, StockDTO>();
    config.CreateMap<StockDTO, Stock>();
    config.CreateMap<Asset, AssetDTO>();
    config.CreateMap<AssetDTO, Asset>();
    config.CreateMap<Portfolio, PortfolioDTO>();
    config.CreateMap<PortfolioDTO, Portfolio>();
    config.CreateMap<Company, CompanyDTO>();
    config.CreateMap<CompanyDTO, Company>();
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

app.UseSwagger();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwaggerUI();
}

app.UseCors(MyAllowSpecificOrigins);

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();