namespace GoldPrice.Models.Dto
{
    public class GoldPriceCreateDto
    {
        public int GoldPriceID { get; set; }
        public string GoldTypeName { get; set; }
        public decimal BuyPrice { get; set; }
        public decimal SellPrice { get; set; }
        public bool IsBuyUpdating { get; set; }
        public bool IsSellUpdating { get; set; }
        public int SortOrder { get; set; }
    }
}
