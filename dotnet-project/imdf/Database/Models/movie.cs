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
	public int? Movie_ReleaseYear { get; set; }
	public int Movie_Duration { get; set; }
	public double? Movie_Valoration { get; set; }
	public string? Movie_Director { get; set; }
	public string? Movie_Cast { get; set; }
	public string? Movie_Cover { get; set; }
	public string? Movie_Banner { get; set; }

	public virtual ICollection<GenderXMovie>? Movie_GendersIds { get; set; }
	public virtual ICollection<Comment>? Comments { get; set; }
}
