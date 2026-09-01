namespace DevArt.Models
{
    /// <summary>One line of the shopping cart kept in Session.</summary>
    public class CartItem
    {
        public int ProductId { get; set; }

        public string Name { get; set; }

        public string Variant { get; set; }

        public string Image { get; set; }

        public int Quantity { get; set; }

        public decimal Rate { get; set; }

        public string GiftNote { get; set; }

        public decimal Amount
        {
            get { return Rate * Quantity; }
        }
    }
}
