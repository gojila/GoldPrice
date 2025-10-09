using GoldPrice.Data;
using GoldPrice.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace GoldPrice.Controllers
{
    public class GoldPriceController : Controller
    {
        private readonly AppDbContext _context;

        public GoldPriceController(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var prices = await _context.GoldPrices
                .Include(g => g.Company)
                .Include(g => g.GoldType)
                .OrderByDescending(g => g.ApplyDate)
                .ToListAsync();
            return View(prices);
        }

        public async Task<IActionResult> Create()
        {
            await LoadDropdowns();
            return View(new GoldPrice.Models.GoldPrice());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(GoldPrice.Models.GoldPrice model)
        {
            if (ModelState.IsValid)
            {
                model.CreatedDate = DateTime.Now;
                _context.Add(model);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            await LoadDropdowns();
            return View(model);
        }

        public async Task<IActionResult> Edit(int id)
        {
            var item = await _context.GoldPrices.FindAsync(id);
            if (item == null) return NotFound();

            await LoadDropdowns();
            return View(item);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, GoldPrice.Models.GoldPrice model)
        {
            if (id != model.GoldPriceId) return NotFound();

            if (ModelState.IsValid)
            {
                var entity = await _context.GoldPrices.FindAsync(id);
                if (entity == null) return NotFound();

                // Log thay đổi
                if (entity.BuyPrice != model.BuyPrice || entity.SellPrice != model.SellPrice)
                {
                    _context.GoldPriceLogs.Add(new GoldPriceLog
                    {
                        GoldPriceId = entity.GoldPriceId,
                        OldBuyPrice = entity.BuyPrice,
                        OldSellPrice = entity.SellPrice,
                        NewBuyPrice = model.BuyPrice,
                        NewSellPrice = model.SellPrice,
                    });
                }

                entity.CompanyId = model.CompanyId;
                entity.GoldTypeId = model.GoldTypeId;
                entity.BuyPrice = model.BuyPrice;
                entity.SellPrice = model.SellPrice;
                entity.ApplyDate = model.ApplyDate;

                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            await LoadDropdowns();
            return View(model);
        }

        private async Task LoadDropdowns()
        {
            ViewBag.Companies = new SelectList(await _context.Companies.ToListAsync(), "Id", "CompanyName");
            ViewBag.GoldTypes = new SelectList(await _context.GoldTypes.ToListAsync(), "Id", "GoldTypeName");
        }
    }
}
