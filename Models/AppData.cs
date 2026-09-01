using System;
using System.Collections.Generic;
using System.Linq;

namespace DevArt.Models
{
    /// <summary>
    /// In-memory data store for the DevArt demo.
    /// Uses generic collections (List&lt;T&gt;, Dictionary&lt;K,V&gt;) as required by
    /// CE545 Section I, Unit 4 - Generics and Collections, and LINQ (Unit 3) to query them.
    /// Replace the bodies with ADO.NET calls when the SQL layer is wired up; no page
    /// or validator needs to change.
    /// </summary>
    public static class AppData
    {
        // ------------------------------------------------------------- customers

        private static readonly List<UserAccount> _users = new List<UserAccount>
        {
            new UserAccount { Id = 1, FullName = "Parth Dhanani", Email = "parth@devart.in", Password = "Devart@123", Phone = "9876543210", City = "Rajkot", Pincode = "360005", CreatedOn = new DateTime(2024, 3, 14) },
            new UserAccount { Id = 2, FullName = "Prem Agravat", Email = "prem123@studio.dev", Password = "Devart@123", Phone = "9876543211", City = "Rajkot", Pincode = "360004", CreatedOn = new DateTime(2024, 3, 27) },
            new UserAccount { Id = 3, FullName = "Dev Chauhan", Email = "dev123@gmail.com", Password = "Devart@123", Phone = "9876543212", City = "Ahmedabad", Pincode = "380015", CreatedOn = new DateTime(2024, 7, 2) },
            new UserAccount { Id = 4, FullName = "Ramanshu Dhanani", Email = "ramanshu321@gmail.com", Password = "Devart@123", Phone = "9876543213", City = "Rajkot", Pincode = "360001", CreatedOn = new DateTime(2025, 1, 19) },
            new UserAccount { Id = 5, FullName = "Om Hirpara", Email = "om665@gmail.com", Password = "Devart@123", Phone = "9876543214", City = "Surat", Pincode = "395007", CreatedOn = new DateTime(2025, 6, 5) },
            new UserAccount { Id = 6, FullName = "Viraj Vaja", Email = "viraj525@gmail.com", Password = "Devart@123", Phone = "9876543215", City = "Vadodara", Pincode = "390001", CreatedOn = new DateTime(2026, 2, 11) }
        };

        private static readonly List<Enquiry> _enquiries = new List<Enquiry>();

        // -------------------------------------------------------------- catalogue

