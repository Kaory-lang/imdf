using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class Actor {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int Actor_Id { get; set; }
	public string? Actor_Name { get; set; }
	public string? Actor_Description { get; set; }
	public DateTime? Actor_Birthday { get; set; }

	public virtual ICollection<ActorXMovie> ActorsXMovies { get; set; }
}
