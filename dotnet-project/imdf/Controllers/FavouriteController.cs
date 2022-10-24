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
    public class FavouriteController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public FavouriteController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/Favourite/uId[string]
        [HttpGet("{uId}")]
        public async Task<ActionResult<List<Favourite>>> GetAllFavourites(string uId)
        {
            if (_context.Favourites == null)
            {
                return NotFound();
            }

            var favourites = _context.Favourites.Where(
				x => x.Favourite_UserId == uId
			).ToList();

            if (favourites.Count() == 0)
            {
                return NotFound();
            }

            return favourites;
        }

        // GET: api/Favourite/uId[string]/movieId[int]
        [HttpGet("{uId}/{mId}")]
        public async Task<ActionResult<bool>> GetFavourite(string uId, int mId)
        {
            if (_context.Favourites == null)
            {
                return NotFound();
            }

            var favourites = _context.Favourites.Where(
				x => x.Favourite_UserId == uId && x.Favourite_MovieId == mId
			).ToList();

            if (favourites.Count() == 0)
            {
                return false;
            }

            return true;
        }

		public class ReqFavourite {
			public int Favourite_MovieId { get; set; }
			public string Favourite_UserId { get; set; }
		}

        // POST: api/Favourite
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<bool>> PostFavourite(ReqFavourite favourite)
        {
          if (_context.Favourites == null)
          {
              return Problem("Entity set 'DatabaseContext.Favourites'  is null.");
          }
		  	Favourite f = new Favourite();
			f.Favourite_MovieId = favourite.Favourite_MovieId;
			f.Favourite_UserId = favourite.Favourite_UserId;
            _context.Favourites.Add(f);
            await _context.SaveChangesAsync();

		  return true;
        }

        // DELETE: api/Favourite/uId[string]/movieId[int]
        [HttpDelete("{uId}/{mId}")]
        public async Task<IActionResult> DeleteFavourite(string uId, int mId)
        {
            if (_context.Favourites == null)
            {
                return NotFound();
            }

            var favourite = _context.Favourites.Where(
				x => x.Favourite_UserId == uId && x.Favourite_MovieId == mId
			).ToList();

            if (favourite.Count() == 0)
            {
                return NotFound();
            }

            _context.Favourites.Remove(favourite[0]);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool FavouriteExists(int id)
        {
            return (_context.Favourites?.Any(e => e.Favourite_Id == id)).GetValueOrDefault();
        }
    }
}
