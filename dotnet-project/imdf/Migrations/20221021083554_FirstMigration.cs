using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace imdf.Migrations
{
    public partial class FirstMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Actor",
                columns: table => new
                {
                    Actor_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Actor_Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Actor_Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Actor_Birthday = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Actor", x => x.Actor_Id);
                });

            migrationBuilder.CreateTable(
                name: "Director",
                columns: table => new
                {
                    Director_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Director_Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Director_Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Director_Birthday = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Director", x => x.Director_Id);
                });

            migrationBuilder.CreateTable(
                name: "Gender",
                columns: table => new
                {
                    Gender_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Gender_Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Gender", x => x.Gender_Id);
                });

            migrationBuilder.CreateTable(
                name: "IMDFUser",
                columns: table => new
                {
                    User_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    User_Password = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    User_Email = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_IMDFUser", x => x.User_Id);
                });

            migrationBuilder.CreateTable(
                name: "Movie",
                columns: table => new
                {
                    Movie_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Movie_Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Movie_Synopsis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Movie_Country = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Movie_ReleaseDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Movie_Duration = table.Column<float>(type: "real", nullable: false),
                    Movie_Valoration = table.Column<float>(type: "real", nullable: true),
                    Movie_DirectorId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Movie", x => x.Movie_Id);
                    table.ForeignKey(
                        name: "FK_Movie_Director_Movie_DirectorId",
                        column: x => x.Movie_DirectorId,
                        principalTable: "Director",
                        principalColumn: "Director_Id");
                });

            migrationBuilder.CreateTable(
                name: "ActorXMovie",
                columns: table => new
                {
                    ActorXMovie_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ActorXMovie_ActorId = table.Column<int>(type: "int", nullable: false),
                    ActorXMovie_MovieId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ActorXMovie", x => x.ActorXMovie_Id);
                    table.ForeignKey(
                        name: "FK_ActorXMovie_Actor_ActorXMovie_ActorId",
                        column: x => x.ActorXMovie_ActorId,
                        principalTable: "Actor",
                        principalColumn: "Actor_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ActorXMovie_Movie_ActorXMovie_MovieId",
                        column: x => x.ActorXMovie_MovieId,
                        principalTable: "Movie",
                        principalColumn: "Movie_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Comment",
                columns: table => new
                {
                    Comment_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Comment_Body = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Comment_UserId = table.Column<int>(type: "int", nullable: false),
                    Comment_MovieId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Comment", x => x.Comment_Id);
                    table.ForeignKey(
                        name: "FK_Comment_IMDFUser_Comment_UserId",
                        column: x => x.Comment_UserId,
                        principalTable: "IMDFUser",
                        principalColumn: "User_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Comment_Movie_Comment_MovieId",
                        column: x => x.Comment_MovieId,
                        principalTable: "Movie",
                        principalColumn: "Movie_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Favourite",
                columns: table => new
                {
                    Favourite_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Favourite_MovieId = table.Column<int>(type: "int", nullable: false),
                    Favourite_UserId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Favourite", x => x.Favourite_Id);
                    table.ForeignKey(
                        name: "FK_Favourite_IMDFUser_Favourite_UserId",
                        column: x => x.Favourite_UserId,
                        principalTable: "IMDFUser",
                        principalColumn: "User_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Favourite_Movie_Favourite_MovieId",
                        column: x => x.Favourite_MovieId,
                        principalTable: "Movie",
                        principalColumn: "Movie_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "GenderXMovie",
                columns: table => new
                {
                    GenderXMovie_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GenderXMovie_GenderId = table.Column<int>(type: "int", nullable: false),
                    GenderXMovie_MovieId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GenderXMovie", x => x.GenderXMovie_Id);
                    table.ForeignKey(
                        name: "FK_GenderXMovie_Gender_GenderXMovie_GenderId",
                        column: x => x.GenderXMovie_GenderId,
                        principalTable: "Gender",
                        principalColumn: "Gender_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_GenderXMovie_Movie_GenderXMovie_MovieId",
                        column: x => x.GenderXMovie_MovieId,
                        principalTable: "Movie",
                        principalColumn: "Movie_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ActorXMovie_ActorXMovie_ActorId",
                table: "ActorXMovie",
                column: "ActorXMovie_ActorId");

            migrationBuilder.CreateIndex(
                name: "IX_ActorXMovie_ActorXMovie_MovieId",
                table: "ActorXMovie",
                column: "ActorXMovie_MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_Comment_Comment_MovieId",
                table: "Comment",
                column: "Comment_MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_Comment_Comment_UserId",
                table: "Comment",
                column: "Comment_UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Favourite_Favourite_MovieId",
                table: "Favourite",
                column: "Favourite_MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_Favourite_Favourite_UserId",
                table: "Favourite",
                column: "Favourite_UserId");

            migrationBuilder.CreateIndex(
                name: "IX_GenderXMovie_GenderXMovie_GenderId",
                table: "GenderXMovie",
                column: "GenderXMovie_GenderId");

            migrationBuilder.CreateIndex(
                name: "IX_GenderXMovie_GenderXMovie_MovieId",
                table: "GenderXMovie",
                column: "GenderXMovie_MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_Movie_Movie_DirectorId",
                table: "Movie",
                column: "Movie_DirectorId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ActorXMovie");

            migrationBuilder.DropTable(
                name: "Comment");

            migrationBuilder.DropTable(
                name: "Favourite");

            migrationBuilder.DropTable(
                name: "GenderXMovie");

            migrationBuilder.DropTable(
                name: "Actor");

            migrationBuilder.DropTable(
                name: "IMDFUser");

            migrationBuilder.DropTable(
                name: "Gender");

            migrationBuilder.DropTable(
                name: "Movie");

            migrationBuilder.DropTable(
                name: "Director");
        }
    }
}
