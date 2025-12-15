using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GoldPrice.Models
{
    public class GoldPrice : BaseEntity
    {
        public int GoldPriceId { get; set; }
        public int CompanyId { get; set; }
        public int GoldTypeId { get; set; }
        [DataType(DataType.Date)]
        public DateTime ApplyDate { get; set; }
        [Display(Name = "Giá bán ra")]
        [Column(TypeName = "money")]
        public decimal SellPrice { get; set; }
        [Display(Name = "Giá mua vào")]
        [Column(TypeName = "money")]
        public decimal BuyPrice { get; set; }
        public bool IsBuyUpdating { get; set; } = false;
        public bool IsSellUpdating { get; set; } = false;
        public int SortOrder { get; set; } = 1;
        public Company? Company { get; set; }
        public GoldType? GoldType { get; set; }
        public ICollection<GoldPriceLog>? GoldPriceLogs { get; set; }

    }
}