        private static readonly List<Product> _products = new List<Product>
        {
            new Product { Id = 1, Name = "Marigold Essence Doorway Arch", Category = "Torans", Material = "Hand-stitched cotton • Festive Collection", Price = 499m, Stock = 24, Image = "category_torans.jpg", IsNew = true, RatingAverage = 4.8, ReviewCount = 48,
                Description = "Add a touch of artisan charm to your home with this handcrafted toran. Made from soft, durable cotton, it features intricate traditional hand embroidery and unique cultural patterns." },
            new Product { Id = 2, Name = "Beaded Heritage Toran", Category = "Torans", Material = "Glass beadwork • Heirloom quality", Price = 749m, Stock = 12, Image = "category_torans.jpg", IsNew = true, RatingAverage = 4.6, ReviewCount = 21,
                Description = "Heirloom-quality beadwork that brings auspiciousness and colour to a modern doorway, made by Rajkot artisans." },
            new Product { Id = 3, Name = "Velvet Accent Pillow", Category = "Cushion Covers", Material = "Pure velvet • Artisan Signature Series", Price = 499m, Stock = 30, Image = "product_velvet_pillow.jpg", IsNew = true, RatingAverage = 4.7, ReviewCount = 36,
                Description = "A plush velvet accent pillow cover in a deep jewel tone, finished with a hidden zip and piped edges." },
            new Product { Id = 4, Name = "Cushion Cover Set", Category = "Cushion Covers", Material = "Handwoven cotton • Set of two", Price = 899m, Stock = 18, Image = "product_cushion_set.jpg", RatingAverage = 4.5, ReviewCount = 52,
                Description = "A pair of handwoven cotton covers, each a canvas of Gujarat's rich textile heritage, designed for the modern home." },
            new Product { Id = 5, Name = "Indigo Block-Print Cover", Category = "Cushion Covers", Material = "Pure linen • Natural dye", Price = 599m, Stock = 22, Image = "category_cushion.jpg", RatingAverage = 4.4, ReviewCount = 17,
                Description = "Hand block-printed in natural indigo on pure linen, softening beautifully with every wash." },
            new Product { Id = 6, Name = "Artisanal Ceramic Vase", Category = "Sofa & Table Covers", Material = "Stoneware • Studio fired", Price = 1299m, Stock = 9, Image = "product_ceramic_vase.jpg", RatingAverage = 4.9, ReviewCount = 12,
                Description = "A studio-fired stoneware vase with a matte sand glaze, thrown and finished entirely by hand." },
            new Product { Id = 7, Name = "Quilted Sofa Throw Cover", Category = "Sofa & Table Covers", Material = "Quilted cotton • Three-seater", Price = 2400m, Stock = 7, Image = "category_sofacover.jpg", RatingAverage = 4.3, ReviewCount = 26,
                Description = "A three-seater quilted cover that drapes cleanly over the arms and protects upholstery without hiding it." },
            new Product { Id = 8, Name = "Nesting Ash Tables", Category = "Sofa & Table Covers", Material = "Solid ash • Set of two", Price = 6900m, Stock = 4, Image = "product_nesting_tables.jpg", RatingAverage = 4.8, ReviewCount = 8,
                Description = "A pair of nesting side tables in solid ash with a hand-rubbed oil finish." },
            new Product { Id = 9, Name = "Kutch Embroidered Bedsheet", Category = "Bedsheet", Material = "Cotton percale • King size", Price = 1899m, Stock = 15, Image = "category_bedsheet.jpg", IsNew = true, RatingAverage = 4.6, ReviewCount = 31,
                Description = "King-size cotton percale with mirror-work embroidery along the border, finished with two pillow covers." },
            new Product { Id = 10, Name = "Sanganeri Print Bedsheet", Category = "Bedsheet", Material = "Cotton • Double bed", Price = 1499m, Stock = 20, Image = "category_bedsheet.jpg", RatingAverage = 4.2, ReviewCount = 19,
                Description = "Traditional Sanganeri hand-block florals on a soft cotton base, colour-fast and pre-shrunk." },
            new Product { Id = 11, Name = "Woven Linen Scarf - Sage", Category = "Cushion Covers", Material = "Handloom linen", Price = 499m, Stock = 26, Image = "product_velvet_pillow.jpg", RatingAverage = 4.1, ReviewCount = 11,
                Description = "A featherweight handloom linen wrap in a soft sage, woven on a pit loom." },
            new Product { Id = 12, Name = "Festive Torans Trio", Category = "Torans", Material = "Cotton • Set of three", Price = 1299m, Stock = 0, Image = "category_torans.jpg", RatingAverage = 4.7, ReviewCount = 14,
                Description = "Three coordinated torans sized for a main door, a puja room and a window." }
        };

        private static readonly List<Review> _reviews = new List<Review>
        {
            new Review { ProductId = 1, Author = "Bharat Parmar", Title = "Stunning piece!", Rating = 5, PostedOn = DateTime.Today.AddDays(-2),
                Body = "The quality is beyond what I expected. The colours are so vibrant and it truly feels like a work of art at my front door. Highly recommend for festive seasons." },
            new Review { ProductId = 1, Author = "Siddharth Chauhan", Title = "Authentic feel", Rating = 5, PostedOn = DateTime.Today.AddDays(-8),
                Body = "Love the tactile nature of the fabric marigolds. It smells faintly of sandalwood, which was a lovely surprise in the packaging. Beautiful craftsmanship." },
            new Review { ProductId = 1, Author = "Ramesh Sah", Title = "Cultural masterpiece", Rating = 4, PostedOn = DateTime.Today.AddDays(-15),
                Body = "I bought this as a housewarming gift for a friend. The packaging was so elegant I didn't even need to wrap it. She absolutely loves it." },
            new Review { ProductId = 3, Author = "Krupa Joshi", Title = "Beautifully soft", Rating = 5, PostedOn = DateTime.Today.AddDays(-4),
                Body = "The velvet has real depth to it and the colour is exactly as photographed. It has completely lifted our reading corner." }
        };

