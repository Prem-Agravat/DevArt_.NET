using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DevArt.Models
{
    /// <summary>
    /// One place that owns the Session-backed cart and wishlist, so every page
    /// (Collection, ProductDetail, Cart, Wishlist, the master page badges and the
    /// checkout flow) reads and writes them the same way.
    /// Session is server-side state management - Syllabus Unit 8.
    /// </summary>
    public static class CartService
    {
        public const string CartKey = "CartItems";
        public const string WishlistKey = "Wishlist";
        public const string PromoKey = "PromoCode";
        public const string ShipToKey = "ShipToAddress";
        public const string LastOrderKey = "LastOrderNumber";

        public const int MaxPerLine = 10;
        public const decimal ShippingFee = 60m;
        public const decimal FreeShippingFrom = 1500m;

        private static HttpSessionStateBase Session
        {
            get { return new HttpSessionStateWrapper(HttpContext.Current.Session); }
        }

        // ------------------------------------------------------------------ cart

        public static List<CartItem> Items
        {
            get
            {
                List<CartItem> items = Session[CartKey] as List<CartItem>;
                if (items == null)
                {
                    items = new List<CartItem>();
                    Session[CartKey] = items;
                }
                return items;
            }
        }

        public static int LineCount
        {
            get { return Items.Count; }
        }

        public static int UnitCount
        {
            get { return Items.Sum(i => i.Quantity); }
        }

        /// <summary>Adds a product, merging with an existing line and capping the quantity.</summary>
        public static void Add(Product product, int quantity)
        {
            if (product == null) return;
            if (quantity < 1) quantity = 1;

            CartItem line = Items.FirstOrDefault(i => i.ProductId == product.Id);
            if (line != null)
            {
                line.Quantity = Math.Min(MaxPerLine, line.Quantity + quantity);
                return;
            }

            Items.Add(new CartItem
            {
                ProductId = product.Id,
                Name = product.Name,
                Variant = product.Material,
                Image = product.Image,
                Rate = product.Price,
                Quantity = Math.Min(MaxPerLine, quantity)
            });
        }

        public static void SetQuantity(int productId, int quantity)
        {
            CartItem line = Items.FirstOrDefault(i => i.ProductId == productId);
            if (line == null) return;

            if (quantity <= 0)
            {
                Items.Remove(line);
                return;
            }

            line.Quantity = Math.Min(MaxPerLine, quantity);
        }

        public static void Remove(int productId)
        {
            CartItem line = Items.FirstOrDefault(i => i.ProductId == productId);
            if (line != null) Items.Remove(line);
        }

        public static void Clear()
        {
            Session.Remove(CartKey);
            Session.Remove(PromoKey);
        }

        // --------------------------------------------------------------- totals

        public static decimal SubTotal
        {
            get { return Items.Sum(i => i.Amount); }
        }

        public static string PromoCode
        {
            get { return Session[PromoKey] as string; }
            set { Session[PromoKey] = value; }
        }

        /// <summary>
        /// Polymorphic: each Offer subclass decides its own discount, and a free-shipping
        /// offer is applied against the shipping line rather than the item subtotal.
        /// </summary>
        public static decimal Discount
        {
            get
            {
                Offer offer = AppData.FindOffer(PromoCode);
                if (offer == null || offer is FreeShippingOffer) return 0m;
                return offer.CalculateDiscount(SubTotal);
            }
        }

        public static decimal Shipping
        {
            get
            {
                if (Items.Count == 0) return 0m;
                if (SubTotal >= FreeShippingFrom) return 0m;

                FreeShippingOffer freeShip = AppData.FindOffer(PromoCode) as FreeShippingOffer;
                if (freeShip != null && freeShip.IsUsable(SubTotal)) return 0m;

                return ShippingFee;
            }
        }

        public static decimal Total
        {
            get { return SubTotal - Discount + Shipping; }
        }

        // -------------------------------------------------------------- wishlist

        public static List<int> WishlistIds
        {
            get
            {
                List<int> ids = Session[WishlistKey] as List<int>;
                if (ids == null)
                {
                    ids = new List<int>();
                    Session[WishlistKey] = ids;
                }
                return ids;
            }
        }

        public static List<Product> WishlistProducts
        {
            get { return WishlistIds.Select(AppData.FindProduct).Where(p => p != null).ToList(); }
        }

        /// <summary>Adds to the wishlist; returns false when it was already there.</summary>
        public static bool AddToWishlist(int productId)
        {
            if (WishlistIds.Contains(productId)) return false;
            WishlistIds.Add(productId);
            return true;
        }

        public static void RemoveFromWishlist(int productId)
        {
            WishlistIds.Remove(productId);
        }
    }
}
