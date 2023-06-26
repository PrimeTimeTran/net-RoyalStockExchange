using Common.Models;
using System.Collections.Generic;

namespace Services.Interfaces
{
    public interface ICompanyService 
    {
        CompanyDTO GetCompanyById(int id);
    }
}