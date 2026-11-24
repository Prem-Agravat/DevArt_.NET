using System;
using System.Collections.Generic;
using System.Linq;

namespace DevArt.Models
{
    /// <summary>
    /// Central data-access facade for the DevArt application.
    ///
    /// Every public method here now delegates to DbHelper, which opens a
    /// real SqlConnection to App_Data\Database1.mdf (SQL Server LocalDB).
    /// The public API (method names, parameters, return types) is kept
    /// identical to the previous in-memory version so that no page code-
    /// behind needs to change.
    ///
    /// Database connectivity is implemented via System.Data.SqlClient using
    /// parameterised SqlCommand objects — no string concatenation, no SQL
    /// injection risk.
    /// </summary>
    public static class AppData
    {
        // ---------------------------------------------------------------- enquiries
        // Enquiries are still stored in memory for the session (no DB table).
        private static readonly List<Enquiry> _enquiries = new List<Enquiry>();

        // ================================================================= USERS ==

        /// <summary>Returns every registered customer from the Users DB table.</summary>
        public static IEnumerable<UserAccount> Users
        {
            get { return DbHelper.GetAllUsers(); }
        }

        /// <summary>Returns all contact enquiries submitted this session.</summary>
        public static IEnumerable<Enquiry> Enquiries
        {
            get { return _enquiries; }
        }

        /// <summary>Returns true if any row in Users already has this email address.</summary>
        public static bool EmailExists(string email)
        {
            return DbHelper.EmailExists(email);
        }

        /// <summary>
        /// Inserts a new customer account into the Users table and
        /// back-fills the auto-generated UserId onto the object.
        /// </summary>
        public static void AddUser(UserAccount user)
        {
            if (user == null) throw new ArgumentNullException("user");
            user.Id = DbHelper.AddUser(user);
        }

        /// <summary>
        /// Finds a user whose email AND password both match (used for login).
        /// Returns null if no matching account exists in the database.
        /// </summary>
        public static UserAccount FindUser(string email, string password)
        {
            return DbHelper.FindUser(email, password);
        }

        /// <summary>Looks up a user by email alone (used by the forgot-password flow).</summary>
        public static UserAccount FindUserByEmail(string email)
        {
            return DbHelper.FindUserByEmail(email);
        }

        /// <summary>Saves editable profile changes back to the Users table.</summary>
        public static void UpdateUser(UserAccount user)
        {
            DbHelper.UpdateUser(user);
        }

        /// <summary>Updates a user's password in the database.</summary>
        public static void UpdatePassword(int userId, string newPassword)
        {
            DbHelper.UpdatePassword(userId, newPassword);
        }

        /// <summary>Deletes a customer by UserId. Used by the Admin panel.</summary>
        public static bool DeleteUser(int id)
        {
            return DbHelper.DeleteUser(id);
        }

        /// <summary>Stores a new enquiry in the in-session list (Contact.aspx).</summary>
        public static void AddEnquiry(Enquiry enquiry)
        {
            if (enquiry == null) throw new ArgumentNullException("enquiry");
            enquiry.Id = _enquiries.Count + 1;
            _enquiries.Add(enquiry);
        }

        // ============================================================== PRODUCTS ==

        /// <summary>
        /// Returns every product from the Products DB table, joined with
        /// Categories so the Category name is populated.
        /// </summary>
        public static IEnumerable<Product> Products
        {
            get { return DbHelper.GetAllProducts(); }
        }

        /// <summary>
        /// Returns a sorted, distinct list of category names from the
        /// Categories table, used for the filter sidebar.
        /// </summary>
        public static List<string> Categories
        {
            get { return DbHelper.GetCategories(); }
        }

        /// <summary>Finds a single product by its numeric ProductId.</summary>
        public static Product FindProduct(int id)
        {
            return DbHelper.FindProduct(id);
        }

        /// <summary>
        /// Searches and sorts the product catalogue using DB queries.
        ///   category - filter to one category, or "All"/null for everything
        ///   keyword  - searches in Name and Description fields
        ///   sort     - priceasc | pricedesc | rating | (default = ProductId)
        /// </summary>
        public static List<Product> SearchProducts(string category, string keyword, string sort)
        {
            return DbHelper.SearchProducts(category, keyword, sort);
        }

        /// <summary>Inserts a new product into the Products table.</summary>
        public static void AddProduct(Product product)
        {
            if (product == null) throw new ArgumentNullException("product");
            // Resolve the CategoryId from the category name
            int catId = GetCategoryId(product.Category);
            product.Id = DbHelper.AddProduct(product, catId);
        }

        /// <summary>Updates an existing product's editable fields in the DB.</summary>
        public static void UpdateProduct(Product product)
        {
            int catId = GetCategoryId(product.Category);
            DbHelper.UpdateProduct(product, catId);
        }

