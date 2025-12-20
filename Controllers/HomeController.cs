using System.Diagnostics;
using GoldPrice.Data;
using GoldPrice.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace GoldPrice.Controllers
{
    [AllowAnonymous]
    public class HomeController : Controller
    {
        private readonly AppDbContext _context;
        public HomeController(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var data = await _context.GoldPrices
                .Include(x => x.Company)
                .Include(x => x.GoldType)
                .OrderBy(x => x.SortOrder)
                .ThenByDescending(x => x.ApplyDate)
                .ToListAsync();

            ViewBag.Company = await _context.Companies.OrderByDescending(c => c.IsDefault).ThenByDescending(c => c.CreatedDate).FirstOrDefaultAsync();

            return View(data);
        }

        //public async Task<IActionResult> Index1()
        //{
        //    var data = await _context.GoldPrices
        //        .Include(x => x.Company)
        //        .Include(x => x.GoldType)
        //        .OrderByDescending(x => x.SortOrder)
        //        .ThenByDescending(x => x.ApplyDate)
        //        .ToListAsync();

        //    ViewBag.Company = await _context.Companies.OrderByDescending(c => c.IsDefault).ThenByDescending(c => c.CreatedDate).FirstOrDefaultAsync();

        //    return View(data);
        //}

    }
}
