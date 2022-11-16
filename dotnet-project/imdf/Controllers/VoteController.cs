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
    public class VoteController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public VoteController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/Vote
        [HttpGet("{mId}")]
        public async Task<ActionResult<double>> GetAverageVotes(int mId)
        {
          if (_context.Votes == null)
          {
              return NotFound();
          }

		  List<Vote> votes = _context.Votes.Where(x => x.Vote_MovieId == mId).ToList();

		  double acc = 0;
		  foreach(Vote vote in votes)
			  acc += vote.Vote_Valoration;

		  return acc/votes.Count;
        }

        // GET: api/Vote
        [HttpGet("{uId}/{mId}")]
        public async Task<ActionResult<Vote>> GetVote(string uId, int mId)
        {
          if (_context.Votes == null)
          {
              return NotFound();
          }
 
		  List<Vote> votes = _context.Votes.Where(
		      x => x.Vote_UserId == uId && x.Vote_MovieId == mId
		  ).ToList();

		  if(votes.Count < 1) return NotFound();

		  return votes[0];

        }

        // PUT: api/Vote/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutVote(int id, Vote vote)
        {
            if (id != vote.Vote_Id)
            {

                return BadRequest();
            }

            _context.Entry(vote).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!VoteExists(id))
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

        // POST: api/Vote
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Vote>> PostVote(Vote vote)
        {
          if (_context.Votes == null)
          {
              return Problem("Entity set 'DatabaseContext.Votes'  is null.");
          }
            _context.Votes.Add(vote);
            await _context.SaveChangesAsync();

            return vote;
        }

        private bool VoteExists(int id)
        {
            return (_context.Votes?.Any(e => e.Vote_Id == id)).GetValueOrDefault();
        }
    }
}
