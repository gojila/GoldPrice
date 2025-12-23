using GoldPrice.Data;
using GoldPrice.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace GoldPrice.Controllers
{
    [AllowAnonymous]
    public class HomeController : Controller
    {
        private readonly AppDbContext _context;
        private readonly ICompositeViewEngine _viewEngine;

        public HomeController(AppDbContext context, ICompositeViewEngine viewEngine)
        {
            _context = context;
            _viewEngine = viewEngine;
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

            var viewName = Request.Cookies["home_view"];
            if (string.IsNullOrEmpty(viewName))
            {
                return View(data);
            }
            else 
            {
                ViewEngineResult result = _viewEngine.FindView(ControllerContext, viewName, isMainPage: false);
                if (result.Success)
                {
                    return View(viewName, data);
                }
                else 
                {
                    return View(data);
                }                
            }
            //return View("IndexSacombankBlue", data);
            //return View(data);
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
