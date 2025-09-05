// Archivo: Controllers/RoleTypesController.cs
// Este controlador maneja todas las solicitudes API para la entidad 'RoleType'.

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RoleTypesApi.Data;
using RoleTypesApi.Models;

namespace RoleTypesApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoleTypesController : ControllerBase
    {
        private readonly RoleTypeContext _context;

        public RoleTypesController(RoleTypeContext context)
        {
            _context = context;
        }

        // GET: api/RoleTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RoleType>>> GetRoleTypes()
        {
            return await _context.RoleTypes.ToListAsync();
        }

        // GET: api/RoleTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RoleType>> GetRoleType(int id)
        {
            var roleType = await _context.RoleTypes.FindAsync(id);

            if (roleType == null)
            {
                return NotFound();
            }

            return roleType;
        }

        // PUT: api/RoleTypes/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRoleType(int id, RoleType roleType)
        {
            if (id != roleType.Id)
            {
                return BadRequest();
            }

            _context.Entry(roleType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RoleTypeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/RoleTypes
        [HttpPost]
        public async Task<ActionResult<RoleType>> PostRoleType(RoleType roleType)
        {
            _context.RoleTypes.Add(roleType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRoleType", new { id = roleType.Id }, roleType);
        }

        // DELETE: api/RoleTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRoleType(int id)
        {
            var roleType = await _context.RoleTypes.FindAsync(id);
            if (roleType == null)
            {
                return NotFound();
            }

            _context.RoleTypes.Remove(roleType);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RoleTypeExists(int id)
        {
            return _context.RoleTypes.Any(e => e.Id == id);
        }
    }
}