        // ----------------------------------------------------------------- offers

        private static readonly List<Offer> _offers = new List<Offer>
        {
            new FreeShippingOffer { Id = 1, Code = "FREESHIP150", Name = "Free Shipping", Kicker = "Free Shipping", ShippingFee = 60m, MinimumSpend = 150m, IsActive = true, ExpiresOn = new DateTime(2027, 3, 31),
                Description = "Treat yourself to a little more. Enjoy complimentary standard shipping on all qualifying artisanal purchases." },
            new FlatOffer { Id = 2, Code = "WELCOME15", Name = "Welcome Gift", Kicker = "₹100 OFF", Amount = 100m, MinimumSpend = 500m, IsActive = true, ExpiresOn = new DateTime(2027, 3, 31),
                Description = "For new members of our community. Apply this code to your first handcrafted purchase." },
            new PercentageOffer { Id = 3, Code = "ARTISAN20", Name = "Artisan Toran Collection", Kicker = "20% OFF", Percentage = 20, MinimumSpend = 0m, IsActive = true, ExpiresOn = new DateTime(2027, 3, 31),
                Description = "Enhance your doorways with our torans. Valid on all items in the Toran Decor category." },
            new PercentageOffer { Id = 4, Code = "NEWARTISAN15", Name = "15% OFF First Order", Kicker = "Welcome Offer", Percentage = 15, MinimumSpend = 0m, IsActive = true, ExpiresOn = new DateTime(2027, 3, 31),
                Description = "Fifteen percent off the first order placed on a new DevArt account." },
            new FlatOffer { Id = 5, Code = "DEVARTLOYAL", Name = "₹200 Reward Credit", Kicker = "Bundle Deal", Amount = 200m, MinimumSpend = 1500m, IsActive = true, ExpiresOn = new DateTime(2027, 3, 31),
                Description = "A loyalty reward credit for returning collectors." },
            new PercentageOffer { Id = 6, Code = "DEVART10", Name = "DevArt Welcome 10%", Kicker = "Newsletter", Percentage = 10, MinimumSpend = 0m, IsActive = true, ExpiresOn = new DateTime(2027, 6, 30),
                Description = "Ten percent off, sent to every newsletter subscriber." },
            new PercentageOffer { Id = 7, Code = "FESTIVE25", Name = "Festive Season 25%", Kicker = "Festive", Percentage = 25, MinimumSpend = 2000m, IsActive = true, ExpiresOn = new DateTime(2027, 6, 30),
                Description = "Twenty-five percent off festive orders above two thousand rupees." },
            new PercentageOffer { Id = 8, Code = "NEWHOME15", Name = "New Home 15%", Kicker = "Housewarming", Percentage = 15, MinimumSpend = 0m, IsActive = true, ExpiresOn = new DateTime(2027, 6, 30),
                Description = "Fifteen percent off for customers furnishing a new home." }
        };

        // ----------------------------------------------------------------- orders

        private static readonly List<Order> _orders = BuildSeedOrders();

