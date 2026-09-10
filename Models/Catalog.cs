using System;
using System.Collections.Generic;

namespace DevArt.Models
{
    /// <summary>
    /// Anything that can appear in a DevArt listing. Abstract base for Product and Offer
    /// (Syllabus Unit 2 - abstraction and inheritance).
    /// </summary>
    public abstract class CatalogItem
    {
        public int Id { get; set; }

        public string Name { get; set; }

        /// <summary>Short label shown on the card - each subclass answers differently.</summary>
        public abstract string Badge { get; }

        public override string ToString()
        {
            return Name;
        }
    }

    /// <summary>A sellable handicraft.</summary>
    public class Product : CatalogItem
    {
        public string Category { get; set; }

        public string Material { get; set; }

        public decimal Price { get; set; }

        public int Stock { get; set; }

        public string Image { get; set; }

        public string Description { get; set; }

        public bool IsNew { get; set; }

        public double RatingAverage { get; set; }

        public int ReviewCount { get; set; }

        public override string Badge
        {
            get { return IsNew ? "New Collection" : Category; }
        }

        public bool InStock
        {
            get { return Stock > 0; }
        }
    }

    /// <summary>A customer review shown on ProductDetail.aspx.</summary>
    public class Review
    {
        public int ProductId { get; set; }

        public string Author { get; set; }

        public string Title { get; set; }

        public string Body { get; set; }

        public int Rating { get; set; }

        public DateTime PostedOn { get; set; }

        public string Ago
        {
            get
            {
                int days = (int)(DateTime.Today - PostedOn.Date).TotalDays;
                if (days <= 0) return "today";
                if (days == 1) return "1 day ago";
                if (days < 7) return days + " days ago";
                if (days < 14) return "1 week ago";
                if (days < 30) return (days / 7) + " weeks ago";
                return (days / 30) + " months ago";
            }
        }
    }

    // ---------------------------------------------------------------- offers

    /// <summary>
    /// A promotional offer. The three subclasses each calculate their discount
    /// differently - runtime polymorphism drives the cart total.
    /// </summary>
    public abstract class Offer : CatalogItem
    {
        public string Code { get; set; }

        public string Kicker { get; set; }

        public string Description { get; set; }

        public decimal MinimumSpend { get; set; }

        public DateTime ExpiresOn { get; set; }

        public bool IsActive { get; set; }

        public bool IsExpired
        {
            get { return ExpiresOn.Date < DateTime.Today; }
        }

        public bool IsUsable(decimal subTotal)
        {
            return IsActive && !IsExpired && subTotal >= MinimumSpend;
        }

        /// <summary>How much comes off a given subtotal. Overridden per offer type.</summary>
        public abstract decimal CalculateDiscount(decimal subTotal);

        /// <summary>Human-readable discount, e.g. "15% OFF".</summary>
        public abstract string DiscountLabel { get; }

        public override string Badge
        {
            get { return Kicker; }
        }
    }

    /// <summary>Takes a percentage off the subtotal.</summary>
    public class PercentageOffer : Offer
    {
        public int Percentage { get; set; }

        public override decimal CalculateDiscount(decimal subTotal)
        {
            if (!IsUsable(subTotal)) return 0m;
            return Math.Round(subTotal * Percentage / 100m, 0);
        }

        public override string DiscountLabel
        {
            get { return Percentage + "% OFF"; }
        }
    }

    /// <summary>Takes a flat rupee amount off the subtotal.</summary>
    public class FlatOffer : Offer
    {
        public decimal Amount { get; set; }

        public override decimal CalculateDiscount(decimal subTotal)
        {
            if (!IsUsable(subTotal)) return 0m;
            return Math.Min(Amount, subTotal);
        }

        public override string DiscountLabel
        {
            get { return "₹" + Amount.ToString("N0") + " OFF"; }
        }
    }

    /// <summary>Waives the shipping fee instead of touching the item subtotal.</summary>
    public class FreeShippingOffer : Offer
    {
        public decimal ShippingFee { get; set; }

        public override decimal CalculateDiscount(decimal subTotal)
        {
            if (!IsUsable(subTotal)) return 0m;
            return ShippingFee;
        }

        public override string DiscountLabel
        {
            get { return "Free Delivery"; }
        }
    }

    // ---------------------------------------------------------------- orders

    public class Address
    {
        public int Id { get; set; }

        public string FullName { get; set; }

        public string Phone { get; set; }

        public string Line1 { get; set; }

        public string Line2 { get; set; }

        public string City { get; set; }

        public string State { get; set; }

        public string Pincode { get; set; }

        /// <summary>Home / Office / Other.</summary>
        public string Label { get; set; }

        public bool IsDefault { get; set; }

        public string OneLine
        {
            get
            {
                string second = string.IsNullOrWhiteSpace(Line2) ? string.Empty : Line2 + ", ";
                return Line1 + ", " + second + City + ", " + State + " " + Pincode;
            }
        }
    }

    public class OrderLine
    {
        public string ProductName { get; set; }

        public string Variant { get; set; }

        public int Quantity { get; set; }

        public decimal Rate { get; set; }

        public decimal Amount
        {
            get { return Rate * Quantity; }
        }
    }

    public class Order
    {
        public Order()
        {
            Lines = new List<OrderLine>();
        }

        public string OrderNumber { get; set; }

        public string CustomerEmail { get; set; }

        public string CustomerName { get; set; }

        public DateTime PlacedOn { get; set; }

        /// <summary>Pending / In Transit / Out for Delivery / Delivered.</summary>
        public string Status { get; set; }

        public string PaymentMethod { get; set; }

        public decimal SubTotal { get; set; }

        public decimal Discount { get; set; }

        public decimal Shipping { get; set; }

        public Address ShipTo { get; set; }

        public List<OrderLine> Lines { get; private set; }

        public decimal Total
        {
            get { return SubTotal - Discount + Shipping; }
        }

        public DateTime EstimatedDelivery
        {
            get { return PlacedOn.AddDays(6); }
        }

        /// <summary>CSS modifier used by the status pill.</summary>
        public string StatusClass
        {
            get
            {
                switch ((Status ?? string.Empty).ToLowerInvariant())
                {
                    case "delivered": return "pill-green";
                    case "in transit":
                    case "out for delivery": return "pill-blue";
                    default: return "pill-amber";
                }
            }
        }
    }
}
