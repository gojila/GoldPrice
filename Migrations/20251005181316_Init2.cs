using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace GoldPrice.Migrations
{
    /// <inheritdoc />
    public partial class Init2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsBuyUpdating",
                table: "GoldPrices",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "IsSellUpdating",
                table: "GoldPrices",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<int>(
                name: "SortOrder",
                table: "GoldPrices",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.InsertData(
                table: "Companies",
                columns: new[] { "CompanyId", "Address", "CompanyName", "CreatedBy", "CreatedDate", "DeletedBy", "DeletedDate", "Email", "IsDefault", "IsDeleted", "ModifiedBy", "ModifiedDate", "Phone", "RecordStatus", "Remark", "TaxCode", "Website" },
                values: new object[] { 1, "1 Nguyễn Huệ, Q1, TP.HCM", "Công ty Vàng SJC", "admin", new DateTime(2025, 10, 6, 1, 13, 14, 844, DateTimeKind.Local).AddTicks(5551), null, null, "info@sjc.com.vn", false, false, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 846, DateTimeKind.Local).AddTicks(5530), "02723889110", "Active", null, "0301234567", "https://sjc.com.vn" });

            migrationBuilder.InsertData(
                table: "GoldTypes",
                columns: new[] { "GoldTypeId", "CreatedBy", "CreatedDate", "DeletedBy", "DeletedDate", "GoldTypeName", "IsDeleted", "ModifiedBy", "ModifiedDate", "RecordStatus", "Remark" },
                values: new object[,]
                {
                    { 1, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(962), null, null, "SJC 9999", false, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 847, DateTimeKind.Local).AddTicks(9948), "Active", null },
                    { 2, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(1536), null, null, "PNJ 24K", false, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(1533), "Active", null },
                    { 3, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(1540), null, null, "DOJI 18K", false, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(1539), "Active", null }
                });

            migrationBuilder.InsertData(
                table: "GoldPrices",
                columns: new[] { "GoldPriceId", "ApplyDate", "BuyPrice", "CompanyId", "CreatedBy", "CreatedDate", "DeletedBy", "DeletedDate", "GoldTypeId", "IsBuyUpdating", "IsDeleted", "IsSellUpdating", "ModifiedBy", "ModifiedDate", "RecordStatus", "Remark", "SellPrice", "SortOrder" },
                values: new object[] { 1, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 7800000m, 1, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(2786), null, null, 1, false, false, false, "admin", new DateTime(2025, 10, 6, 1, 13, 14, 848, DateTimeKind.Local).AddTicks(2791), "Active", null, 7850000m, 1 });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "GoldPrices",
                keyColumn: "GoldPriceId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Companies",
                keyColumn: "CompanyId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "GoldTypes",
                keyColumn: "GoldTypeId",
                keyValue: 1);

            migrationBuilder.DropColumn(
                name: "IsBuyUpdating",
                table: "GoldPrices");

            migrationBuilder.DropColumn(
                name: "IsSellUpdating",
                table: "GoldPrices");

            migrationBuilder.DropColumn(
                name: "SortOrder",
                table: "GoldPrices");
        }
    }
}