        private static List<Order> BuildSeedOrders()
        {
            List<Order> orders = new List<Order>();

            Order delivered = new Order
            {
                OrderNumber = "DV-88219",
                CustomerEmail = "parth@devart.in",
                CustomerName = "Parth Dhanani",
                PlacedOn = new DateTime(2026, 8, 12),
                Status = "Delivered",
                PaymentMethod = "COD (Cash On Delivery)",
                SubTotal = 998m,
                Shipping = 0m
            };
            delivered.Lines.Add(new OrderLine { ProductName = "Marigold Essence Doorway Arch", Variant = "Natural / Medium", Quantity = 1, Rate = 499m });
            delivered.Lines.Add(new OrderLine { ProductName = "Woven Linen Scarf - Sage", Variant = "Sage / One size", Quantity = 1, Rate = 499m });
            orders.Add(delivered);

            Order transit = new Order
            {
                OrderNumber = "DV-87502",
                CustomerEmail = "parth@devart.in",
                CustomerName = "Parth Dhanani",
                PlacedOn = new DateTime(2026, 8, 28),
                Status = "In Transit",
                PaymentMethod = "COD (Cash On Delivery)",
                SubTotal = 499m,
                Shipping = 60m
            };
            transit.Lines.Add(new OrderLine { ProductName = "Velvet Accent Pillow", Variant = "Indigo / Standard", Quantity = 1, Rate = 499m });
            orders.Add(transit);

            string[] customers = { "Dev Chauhan", "Ramanshu Dhanani", "Prem Agravat", "Om Hirpara" };
            string[] emails = { "dev123@gmail.com", "ramanshu321@gmail.com", "prem123@studio.dev", "om665@gmail.com" };
            string[] statuses = { "Pending", "Delivered", "Out for Delivery", "Pending" };
            for (int i = 0; i < 8; i++)
            {
                Order o = new Order
                {
                    OrderNumber = "ORD-" + (2094 + i),
                    CustomerName = customers[i % customers.Length],
                    CustomerEmail = emails[i % emails.Length],
                    PlacedOn = new DateTime(2026, 8, 20).AddDays(-i),
                    Status = statuses[i % statuses.Length],
                    PaymentMethod = "COD (Cash On Delivery)",
                    SubTotal = 499m * ((i % 3) + 1),
                    Shipping = 0m
                };
                o.Lines.Add(new OrderLine { ProductName = "Cushion Cover Set", Variant = "Natural / Medium", Quantity = (i % 3) + 1, Rate = 499m });
                orders.Add(o);
            }

            return orders;
        }

        private static readonly List<Address> _addresses = new List<Address>
        {
            new Address { Id = 1, FullName = "Parth Dhanani", Phone = "9876543210", Line1 = "102, Craftmen's Plaza, Kalavad Road",
                City = "Rajkot", State = "Gujarat", Pincode = "360004", Label = "Home", IsDefault = true }
        };

        // ------------------------------------------------------------- user CRUD

        public static IEnumerable<UserAccount> Users
        {
            get { return _users; }
        }

        public static IEnumerable<Enquiry> Enquiries
        {
            get { return _enquiries; }
        }

        public static bool EmailExists(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return false;
            return _users.Any(u => string.Equals(u.Email, email.Trim(), StringComparison.OrdinalIgnoreCase));
        }

        public static void AddUser(UserAccount user)
        {
            if (user == null) throw new ArgumentNullException("user");
            user.Id = _users.Count == 0 ? 1 : _users.Max(u => u.Id) + 1;
            _users.Add(user);
        }

        public static UserAccount FindUser(string email, string password)
        {
            if (string.IsNullOrWhiteSpace(email)) return null;
            return _users.FirstOrDefault(u =>
                string.Equals(u.Email, email.Trim(), StringComparison.OrdinalIgnoreCase) &&
                u.Password == password);
        }

        public static UserAccount FindUserByEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return null;
            return _users.FirstOrDefault(u => string.Equals(u.Email, email.Trim(), StringComparison.OrdinalIgnoreCase));
        }

