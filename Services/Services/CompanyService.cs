using AutoMapper;

using Common.Models;
using DataAccess.UnitOfWork;
using Services.Interfaces;
using DataAccess.Entities;

namespace Services.Services;
public class CompanyService : ICompanyService
{
    private readonly IMapper _mapper;
    private readonly IUnitOfWork _unitOfWork;
    
    public CompanyService(IUnitOfWork unitOfWork, IMapper mapper)
    {
        _mapper = mapper;
        _unitOfWork = unitOfWork;
    }
    
    public CompanyDTO GetCompanyById(int id)
    {
        var stock = _unitOfWork.CompanyRepository.GetById(id);
        return _mapper.Map<CompanyDTO>(stock);
    }

}