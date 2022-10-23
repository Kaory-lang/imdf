using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace imdf.Migrations
{
    public partial class SecondMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Movie_Director_Movie_DirectorId",
                table: "Movie");

            migrationBuilder.DropTable(
                name: "ActorXMovie");

            migrationBuilder.DropTable(
                name: "Director");

            migrationBuilder.DropTable(
                name: "Actor");

            migrationBuilder.DropIndex(
                name: "IX_Movie_Movie_DirectorId",
                table: "Movie");

            migrationBuilder.DropColumn(
                name: "Movie_ReleaseDate",
                table: "Movie");

            migrationBuilder.DropColumn(
                name: "User_Email",
                table: "IMDFUser");

            migrationBuilder.DropColumn(
                name: "User_Name",
                table: "IMDFUser");

            migrationBuilder.DropColumn(
                name: "User_Password",
                table: "IMDFUser");

            migrationBuilder.RenameColumn(
                name: "Movie_DirectorId",
                table: "Movie",
                newName: "Movie_ReleaseYear");

            migrationBuilder.AlterColumn<double>(
                name: "Movie_Valoration",
                table: "Movie",
                type: "float",
                nullable: true,
                oldClrType: typeof(float),
                oldType: "real",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "Movie_Duration",
                table: "Movie",
                type: "int",
                nullable: false,
                oldClrType: typeof(float),
                oldType: "real");

            migrationBuilder.AddColumn<string>(
                name: "Movie_Banner",
                table: "Movie",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Movie_Cast",
                table: "Movie",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Movie_Cover",
                table: "Movie",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Movie_Director",
                table: "Movie",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Vote",
                columns: table => new
                {
                    Vote_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Vote_MovieId = table.Column<int>(type: "int", nullable: false),
                    Vote_UserId = table.Column<int>(type: "int", nullable: false),
                    Vote_Valoration = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Vote", x => x.Vote_Id);
                    table.ForeignKey(
                        name: "FK_Vote_IMDFUser_Vote_UserId",
                        column: x => x.Vote_UserId,
                        principalTable: "IMDFUser",
                        principalColumn: "User_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Vote_Movie_Vote_MovieId",
                        column: x => x.Vote_MovieId,
                        principalTable: "Movie",
                        principalColumn: "Movie_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Vote_Vote_MovieId",
                table: "Vote",
                column: "Vote_MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_Vote_Vote_UserId",
                table: "Vote",
                column: "Vote_UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Vote");

            migrationBuilder.DropColumn(
                name: "Movie_Banner",
                table: "Movie");

            migrationBuilder.DropColumn(
                name: "Movie_Cast",
                table: "Movie");

            migrationBuilder.DropColumn(
                name: "Movie_Cover",
                table: "Movie");

            migrationBuilder.DropColumn(
                name: "Movie_Director",
                table: "Movie");

            migrationBuilder.RenameColumn(
                name: "Movie_ReleaseYear",
                table: "Movie",
                newName: "Movie_DirectorId");

            migrationBuilder.AlterColumn<float>(
                name: "Movie_Valoration",
                table: "Movie",
                type: "real",
                nullable: true,
                oldClrType: typeof(double),
                oldType: "float",
                oldNullable: true);

            migrationBuilder.AlterColumn<float>(
                name: "Movie_Duration",
                table: "Movie",
                type: "real",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<DateTime>(
                name: "Movie_ReleaseDate",
                table: "Movie",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "User_Email",
                table: "IMDFUser",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "User_Name",
                table: "IMDFUser",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "User_Password",
                table: "IMDFUser",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "Actor",
                columns: table => new
                {
                    Actor_Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Actor_Birthday = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Actor_Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Actor_Name = table.Column<string>(type: "nvarchar(max)", nullable: true)
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
                    Director_Birthday = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Director_Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Director_Name = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Director", x => x.Director_Id);
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

            migrationBuilder.CreateIndex(
                name: "IX_Movie_Movie_DirectorId",
                table: "Movie",
                column: "Movie_DirectorId");

            migrationBuilder.CreateIndex(
                name: "IX_ActorXMovie_ActorXMovie_ActorId",
                table: "ActorXMovie",
                column: "ActorXMovie_ActorId");

            migrationBuilder.CreateIndex(
                name: "IX_ActorXMovie_ActorXMovie_MovieId",
                table: "ActorXMovie",
                column: "ActorXMovie_MovieId");

            migrationBuilder.AddForeignKey(
                name: "FK_Movie_Director_Movie_DirectorId",
                table: "Movie",
                column: "Movie_DirectorId",
                principalTable: "Director",
                principalColumn: "Director_Id");
        }
    }
}
