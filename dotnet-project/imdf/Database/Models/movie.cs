using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;

namespace imdf.Database.Models;

public class Movie {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int Movie_Id { get; set; }
	public string Movie_Name { get; set; }
	public string? Movie_Synopsis { get; set; }
	public string? Movie_Country { get; set; }
	public DateTime? Movie_ReleaseDate { get; set; }
	public float Movie_Duration { get; set; }
	public float? Movie_Valoration { get; set; }
	public int? Movie_DirectorId { get; set; }

	[ForeignKey("Movie_DirectorId")]
	public virtual Director Director { get; set; }
	public virtual ICollection<ActorXMovie> Movie_ActorsIds { get; set; }
	public virtual ICollection<GenderXMovie> Movie_GendersIds { get; set; }
	public virtual ICollection<Comment> Comments { get; set; }
}
