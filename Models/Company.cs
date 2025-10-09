using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GoldPrice.Models
{
    public class Company : BaseEntity
    {
        public int CompanyId { get; set; }
        [Required]
        [Column(TypeName = "nvarchar(250)")]
        public string CompanyName { get; set; }
        [Column(TypeName = "nvarchar(250)")]
        public string Address { get; set; }
        [Column(TypeName = "nvarchar(250)")]
        public string Phone { get; set; }
        [Column(TypeName = "nvarchar(250)")]
        public string Email { get; set; }
        [Column(TypeName = "nvarchar(250)")]
        public string Website { get; set; }
        [Column(TypeName = "nvarchar(250)")]
        public string TaxCode { get; set; }
        public bool IsDefault { get; set; }
    }
}
