using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class Favourite {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int Favourite_Id { get; set; }
	public int Favourite_MovieId { get; set; }
	public string Favourite_UserId { get; set; }

	[ForeignKey("Favourite_MovieId")]
	public virtual Movie Movie { get; set; }
}
