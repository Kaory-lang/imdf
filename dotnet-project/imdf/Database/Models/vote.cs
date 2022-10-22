using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class Vote {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int Vote_Id { get; set; }
	public int Vote_MovieId { get; set; }
	public int Vote_UserId { get; set; }
	public double Vote_Valoration { get; set; }

	[ForeignKey("Vote_MovieId")]
	public virtual Movie Movie { get; set; }
	[ForeignKey("Vote_UserId")]
	public virtual IMDFUser User { get; set; }
}
