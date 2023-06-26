using AutoMapper;
using DataAccess.Context;
using DataAccess.Entities;
using Common.Models;

namespace DataAccess.Repositories
{
    public class CompanyRepository : ICompanyRepository
    {
        private readonly IMapper _mapper;
        private readonly RseContext _context;

        public CompanyRepository(RseContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }

        public IEnumerable<Company> GetAll()
        {
            var companies = _context.Companies;
            return companies;
        }

        public Company GetById(int id)
        {
            var company = _context.Companies.FirstOrDefault(p => p.Id == id);
            return company;
        }
    }
}