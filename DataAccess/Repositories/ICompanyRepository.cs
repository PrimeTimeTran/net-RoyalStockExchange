using DataAccess.Entities;

namespace DataAccess.Repositories;

public interface ICompanyRepository
{
    Company GetById(int id);
}