using GoldPrice.Data;
using GoldPrice.Models;
using GoldPrice.Models.Dto;
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
                .Where(g => !g.IsDeleted)
                .OrderByDescending(g => g.ApplyDate)
                .ToListAsync();
            return View(prices);
        }

        [HttpGet]
        public async Task<IActionResult> Create()
        {
            await LoadDropdowns();
            return View(new GoldPrice.Models.GoldPrice());
        }

        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> Create(GoldPrice.Models.GoldPrice model)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        model.CreatedDate = DateTime.Now;
        //        _context.Add(model);
        //        await _context.SaveChangesAsync();
        //        return RedirectToAction(nameof(Index));
        //    }

        //    await LoadDropdowns();
        //    return View(model);
        //}

        [HttpPost]
        [Route("goldprice/post_create")]
        public async Task<IActionResult> PostCreate([FromBody] GoldPriceCreateDto dto)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            try 
            {
                if (dto.GoldPriceID == 0)
                {
                    GoldType goldType = new GoldType();

                    goldType.GoldTypeName = dto.GoldTypeName;
                    goldType.Remark = dto.GoldTypeName;

                    _context.Add(goldType);
                    await _context.SaveChangesAsync();

                    Models.GoldPrice goldPrice = new Models.GoldPrice();

                    goldPrice.CompanyId = 1;
                    goldPrice.GoldTypeId = goldType.GoldTypeId;
                    goldPrice.BuyPrice = dto.BuyPrice;
                    goldPrice.SellPrice = dto.SellPrice;
                    goldPrice.IsBuyUpdating = dto.IsBuyUpdating;
                    goldPrice.IsSellUpdating = dto.IsSellUpdating;
                    goldPrice.ApplyDate = DateTime.Now;

                    _context.Add(goldPrice);

                    _context.GoldPriceLogs.Add(new GoldPriceLog
                    {
                        GoldPriceId = goldPrice.GoldPriceId,
                        OldBuyPrice = goldPrice.BuyPrice,
                        OldSellPrice = goldPrice.SellPrice,
                        NewBuyPrice = goldPrice.BuyPrice,
                        NewSellPrice = goldPrice.SellPrice,
                    });

                    await _context.SaveChangesAsync();
                }
                else 
                {
                    var goldPrice = await _context.GoldPrices.FindAsync(dto.GoldPriceID);
                    if (goldPrice != null) 
                    {
                        var goldType = await _context.GoldTypes.FindAsync(goldPrice.GoldTypeId);
                        if (goldType != null)
                        {
                            goldType.GoldTypeName = dto.GoldTypeName;
                            goldType.Remark = dto.GoldTypeName;
                        }

                        goldPrice.BuyPrice = dto.BuyPrice;
                        goldPrice.SellPrice = dto.SellPrice;
                        goldPrice.IsBuyUpdating = dto.IsBuyUpdating;
                        goldPrice.IsSellUpdating = dto.IsSellUpdating;
                        goldPrice.ApplyDate = DateTime.Now;

                        _context.GoldPriceLogs.Add(new GoldPriceLog
                        {
                            GoldPriceId = goldPrice.GoldPriceId,
                            OldBuyPrice = goldPrice.BuyPrice,
                            OldSellPrice = goldPrice.SellPrice,
                            NewBuyPrice = goldPrice.BuyPrice,
                            NewSellPrice = goldPrice.SellPrice,
                        });

                        await _context.SaveChangesAsync();
                    }
                }
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message});
            }
        }

        [HttpGet]
        [Route("goldprice/get/{id}")]
        public async Task<IActionResult> Get(int id)
        {
            try 
            {
                var item = await _context.GoldPrices
                    .Include(x => x.GoldType)
                    .Where(x => x.GoldPriceId == id)
                    .Select(x => new
                    {
                        goldTypeName = x.GoldType.GoldTypeName,
                        buyPrice = x.BuyPrice,
                        sellPrice = x.SellPrice,
                        isBuyUpdating = x.IsBuyUpdating,
                        isSellUpdating = x.IsSellUpdating
                    })
                    .FirstOrDefaultAsync();

                if (item == null) return NotFound();

                return Json(item);
            }
            catch (Exception ex) 
            {
                return Json(new { success = false, message = ex.Message });
            }
            
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

        [HttpPost]
        [Route("goldprice/delete")]
        public async Task<IActionResult> Delete([FromBody] List<int> ids)
        {
            try 
            {
                if (ids == null || ids.Count == 0)
                    return BadRequest("Không có dữ liệu");

                var items = await _context.GoldPrices.Where(x => ids.Contains(x.GoldPriceId)).ToListAsync();

                if (!items.Any())
                    return NotFound();

                //_context.GoldPrices.RemoveRange(items);
                foreach (var item in items)
                {
                    item.IsDeleted = true;
                    item.DeletedDate = DateTime.Now;
                    item.DeletedBy = User?.Identity?.Name ?? "system";
                }

                await _context.SaveChangesAsync();

                return Ok(new { success = true });
            }
            catch (Exception ex) 
            { 
                return BadRequest(ex.Message);
            }
            
        }


        private async Task LoadDropdowns()
        {
            ViewBag.Companies = new SelectList(await _context.Companies.ToListAsync(), "Id", "CompanyName");
            ViewBag.GoldTypes = new SelectList(await _context.GoldTypes.ToListAsync(), "Id", "GoldTypeName");
        }
    }
}
