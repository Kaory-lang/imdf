using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class ActorXMovie {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int ActorXMovie_Id { get; set; }
	public int ActorXMovie_ActorId { get; set; }
	public int ActorXMovie_MovieId { get; set; }

	[ForeignKey("ActorXMovie_ActorId")]
	public virtual Actor Actor { get; set; }
	[ForeignKey("ActorXMovie_MovieId")]
	public virtual Movie Movie { get; set; }
}
