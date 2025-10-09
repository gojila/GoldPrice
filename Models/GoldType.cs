using System.ComponentModel.DataAnnotations.Schema;

namespace GoldPrice.Models
{
    public class GoldType : BaseEntity
    {
        public int GoldTypeId { get; set; }
        [Column(TypeName = "nvarchar(250)")]
        public string GoldTypeName { get; set; } = string.Empty;
        public ICollection<GoldPrice>? GoldPrices { get; set; }
    }
}
