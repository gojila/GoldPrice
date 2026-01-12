using System.ComponentModel.DataAnnotations.Schema;

namespace GoldPrice.Models
{
    public abstract class BaseEntity
    {
        [Column(TypeName = "nvarchar(250)")]
        public string? RecordStatus { get; set; } = "Active";
        [Column(TypeName = "nvarchar(500)")]
        public string? Remark { get; set; }
        [Column(TypeName = "nvarchar(250)")]
        public string? CreatedBy { get; set; } = "admin";

        [Column(TypeName = "datetime")]
        public DateTime? CreatedDate { get; set; } = DateTime.Now;
        [Column(TypeName = "nvarchar(250)")]
        public string? ModifiedBy { get; set; } = "admin";
        [Column(TypeName = "datetime")]
        public DateTime? ModifiedDate { get; set; } = DateTime.Now;
        public bool IsDeleted { get; set; } = false;
        [Column(TypeName = "nvarchar(250)")]
        public string? DeletedBy { get; set; }
        [Column(TypeName = "datetime")]
        public DateTime? DeletedDate { get; set; }
    }
}