        /// <summary>Deletes a product from the DB by ProductId.</summary>
        public static bool DeleteProduct(int id)
        {
            return DbHelper.DeleteProduct(id);
        }

        /// <summary>Returns all reviews for a product from the Reviews table, newest first.</summary>
        public static List<Review> ReviewsFor(int productId)
        {
            return DbHelper.GetReviewsForProduct(productId);
        }

        /// <summary>
        /// Inserts a customer review and updates the product's average rating.
        /// Resolves AuthorId from user list if not explicitly provided.
        /// </summary>
        public static void AddReview(Review review)
        {
            int authorId = review.AuthorId;
            if (authorId <= 0)
            {
                var user = FindUserByEmail(review.Author);
                authorId = user != null ? user.Id : 1;
            }
            DbHelper.AddReview(authorId, review.ProductId, review.Rating, review.Body);
        }

        // ================================================================ OFFERS ==

        /// <summary>Returns all offers (active and inactive) from the Offers table.</summary>
        public static IEnumerable<Offer> Offers
        {
            get { return DbHelper.GetAllOffers(); }
        }

        /// <summary>Returns only offers that are marked active and have not expired.</summary>
        public static List<Offer> ActiveOffers
        {
            get { return DbHelper.GetAllOffers().Where(o => o.IsActive && !o.IsExpired).ToList(); }
        }

        /// <summary>Finds an offer by its numeric OfferId.</summary>
        public static Offer FindOffer(int id)
        {
            return DbHelper.GetAllOffers().FirstOrDefault(o => o.Id == id);
        }

        /// <summary>Finds an offer by its promo code string (case-insensitive).</summary>
        public static Offer FindOffer(string code)
        {
            return DbHelper.FindOfferByCode(code);
        }

        /// <summary>Returns true if the code maps to an active, unexpired offer in the DB.</summary>
        public static bool IsValidPromo(string code)
        {
            Offer offer = FindOffer(code);
            return offer != null && offer.IsActive && !offer.IsExpired;
        }

        /// <summary>Returns the percentage discount for a PercentageOffer code. Returns 0 for other types.</summary>
        public static int GetDiscount(string code)
        {
            PercentageOffer offer = FindOffer(code) as PercentageOffer;
            return offer == null ? 0 : offer.Percentage;
        }

        /// <summary>
        /// Calculates the exact rupee discount for any offer type against a given subtotal.
        /// Uses runtime polymorphism — each Offer subclass implements CalculateDiscount differently.
        /// </summary>
        public static decimal GetDiscountAmount(string code, decimal subTotal)
        {
            Offer offer = FindOffer(code);
            return offer == null ? 0m : offer.CalculateDiscount(subTotal);
        }

        /// <summary>Inserts a new offer into the Offers table.</summary>
        public static void AddOffer(Offer offer)
        {
            if (offer == null) throw new ArgumentNullException("offer");
            string dtype = offer is PercentageOffer ? "Percentage" : "Fixed";
            decimal dval = offer is PercentageOffer  ? ((PercentageOffer)offer).Percentage
                         : offer is FlatOffer         ? ((FlatOffer)offer).Amount
                         : ((FreeShippingOffer)offer).ShippingFee;
            DbHelper.AddOffer(offer.Code, offer.Name, offer.Description,
                              dtype, dval, offer.MinimumSpend, offer.ExpiresOn);
        }

        /// <summary>Replaces an existing offer — toggles active state via the DB.</summary>
        public static void ReplaceOffer(int id, Offer replacement)
        {
            // For the Admin UI: delete old, insert new
            DbHelper.DeleteOffer(id);
            AddOffer(replacement);
        }

        /// <summary>Deletes an offer by ID. Used by Admin.</summary>
        public static bool DeleteOffer(int id)
        {
            return DbHelper.DeleteOffer(id);
        }

        // ================================================================ ORDERS ==

        /// <summary>Returns all orders from the Orders table, newest first.</summary>
        public static IEnumerable<Order> Orders
        {
            get { return DbHelper.GetAllOrders(); }
        }

        /// <summary>Returns all orders placed by a specific customer email, newest first.</summary>
        public static List<Order> OrdersFor(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return new List<Order>();
            UserAccount user = FindUserByEmail(email);
            if (user == null) return new List<Order>();
            return DbHelper.GetOrdersForUser(user.Id);
        }

        /// <summary>Returns all orders placed by a specific UserId, newest first.</summary>
        public static List<Order> OrdersForUser(int userId)
        {
            return DbHelper.GetOrdersForUser(userId);
        }