        public static void UpdateUser(UserAccount user)
        {
            UserAccount existing = _users.FirstOrDefault(u => u.Id == user.Id);
            if (existing == null) return;
            existing.FullName = user.FullName;
            existing.Phone = user.Phone;
            existing.City = user.City;
            existing.Pincode = user.Pincode;
            existing.DateOfBirth = user.DateOfBirth;
            existing.NewsletterOptIn = user.NewsletterOptIn;
        }

        public static bool DeleteUser(int id)
        {
            UserAccount existing = _users.FirstOrDefault(u => u.Id == id);
            return existing != null && _users.Remove(existing);
        }

        public static void AddEnquiry(Enquiry enquiry)
        {
            if (enquiry == null) throw new ArgumentNullException("enquiry");
            enquiry.Id = _enquiries.Count + 1;
            _enquiries.Add(enquiry);
        }

        // ---------------------------------------------------------- product CRUD

        public static IEnumerable<Product> Products
        {
            get { return _products; }
        }

        public static List<string> Categories
        {
            get { return _products.Select(p => p.Category).Distinct().OrderBy(c => c).ToList(); }
        }

        public static Product FindProduct(int id)
        {
            return _products.FirstOrDefault(p => p.Id == id);
        }

        public static List<Product> SearchProducts(string category, string keyword, string sort)
        {
            IEnumerable<Product> query = _products;

            if (!string.IsNullOrWhiteSpace(category) && !string.Equals(category, "All", StringComparison.OrdinalIgnoreCase))
            {
                query = query.Where(p => string.Equals(p.Category, category, StringComparison.OrdinalIgnoreCase));
            }

            if (!string.IsNullOrWhiteSpace(keyword))
            {
                string k = keyword.Trim();
                query = query.Where(p =>
                    p.Name.IndexOf(k, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (p.Category ?? string.Empty).IndexOf(k, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            switch ((sort ?? string.Empty).ToLowerInvariant())
            {
                case "priceasc": query = query.OrderBy(p => p.Price); break;
                case "pricedesc": query = query.OrderByDescending(p => p.Price); break;
                case "rating": query = query.OrderByDescending(p => p.RatingAverage); break;
                default: query = query.OrderByDescending(p => p.IsNew).ThenBy(p => p.Id); break;
            }

            return query.ToList();
        }

        public static void AddProduct(Product product)
        {
            if (product == null) throw new ArgumentNullException("product");
            product.Id = _products.Count == 0 ? 1 : _products.Max(p => p.Id) + 1;
            _products.Add(product);
        }

        public static void UpdateProduct(Product product)
        {
            Product existing = FindProduct(product.Id);
            if (existing == null) return;
            existing.Name = product.Name;
            existing.Category = product.Category;
            existing.Material = product.Material;
            existing.Price = product.Price;
            existing.Stock = product.Stock;
            existing.Description = product.Description;
            existing.Image = product.Image;
        }

        public static bool DeleteProduct(int id)
        {
            Product existing = FindProduct(id);
            return existing != null && _products.Remove(existing);
        }

        public static List<Review> ReviewsFor(int productId)
        {
            return _reviews.Where(r => r.ProductId == productId).OrderByDescending(r => r.PostedOn).ToList();
        }

        public static void AddReview(Review review)
        {
            _reviews.Add(review);
            Product product = FindProduct(review.ProductId);
            if (product == null) return;
            List<Review> all = _reviews.Where(r => r.ProductId == review.ProductId).ToList();
            product.ReviewCount = all.Count;
            product.RatingAverage = Math.Round(all.Average(r => (double)r.Rating), 1);
        }

        // ------------------------------------------------------------ offer CRUD

        public static IEnumerable<Offer> Offers
        {
            get { return _offers; }
        }

        public static List<Offer> ActiveOffers
        {
            get { return _offers.Where(o => o.IsActive && !o.IsExpired).ToList(); }
        }

        public static Offer FindOffer(int id)
        {
            return _offers.FirstOrDefault(o => o.Id == id);
        }

        public static Offer FindOffer(string code)
        {
            if (string.IsNullOrWhiteSpace(code)) return null;
            return _offers.FirstOrDefault(o => string.Equals(o.Code, code.Trim(), StringComparison.OrdinalIgnoreCase));
        }

        public static bool IsValidPromo(string code)
        {
            Offer offer = FindOffer(code);
            return offer != null && offer.IsActive && !offer.IsExpired;
        }

        /// <summary>Percentage discount, kept for the simple cart summary.</summary>
        public static int GetDiscount(string code)
        {
            PercentageOffer offer = FindOffer(code) as PercentageOffer;
            return offer == null ? 0 : offer.Percentage;
        }

        /// <summary>Polymorphic discount: each Offer subclass computes its own amount.</summary>
        public static decimal GetDiscountAmount(string code, decimal subTotal)
        {
            Offer offer = FindOffer(code);
            return offer == null ? 0m : offer.CalculateDiscount(subTotal);
        }

        public static void AddOffer(Offer offer)
        {
            if (offer == null) throw new ArgumentNullException("offer");
            offer.Id = _offers.Count == 0 ? 1 : _offers.Max(o => o.Id) + 1;
            _offers.Add(offer);
        }

        public static void ReplaceOffer(int id, Offer replacement)
        {
            int index = _offers.FindIndex(o => o.Id == id);
            if (index < 0) return;
            replacement.Id = id;
            _offers[index] = replacement;
        }

        public static bool DeleteOffer(int id)
        {
            Offer existing = FindOffer(id);
            return existing != null && _offers.Remove(existing);
        }

        // ------------------------------------------------------------ order CRUD

        public static IEnumerable<Order> Orders
        {
            get { return _orders; }
        }

        public static List<Order> OrdersFor(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return new List<Order>();
            return _orders
                .Where(o => string.Equals(o.CustomerEmail, email.Trim(), StringComparison.OrdinalIgnoreCase))
                .OrderByDescending(o => o.PlacedOn)
                .ToList();
        }

        public static Order FindOrder(string orderNumber)
        {
            return _orders.FirstOrDefault(o => string.Equals(o.OrderNumber, orderNumber, StringComparison.OrdinalIgnoreCase));
        }

        public static void AddOrder(Order order)
        {
            if (order == null) throw new ArgumentNullException("order");
            _orders.Insert(0, order);
        }

        public static void SetOrderStatus(string orderNumber, string status)
        {
            Order order = FindOrder(orderNumber);
            if (order != null) order.Status = status;
        }

        public static string NextOrderNumber()
        {
            int max = _orders
                .Select(o => o.OrderNumber)
                .Where(n => n != null && n.StartsWith("DV-", StringComparison.OrdinalIgnoreCase))
                .Select(n => { int v; return int.TryParse(n.Substring(3), out v) ? v : 0; })
                .DefaultIfEmpty(88000)
                .Max();
            return "DV-" + (max + 1);
        }

        // ---------------------------------------------------------- address CRUD

        public static List<Address> AddressesFor(string email)
        {
            // Addresses are demo data shared by the signed-in customer.
            return _addresses.ToList();
        }

        public static Address FindAddress(int id)
        {
            return _addresses.FirstOrDefault(a => a.Id == id);
        }

        public static void AddAddress(Address address)
        {
            if (address == null) throw new ArgumentNullException("address");
            address.Id = _addresses.Count == 0 ? 1 : _addresses.Max(a => a.Id) + 1;
            if (address.IsDefault)
            {
                _addresses.ForEach(a => a.IsDefault = false);
            }
            _addresses.Add(address);
        }

        // ------------------------------------------------------------ dashboard

        public static decimal TotalSales
        {
            get { return _orders.Sum(o => o.Total); }
        }

        public static int ActiveOrderCount
        {
            get { return _orders.Count(o => o.Status == "In Transit" || o.Status == "Out for Delivery"); }
        }

        public static int PendingOrderCount
        {
            get { return _orders.Count(o => o.Status == "Pending"); }
        }
    }
}
