using Microsoft.AspNetCore.Mvc;
using RoleTypesApi.Models;
using RoleTypesApi.Repositories;

namespace RoleTypesApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RoleTypesController : ControllerBase
    {
        private readonly IRoleTypeRepository _repository;

        public RoleTypesController(IRoleTypeRepository repository)
        {
            _repository = repository;
        }

        // GET: api/roletypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RoleType>>> GetAll()
        {
            var roleTypes = await _repository.GetAll();
            return Ok(roleTypes);
        }

        // GET: api/roletypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RoleType>> GetById(int id)
        {
            var roleType = await _repository.GetById(id);
            if (roleType == null)
            {
                return NotFound();
            }
            return Ok(roleType);
        }

        // POST: api/roletypes
        [HttpPost]
        public async Task<ActionResult<RoleType>> Create(RoleType roleType)
        {
            var newRoleType = await _repository.Create(roleType);
            return CreatedAtAction(nameof(GetById), new { id = newRoleType.Id }, newRoleType);
        }

        // PUT: api/roletypes/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, RoleType roleType)
        {
            if (id != roleType.Id)
            {
                return BadRequest("ID mismatch");
            }

            var updatedRoleType = await _repository.Update(roleType);
            if (updatedRoleType == null)
            {
                return NotFound();
            }
            return Ok(updatedRoleType);
        }

        // DELETE: api/roletypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var isDeleted = await _repository.Delete(id);
            if (!isDeleted)
            {
                return NotFound();
            }
            return NoContent();
        }
    }
}
