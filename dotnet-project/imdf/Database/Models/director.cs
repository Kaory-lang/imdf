using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class Director {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int Director_Id { get; set; }
	public string? Director_Name { get; set; }
	public string? Director_Description { get; set; }
	public DateTime? Director_Birthday { get; set; }

	public virtual ICollection<Movie> Movies { get; set; }
}
