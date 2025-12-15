using GoldPrice.Data;
using GoldPrice.Models;
using GoldPrice.Models.Dto;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GoldPrice.Controllers
{
    public class GoldPriceLogController : Controller
    {
        private readonly AppDbContext _context;

        public GoldPriceLogController(AppDbContext context)
        {
            _context = context;
        }
        public async Task<IActionResult> Index(int page = 1, int pageSize = 50)
        {
            if (page < 1) page = 1;
            var query = _context.GoldPriceLogs
            .OrderByDescending(x => x.CreatedDate)
            .Select(x => new GoldPriceLogViewModelDto
            {
                GoldPriceLogId = x.GoldPriceLogId,
                CreatedDate = x.CreatedDate,
                Remark = x.Remark,
                GoldPriceId = x.GoldPriceId,
                GoldTypeName = x.GoldPrice.GoldType.GoldTypeName,
                CompanyName = x.GoldPrice.Company.CompanyName,
                OldBuyPrice = x.OldBuyPrice,
                OldSellPrice = x.OldSellPrice,
                NewBuyPrice = x.NewBuyPrice,
                NewSellPrice = x.NewSellPrice
            });

            var totalItems = await query.CountAsync();

            var logs = await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            ViewBag.CurrentPage = page;
            ViewBag.PageSize = pageSize;
            ViewBag.TotalPages = (int)Math.Ceiling(totalItems / (double)pageSize);

            return View(logs);
        }
    }
}
