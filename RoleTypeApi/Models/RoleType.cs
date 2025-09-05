// Archivo: Models/RoleType.cs

namespace RoleTypesApi.Models
{
    public class RoleType
    {
        public int Id { get; set; }
        public string RoleName { get; set; } = string.Empty;
        public string? Description { get; set; }
        public string? PermissionsJson { get; set; } // <--- Cambio aquí
        public bool IsSystemRole { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }
}