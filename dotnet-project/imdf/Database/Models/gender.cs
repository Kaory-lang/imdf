using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class Gender {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int Gender_Id { get; set; }
	public string Gender_Name { get; set; }

	public virtual ICollection<GenderXMovie> GendersXMovies { get; set; }
}
