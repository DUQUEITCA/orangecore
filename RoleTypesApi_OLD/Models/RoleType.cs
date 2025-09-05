using System.ComponentModel.DataAnnotations;
using System.Text.Json;

namespace RoleTypesApi.Models
{
    public class RoleType
    {
        public int Id { get; set; }
        public string RoleName { get; set; } = string.Empty;
        public string? Description { get; set; }
        public JsonDocument? PermissionsJson { get; set; }
        public bool IsSystemRole { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }
}
