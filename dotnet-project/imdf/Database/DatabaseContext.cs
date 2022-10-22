using Microsoft.EntityFrameworkCore;
using imdf.Database.Models;

namespace imdf.Database;

public class DatabaseContext : DbContext {
	public DbSet<IMDFUser> IMDFUsers { get; set; }
	public DbSet<Favourite> Favourites { get; set; }
	public DbSet<Comment> Comments { get; set; }
	public DbSet<Gender> Genders { get; set; }
	public DbSet<Vote> Votes { get; set; }
	public DbSet<Movie> Movies { get; set; }
	public DbSet<GenderXMovie> GendersXMovies { get; set; }

	protected override void OnModelCreating(ModelBuilder modelBuilder) {
		modelBuilder.Entity<IMDFUser>().ToTable("IMDFUser");
		modelBuilder.Entity<Favourite>().ToTable("Favourite");
		modelBuilder.Entity<Comment>().ToTable("Comment");
		modelBuilder.Entity<Gender>().ToTable("Gender");
		modelBuilder.Entity<Vote>().ToTable("Vote");
		modelBuilder.Entity<Movie>().ToTable("Movie");
		modelBuilder.Entity<GenderXMovie>().ToTable("GenderXMovie");
	}

	protected override void OnConfiguring(DbContextOptionsBuilder options) {
		options.UseSqlServer("Server=localhost; Database=IMDFDB; User Id=SA; Password=Mssql123.;");
	}
}
