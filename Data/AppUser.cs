using Microsoft.AspNetCore.Identity;

namespace GoldPrice.Data
{
    public class AppUser : IdentityUser
    {
        public string? FullName { get; set; }
    }
}
