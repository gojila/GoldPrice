using Microsoft.AspNetCore.Identity;

namespace GoldPrice.Data
{
    public static class IdentitySeeder
    {
        public static async Task SeedAsync(IServiceProvider services)
        {
            var userManager = services.GetRequiredService<UserManager<AppUser>>();
            var roleManager = services.GetRequiredService<RoleManager<IdentityRole>>();

            // 1️⃣ Tạo role nếu chưa có
            if (!await roleManager.RoleExistsAsync("Admin"))
            {
                await roleManager.CreateAsync(new IdentityRole("Admin"));
            }

            // 2️⃣ Kiểm tra user
            var admin = await userManager.FindByNameAsync("admin");

            if (admin == null)
            {
                admin = new AppUser
                {
                    UserName = "admin",
                    Email = "admin@goldprice.local",
                    FullName = "Administrator"
                };

                var createResult = await userManager.CreateAsync(admin, "123456");

                // 🔴 QUAN TRỌNG
                if (!createResult.Succeeded)
                {
                    var errors = string.Join(", ",
                        createResult.Errors.Select(e => e.Description));

                    throw new Exception("Create admin failed: " + errors);
                }

                // 3️⃣ CHỈ add role khi create OK
                await userManager.AddToRoleAsync(admin, "Admin");
            }
        }
    }

}
