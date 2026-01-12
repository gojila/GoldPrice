using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GoldPrice.Migrations
{
    /// <inheritdoc />
    public partial class DescribeYourChangesHere : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DisplayFormat",
                table: "Companies",
                type: "nvarchar(250)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Companies",
                keyColumn: "CompanyId",
                keyValue: 1,
                column: "DisplayFormat",
                value: null);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DisplayFormat",
                table: "Companies");
        }
    }
}
