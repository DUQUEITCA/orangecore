using RoleTypesApi.Models;

namespace RoleTypesApi.Repositories
{
    public interface IRoleTypeRepository
    {
        Task<IEnumerable<RoleType>> GetAll();
        Task<RoleType?> GetById(int id);
        Task<RoleType> Create(RoleType roleType);
        Task<RoleType?> Update(RoleType roleType);
        Task<bool> Delete(int id);
    }
}
