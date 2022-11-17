using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using imdf.Database;
using imdf.Database.Models;

namespace imdf.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GenderController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public GenderController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/Gender
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Gender>>> GetGenders()
        {
          if (_context.Genders == null)
          {
              return NotFound();
          }
            return await _context.Genders.ToListAsync();
        }
		
        // GET: api/Gender
        [HttpGet("{gId}")]
        public async Task<ActionResult<Gender>> GetGenders(int gId)
        {
          if (_context.Genders == null)
          {
              return NotFound();
          }
		  
		  List<Gender> genders = _context.Genders.Where(x => x.Gender_Id == gId).ToList();

          if (genders.Count < 1)
          {
              return NotFound();
          }

		  return genders[0];
        }

        private bool GenderExists(int id)
        {
            return (_context.Genders?.Any(e => e.Gender_Id == id)).GetValueOrDefault();
        }
    }
}
