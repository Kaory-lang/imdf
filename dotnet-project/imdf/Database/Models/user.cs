using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace imdf.Database.Models;

public class IMDFUser {
	[Key]
	[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
	public int User_Id { get; set; }
}
