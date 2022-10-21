using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class Comment {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int Comment_Id { get; set; }
	public string Comment_Body { get; set; }
	public int Comment_UserId { get; set; }
	public int Comment_MovieId { get; set; }

	[ForeignKey("Comment_UserId")]
	public virtual IMDFUser User { get; set; }
	[ForeignKey("Comment_MovieId")]
	public virtual Movie Movie { get; set; }
}
