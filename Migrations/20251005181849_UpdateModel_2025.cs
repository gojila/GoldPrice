using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GoldPrice.Migrations
{
    /// <inheritdoc />
    public partial class UpdateModel_2025 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Companies",
                keyColumn: "CompanyId",
                keyValue: 1,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "GoldPrices",
                keyColumn: "GoldPriceId",
                keyValue: 1,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 1,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 2,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 3,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Companies",
                keyColumn: "CompanyId",
                keyValue: 1,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 10, 6, 1, 13, 14, 844, DateTimeKind.Local).AddTicks(5551), new DateTime(2025, 10, 6, 1, 13, 14, 846, DateTimeKind.Local).AddTicks(5530) });

            migrationBuilder.UpdateData(
                table: "GoldPrices",
                keyColumn: "GoldPriceId",
                keyValue: 1,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(2786), new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(2791) });

            migrationBuilder.UpdateData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 1,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(962), new DateTime(2025, 10, 6, 1, 13, 14, 847, DateTimeKind.Local).AddTicks(9948) });

            migrationBuilder.UpdateData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 2,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(1536), new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(1533) });

            migrationBuilder.UpdateData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 3,
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(1540), new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(1539) });
        }
    }
}
