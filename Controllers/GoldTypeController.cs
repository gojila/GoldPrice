using GoldPrice.Data;
using GoldPrice.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GoldPrice.Controllers
{
    public class GoldTypeController : Controller
    {
        private readonly AppDbContext _context;

        public GoldTypeController(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var items = await _context.GoldTypes.ToListAsync();
            return View(items);
        }

        public IActionResult Create()
        {
            return View(new GoldType());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(GoldType model)
        {
            if (ModelState.IsValid)
            {
                model.CreatedDate = DateTime.Now;
                _context.Add(model);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(model);
        }

        public async Task<IActionResult> Edit(int id)
        {
            var item = await _context.GoldTypes.FindAsync(id);
            if (item == null) return NotFound();
            return View("Create", item);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, GoldType model)
        {
            if (id != model.GoldTypeId) return NotFound();

            if (ModelState.IsValid)
            {
                var entity = await _context.GoldTypes.FindAsync(id);
                if (entity == null) return NotFound();

                entity.GoldTypeName = model.GoldTypeName;
                entity.ModifiedBy = "admin";
                entity.ModifiedDate = DateTime.Now;

                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View("Create", model);
        }
    }
}
