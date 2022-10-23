using System;
using System.IO;
using imdf.Database.Models;
using System.Linq;
using System.Collections.Generic;

namespace imdf.Database;

public class FillDB {
	public static void fill_db_with_test_data() {
		using(DatabaseContext db = new DatabaseContext()) {
			using(StreamReader sr = new StreamReader("./Database/IMDB-Movie-Data.csv")) {
				string line;
				int cycles = 0;

				while((line = sr.ReadLine()) != null) {
					if(cycles++ == 0) continue;

					Movie movie = new Movie();
					string[] splitted = line.Split('|');

					movie.Movie_Name = splitted[1];
					movie.Movie_Synopsis = splitted[3];
					movie.Movie_Director = splitted[4];
					movie.Movie_Cast = splitted[5];
					movie.Movie_ReleaseYear = Convert.ToInt32(splitted[6]);
					movie.Movie_Duration = Convert.ToInt32(splitted[7]);

					db.Movies.Add(movie);
					db.SaveChanges();

					string[] genders = splitted[2].Split(',');

					foreach(string gender in genders) {
						List<Gender> genderExist = 
							db.Genders.Where(x => x.Gender_Name == gender).ToList();

						if(genderExist.Count != 0) {
							GenderXMovie gxm = new GenderXMovie();
							gxm.GenderXMovie_MovieId = cycles - 1;
							gxm.GenderXMovie_GenderId = genderExist[0].Gender_Id;
							db.GendersXMovies.Add(gxm);
							db.SaveChanges();
						} else {
							Gender newGender = new Gender();
							newGender.Gender_Name = gender;
							db.Genders.Add(newGender);
							db.SaveChanges();

							genderExist = 
								db.Genders.Where(x => x.Gender_Name == gender).ToList();

							GenderXMovie gxm = new GenderXMovie();
							gxm.GenderXMovie_MovieId = cycles - 1;
							gxm.GenderXMovie_GenderId = genderExist[0].Gender_Id;
							db.GendersXMovies.Add(gxm);
							db.SaveChanges();
						}
					}
				}
			}
		}
	}
}

