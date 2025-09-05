// File: Data/RoleTypeContext.cs
// This database context handles interactions with the role_types table in the PostgreSQL database.

using Microsoft.EntityFrameworkCore;
using System.Text.Json;
using RoleTypesApi.Models;

namespace RoleTypesApi.Data
{
    public class RoleTypeContext : DbContext
    {
        public RoleTypeContext(DbContextOptions<RoleTypeContext> options) : base(options)
        {
        }

        public DbSet<RoleType> RoleTypes { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema("base_foundation");

            modelBuilder.Entity<RoleType>(entity =>
            {
                entity.ToTable("role_types");

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.RoleName).HasColumnName("role_name");
                entity.Property(e => e.Description).HasColumnName("description");
                entity.Property(e => e.PermissionsJson)
                      .HasColumnName("permissions_json")
                      .HasColumnType("jsonb"); // Use jsonb for PostgreSQL JSON data
                entity.Property(e => e.IsSystemRole).HasColumnName("is_system_role");
                entity.Property(e => e.CreatedAt).HasColumnName("created_at");
                entity.Property(e => e.UpdatedAt).HasColumnName("updated_at");
            });

            base.OnModelCreating(modelBuilder);
        }
    }
}