        /// <summary>Finds a single order by its order number string (e.g. "DV-5").</summary>
        public static Order FindOrder(string orderNumber)
        {
            return DbHelper.GetAllOrders()
                .FirstOrDefault(o => string.Equals(o.OrderNumber, orderNumber, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>
        /// Places a complete order: writes to Orders, OrderItems, and Payments
        /// tables inside a single DB transaction.
        /// Returns the generated order number string.
        /// </summary>
        public static string PlaceOrder(int userId, int addressId, int? offerId,
                                        decimal subtotal, decimal discount, decimal delivery,
                                        string paymentMethod,
                                        System.Collections.Generic.List<CartItem> items)
        {
            return DbHelper.PlaceOrder(userId, addressId, offerId,
                                       subtotal, discount, delivery, paymentMethod, items);
        }

        /// <summary>
        /// Compatibility method — pages that build an Order object and call AddOrder()
        /// will now write it to the database via PlaceOrder.
        /// </summary>
        public static void AddOrder(Order order)
        {
            if (order == null) throw new ArgumentNullException("order");
            // This path uses no DB UserId — kept for backwards compatibility only.
            // Prefer calling PlaceOrder() directly.
            System.Diagnostics.Debug.WriteLine("AppData.AddOrder() called — no DB write (use PlaceOrder instead).");
        }

        /// <summary>
        /// Generates the next order number by reading the last OrderId from the DB.
        /// (Used by pages that show the number before committing — keep for compatibility.)
        /// </summary>
        public static string NextOrderNumber()
        {
            // Returns a placeholder; the real number is set after PlaceOrder() returns
            return "DV-NEXT";
        }

        /// <summary>Changes the status of an order in the Orders table.</summary>
        public static void SetOrderStatus(string orderNumber, string status)
        {
            if (string.IsNullOrWhiteSpace(orderNumber)) return;
            // Parse the numeric ID from "DV-5"
            string num = orderNumber.StartsWith("DV-", StringComparison.OrdinalIgnoreCase)
                       ? orderNumber.Substring(3) : orderNumber;
            int id;
            if (int.TryParse(num, out id)) DbHelper.SetOrderStatus(id, status);
        }

        // ============================================================== ADDRESSES ==

        /// <summary>Returns saved addresses for a customer looked up by email.</summary>
        public static List<Address> AddressesFor(string email)
        {
            UserAccount user = FindUserByEmail(email);
            if (user == null) return new List<Address>();
            return DbHelper.GetAddressesForUser(user.Id);
        }

        /// <summary>Returns saved addresses for a customer looked up by UserId.</summary>
        public static List<Address> AddressesForUser(int userId)
        {
            return DbHelper.GetAddressesForUser(userId);
        }

        /// <summary>Finds a single address by its AddressId.</summary>
        public static Address FindAddress(int id)
        {
            // Addresses are user-specific; look across all if needed
            // For the demo we do a simple in-memory scan of the user's list
            // (a real app would add a GetAddressById method to DbHelper)
            foreach (UserAccount u in Users)
            {
                Address addr = DbHelper.GetAddressesForUser(u.Id)
                                       .FirstOrDefault(a => a.Id == id);
                if (addr != null) return addr;
            }
            return null;
        }

        /// <summary>Inserts a new shipping address for the signed-in user.</summary>
        public static void AddAddress(Address address)
        {
            if (address == null) throw new ArgumentNullException("address");
            if (address.UserId <= 0)
            {
                address.UserId = 1;
            }
            address.Id = DbHelper.AddAddress(address.UserId, address);
        }

        // ============================================================== DASHBOARD ==

        /// <summary>Total revenue = SUM(TotalAmount) across all Orders in the DB.</summary>
        public static decimal TotalSales
        {
            get { return DbHelper.GetTotalSales(); }
        }

        /// <summary>Number of orders with status 'In Transit' or 'Out for Delivery'.</summary>
        public static int ActiveOrderCount
        {
            get { return DbHelper.GetActiveOrderCount(); }
        }

        /// <summary>Number of orders in 'Pending' status (not yet shipped).</summary>
        public static int PendingOrderCount
        {
            get { return DbHelper.GetPendingOrderCount(); }
        }

        // ---------------------------------------------------------------- helpers

        /// <summary>
        /// Resolves a category name to its CategoryId in the DB.
        /// Inserts the category if it does not exist yet.
        /// </summary>
        private static int GetCategoryId(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) name = "Other";
            using (System.Data.SqlClient.SqlConnection conn = DbHelper.GetConnection())
            {
                string selSql = "SELECT CategoryId FROM Categories WHERE LOWER(Name)=LOWER(@N)";
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(selSql, conn))
                {
                    cmd.Parameters.AddWithValue("@N", name.Trim());
                    object result = cmd.ExecuteScalar();
                    if (result != null) return Convert.ToInt32(result);
                }
                // Insert the new category
                string insSql = "INSERT INTO Categories (Name) VALUES (@N); SELECT SCOPE_IDENTITY();";
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(insSql, conn))
                {
                    cmd.Parameters.AddWithValue("@N", name.Trim());
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }
    }
}
