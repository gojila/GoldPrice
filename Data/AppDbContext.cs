using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using GoldPrice.Models;
using Microsoft.Data.SqlClient;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;


namespace GoldPrice.Data
{
    public class AppDbContext : IdentityDbContext<AppUser>
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        public DbSet<GoldPrice.Models.GoldPrice> GoldPrices { get; set; }
        public DbSet<Company> Companies { get; set; }
        public DbSet<GoldPriceLog> GoldPriceLogs { get; set; }
        public DbSet<GoldType> GoldTypes { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Cấu hình mềm xoá
            modelBuilder.Entity<Company>().HasQueryFilter(c => !c.IsDeleted);
            modelBuilder.Entity<Models.GoldPrice>().HasQueryFilter(g => !g.IsDeleted);
            modelBuilder.Entity<GoldPriceLog>().HasQueryFilter(l => !l.IsDeleted);
            modelBuilder.Entity<GoldType>().HasQueryFilter(x => !x.IsDeleted);

            var seedDate = new DateTime(2025, 01, 01);

            // 🧭 Seed data
            modelBuilder.Entity<Company>().HasData(
                new Company
                {
                    CompanyId = 1,
                    CompanyName = "Công ty Vàng SJC",
                    Address = "1 Nguyễn Huệ, Q1, TP.HCM",
                    Email = "info@sjc.com.vn",
                    Website = "https://sjc.com.vn",
                    TaxCode = "0301234567",
                    Phone = "02723889110",
                    CreatedDate = seedDate,
                    ModifiedDate = seedDate,
                }
            );

            modelBuilder.Entity<GoldType>().HasData(
                new GoldType { 
                    GoldTypeId = 1, 
                    GoldTypeName = "SJC 9999",
                    CreatedDate = seedDate,
                    ModifiedDate = seedDate,
                },
                new GoldType { 
                    GoldTypeId = 2, 
                    GoldTypeName = "PNJ 24K",
                    CreatedDate = seedDate,
                    ModifiedDate = seedDate,
                },
                new GoldType { 
                    GoldTypeId = 3, 
                    GoldTypeName = "DOJI 18K",
                    CreatedDate = seedDate,
                    ModifiedDate = seedDate,
                }
            );

            modelBuilder.Entity<Models.GoldPrice>().HasData(
                new Models.GoldPrice
                {
                    GoldPriceId = 1,
                    CompanyId = 1,
                    GoldTypeId = 1,
                    BuyPrice = 7800000,
                    SellPrice = 7850000,
                    IsBuyUpdating = false,
                    IsSellUpdating = false,
                    SortOrder = 1,
                    CreatedDate = seedDate,
                    ModifiedDate = seedDate,
                }
            );

        }
    }
}
