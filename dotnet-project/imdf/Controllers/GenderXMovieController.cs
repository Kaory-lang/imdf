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
    public class GenderXMovieController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public GenderXMovieController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/GenderXMovie
        [HttpGet]
        public async Task<ActionResult<IEnumerable<GenderXMovie>>> GetGendersXMovies()
        {
          if (_context.GendersXMovies == null)
          {
              return NotFound();
          }
            return await _context.GendersXMovies.ToListAsync();
        }

        // GET: api/GenderXMovie/5
        [HttpGet("{mId}")]
        public async Task<ActionResult<List<GenderXMovie>>> GetGenderXMovie(int mId)
        {
          if (_context.GendersXMovies == null)
          {
              return NotFound();
          }

		  List<GenderXMovie> gxm = _context.GendersXMovies.Where(
		      x => x.GenderXMovie_MovieId == mId
		  ).ToList();

            if (gxm.Count < 1)
            {
                return NotFound();
            }

            return gxm;
        }

        // PUT: api/GenderXMovie/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutGenderXMovie(int id, GenderXMovie genderXMovie)
        {
            if (id != genderXMovie.GenderXMovie_Id)
            {
                return BadRequest();
            }

            _context.Entry(genderXMovie).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!GenderXMovieExists(id))
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

        // POST: api/GenderXMovie
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult> PostGenderXMovie(List<GenderXMovie> data)
        {
          if (_context.GendersXMovies == null)
          {
              return Problem("Entity set 'DatabaseContext.GendersXMovies'  is null.");
          }

		  	foreach(GenderXMovie fact in data)
            	_context.GendersXMovies.Add(fact);

			try {
            await _context.SaveChangesAsync();
			} catch (Exception e) {
				return BadRequest();
			}

            return Ok();
        }

        // DELETE: api/GenderXMovie/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteGenderXMovie(int id)
        {
            if (_context.GendersXMovies == null)
            {
                return NotFound();
            }
            var genderXMovie = await _context.GendersXMovies.FindAsync(id);
            if (genderXMovie == null)
            {
                return NotFound();
            }

            _context.GendersXMovies.Remove(genderXMovie);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool GenderXMovieExists(int id)
        {
            return (_context.GendersXMovies?.Any(e => e.GenderXMovie_Id == id)).GetValueOrDefault();
        }
    }
}
