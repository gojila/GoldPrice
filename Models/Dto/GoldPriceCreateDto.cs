namespace GoldPrice.Models.Dto
{
    public class GoldPriceCreateDto
    {
        public string GoldTypeName { get; set; }
        public decimal BuyPrice { get; set; }
        public decimal SellPrice { get; set; }
        public bool IsBuyUpdating { get; set; }
        public bool IsSellUpdating { get; set; }
    }
}
