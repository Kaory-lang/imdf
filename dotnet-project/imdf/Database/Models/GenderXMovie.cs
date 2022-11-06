using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class GenderXMovie {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int GenderXMovie_Id { get; set; }
	public int GenderXMovie_GenderId { get; set; }
	public int GenderXMovie_MovieId { get; set; }

	[ForeignKey("GenderXMovie_GenderId")]
	public virtual Gender? Gender { get; set; }
	[ForeignKey("GenderXMovie_MovieId")]
	public virtual Movie? Movie { get; set; }
}
