using GoldPrice.Data;
using GoldPrice.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GoldPrice.Controllers
{
    [Authorize]
    public class CompanyController : Controller
    {
        private readonly AppDbContext _context;

        public CompanyController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Company
        public IActionResult Index()
        {
            var companies = _context.Companies
                .Where(c => !c.IsDeleted)
                .OrderBy(c => c.CompanyName)
                .ToList();
            return View(companies);
        }

        // GET: Company/Create
        public IActionResult Create(int id = 0)
        {
            if (id != 0)
            {
                var company = _context.Companies.Find(id);
                if (company == null) return NotFound();
                return View(company);
            }
            else 
            {
                return View();
            }
        }

        // POST: Company/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Company company)
        {
            if (ModelState.IsValid)
            {
                company.CreatedDate = DateTime.Now;
                _context.Companies.Add(company);
                _context.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            return View(company);
        }

        // GET: Company/Edit/5
        public IActionResult Edit(int id)
        {
            var company = _context.Companies.Find(id);
            if (company == null) return NotFound();
            return View(company);
        }

        // POST: Company/Edit
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(Company company)
        {
            if (ModelState.IsValid)
            {
                var existing = _context.Companies.Find(company.CompanyId);
                if (existing == null) return NotFound();

                existing.CompanyName = company.CompanyName;
                existing.Address = company.Address;
                existing.Email = company.Email;
                existing.Website = company.Website;
                existing.TaxCode = company.TaxCode;
                existing.ModifiedBy = "admin";
                existing.ModifiedDate = DateTime.Now;

                _context.SaveChanges();
                return RedirectToAction("Index", "Company");
            }
            return RedirectToAction("Create","Company", company.CompanyId);
        }

        // GET: Company/Delete/5
        public IActionResult Delete(int id)
        {
            var company = _context.Companies.Find(id);
            if (company == null) return NotFound();

            company.IsDeleted = true;
            company.DeletedBy = "admin";
            company.DeletedDate = DateTime.Now;
            _context.SaveChanges();

            return RedirectToAction("Index", "Company");
        }
    }
}
