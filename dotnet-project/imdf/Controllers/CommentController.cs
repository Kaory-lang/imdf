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
    public class CommentController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public CommentController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/Comment
        [HttpGet("{uId}/{mId}")]
        public async Task<ActionResult<Comment>> GetComments(string uId, int mId)
        {
          if (_context.Comments == null)
          {
              return NotFound();
          }

		  List<Comment> comments = _context.Comments.Where(
		  	  x => x.Comment_UserId == uId && x.Comment_MovieId == mId
		  ).ToList();

		  if (comments.Count < 1) return NotFound();

		  return comments[0];
        }

        // GET: api/Comment/5
        [HttpGet("{mId}")]
        public async Task<ActionResult<List<Comment>>> GetMovieComment(int mId)
        {
          if (_context.Comments == null)
          {
              return NotFound();
          }

		  List<Comment> comments = _context.Comments.Where(x => x.Comment_MovieId == mId).ToList();

            if (comments.Count < 1)
            {
                return NotFound();
            }

            return comments;
        }

        // PUT: api/Comment/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutComment(int id, Comment comment)
        {
            if (id != comment.Comment_Id)
            {
                return BadRequest();
            }

            _context.Entry(comment).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CommentExists(id))
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

        // POST: api/Comment
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Comment>> PostComment(Comment comment)
        {
          if (_context.Comments == null)
          {
              return Problem("Entity set 'DatabaseContext.Comments'  is null.");
          }
            _context.Comments.Add(comment);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetComment", new { id = comment.Comment_Id }, comment);
        }

        // DELETE: api/Comment/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteComment(int id)
        {
            if (_context.Comments == null)
            {
                return NotFound();
            }
            var comment = await _context.Comments.FindAsync(id);
            if (comment == null)
            {
                return NotFound();
            }

            _context.Comments.Remove(comment);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CommentExists(int id)
        {
            return (_context.Comments?.Any(e => e.Comment_Id == id)).GetValueOrDefault();
        }
    }
}
