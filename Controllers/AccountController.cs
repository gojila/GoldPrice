using GoldPrice.Data;
using GoldPrice.Models.Dto;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace GoldPrice.Controllers
{
    public class AccountController : Controller
    {
        private readonly SignInManager<AppUser> _signIn;
        public AccountController(SignInManager<AppUser> signIn)
        {
            _signIn = signIn;
        }

        [AllowAnonymous]
        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(string username, string password, bool rememberMe)
        {
            var result = await _signIn.PasswordSignInAsync(
                username,
                password,
                rememberMe,
                lockoutOnFailure: false);

            if (result.Succeeded) 
            {
                //return RedirectToAction("Index", "Admin");
                return RedirectToAction("Index", "GoldPrice");
            }
                
            ViewBag.LoginError = "Sai tài khoản hoặc mật khẩu";
            return View();
        }
        public async Task<IActionResult> Logout()
        {
            await _signIn.SignOutAsync();
            return RedirectToAction("Login");
        }
    }
}
