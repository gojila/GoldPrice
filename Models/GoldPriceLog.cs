using System.ComponentModel.DataAnnotations.Schema;

namespace GoldPrice.Models
{
    public class GoldPriceLog : BaseEntity
    {
        public int GoldPriceLogId { get; set; }
        public int GoldPriceId { get; set; }
        [Column(TypeName = "money")]
        public decimal OldBuyPrice { get; set; }
        [Column(TypeName = "money")]
        public decimal OldSellPrice { get; set; }
        [Column(TypeName = "money")]
        public decimal NewBuyPrice { get; set; }
        [Column(TypeName = "money")]
        public decimal NewSellPrice { get; set; }
    }
}
