using System.ComponentModel.DataAnnotations.Schema;

namespace GoldPrice.Models.Dto
{
    public class GoldPriceLogViewModelDto
    {
        public int GoldPriceLogId { get; set; }
        public int GoldPriceId { get; set; }
        public decimal OldBuyPrice { get; set; }
        public decimal OldSellPrice { get; set; }
        public decimal NewBuyPrice { get; set; }
        public decimal NewSellPrice { get; set; }
        public string? Remark { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string? GoldTypeName { get; set; }
        public string? CompanyName { get; set; }
    }
}
