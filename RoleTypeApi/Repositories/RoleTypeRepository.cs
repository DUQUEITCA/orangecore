// Archivo: Repositories/RoleTypeRepository.cs

using System.Data;
using Dapper;
using Npgsql;
using RoleTypesApi.Models;
using Microsoft.Extensions.Configuration;

namespace RoleTypesApi.Repositories
{
    public class RoleTypeRepository : IRoleTypeRepository
    {
        private readonly string _connectionString;

        public RoleTypeRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("PostgresConnection") ?? throw new InvalidOperationException("Connection string 'PostgresConnection' not found.");
        }

        public async Task<IEnumerable<RoleType>> GetAll()
        {
            using IDbConnection db = new NpgsqlConnection(_connectionString);
            return await db.QueryAsync<RoleType>("SELECT id, role_name, description, permissions_json, is_system_role, created_at, updated_at FROM base_foundation.role_types");
        }

        public async Task<RoleType?> GetById(int id)
        {
            using IDbConnection db = new NpgsqlConnection(_connectionString);
            return await db.QueryFirstOrDefaultAsync<RoleType>("SELECT id, role_name, description, permissions_json, is_system_role, created_at, updated_at FROM base_foundation.role_types WHERE id = @Id", new { Id = id });
        }

        public async Task<RoleType> Create(RoleType roleType)
        {
            // Se agrega '::jsonb' para convertir el string al tipo jsonb
            var sql = "INSERT INTO base_foundation.role_types (role_name, description, permissions_json, is_system_role) VALUES (@RoleName, @Description, @PermissionsJson::jsonb, @IsSystemRole) RETURNING id, role_name, description, permissions_json, is_system_role, created_at, updated_at";
            using IDbConnection db = new NpgsqlConnection(_connectionString);
            var newRoleType = await db.QuerySingleAsync<RoleType>(sql, roleType);
            return newRoleType;
        }

        public async Task<RoleType?> Update(RoleType roleType)
        {
            // Se agrega '::jsonb' para convertir el string al tipo jsonb
            var sql = "UPDATE base_foundation.role_types SET role_name = @RoleName, description = @Description, permissions_json = @PermissionsJson::jsonb, is_system_role = @IsSystemRole, updated_at = NOW() WHERE id = @Id RETURNING id, role_name, description, permissions_json, is_system_role, created_at, updated_at";
            using IDbConnection db = new NpgsqlConnection(_connectionString);
            var updatedRoleType = await db.QueryFirstOrDefaultAsync<RoleType>(sql, roleType);
            return updatedRoleType;
        }

        public async Task<bool> Delete(int id)
        {
            using IDbConnection db = new NpgsqlConnection(_connectionString);
            var result = await db.ExecuteAsync("DELETE FROM base_foundation.role_types WHERE id = @Id", new { Id = id });
            return result > 0;
        }
    }
}