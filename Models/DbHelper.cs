using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace DevArt.Models
{
    /// <summary>
    /// Database helper class for DevArt application.
    /// Every method follows the standard 7-step ADO.NET pattern:
    ///   Step 1 - Take the connection string from database
    ///   Step 2 - Create the connection object (SqlConnection)
    ///   Step 3 - Create the command object (SqlCommand)
    ///   Step 4 - Open the connection
    ///   Step 5 - Execute the command
    ///   Step 6 - Close the connection
    ///   Step 7 - Display the message / return the result
    /// </summary>
    public static class DbHelper
    {
        // ----------------------------------------------------------------
        // Single shared connection string pointing to Database1.mdf
        // ----------------------------------------------------------------
        private static readonly string connectionString =
            @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\RKU\sem 5\DevArt\App_Data\Database1.mdf;Integrated Security=True";


        // ================================================================
        //  USERS
        // ================================================================

        /// <summary>
        /// Returns every registered user from the Users table.
        /// </summary>
        public static List<UserAccount> GetAllUsers()
        {
            List<UserAccount> list = new List<UserAccount>();

            // Step 1 - take the connection string
            // (already declared above as connectionString)

            // Step 2 - create the connection object
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3 - create the command object
            string query = "SELECT UserId, Name, Email, PasswordHash, Phone, CreatedAt FROM Users ORDER BY CreatedAt DESC";
            SqlCommand cmd = new SqlCommand(query, con);

            // Step 4 - open the connection
            con.Open();

            // Step 5 - execute the command
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                list.Add(new UserAccount
                {
                    Id        = reader.GetInt32(0),
                    FullName  = reader.GetString(1),
                    Email     = reader.GetString(2),
                    Password  = reader.GetString(3),
                    Phone     = reader["Phone"] == DBNull.Value ? "" : reader.GetString(4),
                    CreatedOn = reader.GetDateTime(5)
                });
            }
            reader.Close();

            // Step 6 - close the connection
            con.Close();

            // Step 7 - return the result
            return list;
        }

        /// <summary>
        /// Finds one user by email address (case-insensitive).
        /// Returns null if no matching account exists.
        /// </summary>
        public static UserAccount FindUserByEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return null;

            // Step 1 - connection string
            // Step 2 - connection object
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3 - command object
            string query = "SELECT UserId, Name, Email, PasswordHash, Phone, CreatedAt FROM Users WHERE LOWER(Email) = LOWER(@Email)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Email", email.Trim());

            // Step 4 - open the connection
            con.Open();

            // Step 5 - execute
            UserAccount user = null;
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                user = new UserAccount
                {
                    Id        = reader.GetInt32(0),
                    FullName  = reader.GetString(1),
                    Email     = reader.GetString(2),
                    Password  = reader.GetString(3),
                    Phone     = reader["Phone"] == DBNull.Value ? "" : reader.GetString(4),
                    CreatedOn = reader.GetDateTime(5)
                };
            }
            reader.Close();

            // Step 6 - close connection
            con.Close();

            // Step 7 - return result
            return user;
        }

        /// <summary>
        /// Finds a user whose email AND password both match (used for login).
        /// Returns null if credentials do not match any account.
        /// </summary>
        public static UserAccount FindUser(string email, string password)
        {
            if (string.IsNullOrWhiteSpace(email)) return null;
            UserAccount user = FindUserByEmail(email);
            if (user == null) return null;
            return user.Password == password ? user : null;
        }

        /// <summary>
        /// Returns true when any row in Users already has this email.
        /// </summary>
        public static bool EmailExists(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return false;

            // Step 2 - connection object
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3 - command object
            string query = "SELECT COUNT(*) FROM Users WHERE LOWER(Email) = LOWER(@Email)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Email", email.Trim());

            // Step 4 - open
            con.Open();

            // Step 5 - execute
            int count = (int)cmd.ExecuteScalar();

            // Step 6 - close
            con.Close();

            // Step 7 - return result
            return count > 0;
        }

        /// <summary>
        /// Inserts a new customer into the Users table.
        /// Returns the auto-generated UserId.
        /// </summary>
        public static int AddUser(UserAccount user)
        {
            // Step 2 - connection object
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3 - command object (insert into Users)
            string query = @"INSERT INTO Users (Name, Email, PasswordHash, Phone, CreatedAt)
                             VALUES (@Name, @Email, @Pass, @Phone, @Created);
                             SELECT SCOPE_IDENTITY();";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Name",    user.FullName);
            cmd.Parameters.AddWithValue("@Email",   user.Email);
            cmd.Parameters.AddWithValue("@Pass",    user.Password);
            cmd.Parameters.AddWithValue("@Phone",   string.IsNullOrWhiteSpace(user.Phone) ? (object)DBNull.Value : user.Phone);
            cmd.Parameters.AddWithValue("@Created", DateTime.Now);

            // Step 4 - open
            con.Open();

            // Step 5 - execute (returns the new UserId)
            int newId = Convert.ToInt32(cmd.ExecuteScalar());

            // Step 6 - close
            con.Close();

            // Step 7 - return new ID
            return newId;
        }

        /// <summary>
        /// Updates the profile fields (Name, Phone) for an existing user.
        /// </summary>
        public static void UpdateUser(UserAccount user)
        {
            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = "UPDATE Users SET Name = @Name, Phone = @Phone WHERE UserId = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Name",  user.FullName);
            cmd.Parameters.AddWithValue("@Phone", string.IsNullOrWhiteSpace(user.Phone) ? (object)DBNull.Value : user.Phone);
            cmd.Parameters.AddWithValue("@Id",    user.Id);

            // Step 4
            con.Open();

            // Step 5
            cmd.ExecuteNonQuery();

            // Step 6
            con.Close();

            // Step 7 - (no return value needed for update)
        }

        /// <summary>
        /// Updates a user's password in the database.
        /// </summary>
        public static void UpdatePassword(int userId, string newPassword)
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "UPDATE Users SET PasswordHash = @Pass WHERE UserId = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Pass", newPassword);
            cmd.Parameters.AddWithValue("@Id",   userId);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        /// <summary>
        /// Deletes a user by their UserId. Used by the Admin panel.
        /// Returns true if a row was deleted.
        /// </summary>
        public static bool DeleteUser(int id)
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "DELETE FROM Users WHERE UserId = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Id", id);
            con.Open();
            int rows = cmd.ExecuteNonQuery();
            con.Close();
            return rows > 0;
        }


        // ================================================================
        //  ADMINS
        // ================================================================

        /// <summary>
        /// Checks if an admin with the given email and password exists.
        /// Used for Admin login page.
        /// </summary>
        public static bool AdminExists(string email, string password)
        {
            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = "SELECT COUNT(*) FROM Admins WHERE LOWER(Email) = LOWER(@Email) AND PasswordHash = @Pass";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Email", email.Trim());
            cmd.Parameters.AddWithValue("@Pass",  password);

            // Step 4
            con.Open();

            // Step 5
            int count = (int)cmd.ExecuteScalar();

            // Step 6
            con.Close();

            // Step 7
            return count > 0;
        }


        // ================================================================
        //  CATEGORIES
        // ================================================================

        /// <summary>
        /// Returns all category names from the Categories table.
        /// </summary>
        public static List<string> GetCategories()
        {
            List<string> list = new List<string>();

            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = "SELECT Name FROM Categories ORDER BY Name";
            SqlCommand cmd = new SqlCommand(query, con);

            // Step 4
            con.Open();

            // Step 5
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
                list.Add(reader.GetString(0));
            reader.Close();

            // Step 6
            con.Close();

            // Step 7
            return list;
        }

        /// <summary>
        /// Finds a CategoryId for the given category name.
        /// Inserts a new category row if it does not already exist.
        /// </summary>
        public static int GetOrCreateCategoryId(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) name = "Other";

            SqlConnection con = new SqlConnection(connectionString);

            // Check if category already exists
            string selectQuery = "SELECT CategoryId FROM Categories WHERE LOWER(Name) = LOWER(@Name)";
            SqlCommand selectCmd = new SqlCommand(selectQuery, con);
            selectCmd.Parameters.AddWithValue("@Name", name.Trim());
            con.Open();
            object result = selectCmd.ExecuteScalar();

            if (result != null)
            {
                con.Close();
                return Convert.ToInt32(result);
            }

            // Category not found — insert it
            string insertQuery = "INSERT INTO Categories (Name) VALUES (@Name); SELECT SCOPE_IDENTITY();";
            SqlCommand insertCmd = new SqlCommand(insertQuery, con);
            insertCmd.Parameters.AddWithValue("@Name", name.Trim());
            int newId = Convert.ToInt32(insertCmd.ExecuteScalar());
            con.Close();
            return newId;
        }


        // ================================================================
        //  PRODUCTS
        // ================================================================

        /// <summary>
        /// Returns all products from the Products table, joined with
        /// the Categories table to get the category name.
        /// </summary>
        public static List<Product> GetAllProducts()
        {
            List<Product> list = new List<Product>();

            // Step 2 - connection object
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3 - command object
            string query = @"SELECT p.ProductId, p.Name, c.Name AS Category,
                                    p.Description, p.Price, p.Stock,
                                    p.Image, p.Rating, p.IsAvailable
                             FROM Products p
                             LEFT JOIN Categories c ON p.CategoryId = c.CategoryId
                             ORDER BY p.ProductId";
            SqlCommand cmd = new SqlCommand(query, con);

            // Step 4 - open
            con.Open();

            // Step 5 - execute
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
                list.Add(MapProduct(reader));
            reader.Close();

            // Step 6 - close
            con.Close();

            // Step 7 - return result
            return list;
        }

        /// <summary>
        /// Finds a single product by its ProductId.
        /// Returns null if not found.
        /// </summary>
        public static Product FindProduct(int id)
        {
            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"SELECT p.ProductId, p.Name, c.Name AS Category,
                                    p.Description, p.Price, p.Stock,
                                    p.Image, p.Rating, p.IsAvailable
                             FROM Products p
                             LEFT JOIN Categories c ON p.CategoryId = c.CategoryId
                             WHERE p.ProductId = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Id", id);

            // Step 4
            con.Open();

            // Step 5
            Product product = null;
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read()) product = MapProduct(reader);
            reader.Close();

            // Step 6
            con.Close();

            // Step 7
            return product;
        }

        /// <summary>
        /// Searches and sorts products.
        ///   category - filter by category name, or null/All for everything
        ///   keyword  - searches in Name and Description
        ///   sort     - priceasc | pricedesc | rating | (default = ProductId)
        /// </summary>
        public static List<Product> SearchProducts(string category, string keyword, string sort)
        {
            List<Product> list = new List<Product>();

            // Build WHERE clause based on filter values
            string where = "WHERE 1=1";
            if (!string.IsNullOrWhiteSpace(category) &&
                !string.Equals(category, "All", StringComparison.OrdinalIgnoreCase))
                where += " AND LOWER(c.Name) = LOWER(@Cat)";
            if (!string.IsNullOrWhiteSpace(keyword))
                where += " AND (p.Name LIKE @Kw OR p.Description LIKE @Kw)";

            string orderBy;
            switch ((sort ?? "").ToLowerInvariant())
            {
                case "priceasc":  orderBy = "p.Price ASC";   break;
                case "pricedesc": orderBy = "p.Price DESC";  break;
                case "rating":    orderBy = "p.Rating DESC"; break;
                default:          orderBy = "p.ProductId ASC"; break;
            }

            // Step 2 - connection object
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3 - command object
            string query = $@"SELECT p.ProductId, p.Name, c.Name AS Category,
                                     p.Description, p.Price, p.Stock,
                                     p.Image, p.Rating, p.IsAvailable
                              FROM Products p
                              LEFT JOIN Categories c ON p.CategoryId = c.CategoryId
                              {where}
                              ORDER BY {orderBy}";
            SqlCommand cmd = new SqlCommand(query, con);
            if (!string.IsNullOrWhiteSpace(category) &&
                !string.Equals(category, "All", StringComparison.OrdinalIgnoreCase))
                cmd.Parameters.AddWithValue("@Cat", category.Trim());
            if (!string.IsNullOrWhiteSpace(keyword))
                cmd.Parameters.AddWithValue("@Kw", "%" + keyword.Trim() + "%");

            // Step 4 - open
            con.Open();

            // Step 5 - execute
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read()) list.Add(MapProduct(reader));
            reader.Close();

            // Step 6 - close
            con.Close();

            // Step 7 - return result
            return list;
        }

        /// <summary>
        /// Inserts a new product row into the Products table.
        /// Returns the auto-generated ProductId.
        /// </summary>
        public static int AddProduct(Product product, int categoryId)
        {
            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"INSERT INTO Products (CategoryId, Name, Description, Price, Stock, Image, Rating, IsAvailable)
                             VALUES (@CatId, @Name, @Desc, @Price, @Stock, @Img, @Rating, @Avail);
                             SELECT SCOPE_IDENTITY();";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@CatId",  categoryId);
            cmd.Parameters.AddWithValue("@Name",   product.Name);
            cmd.Parameters.AddWithValue("@Desc",   string.IsNullOrWhiteSpace(product.Description) ? (object)DBNull.Value : product.Description);
            cmd.Parameters.AddWithValue("@Price",  product.Price);
            cmd.Parameters.AddWithValue("@Stock",  product.Stock);
            cmd.Parameters.AddWithValue("@Img",    string.IsNullOrWhiteSpace(product.Image) ? (object)DBNull.Value : product.Image);
            cmd.Parameters.AddWithValue("@Rating", product.RatingAverage);
            cmd.Parameters.AddWithValue("@Avail",  product.Stock > 0);

            // Step 4
            con.Open();

            // Step 5
            int newId = Convert.ToInt32(cmd.ExecuteScalar());

            // Step 6
            con.Close();

            // Step 7
            return newId;
        }

        /// <summary>
        /// Updates an existing product's editable fields in the database.
        /// </summary>
        public static void UpdateProduct(Product product, int categoryId)
        {
            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"UPDATE Products
                             SET CategoryId = @CatId,
                                 Name       = @Name,
                                 Description= @Desc,
                                 Price      = @Price,
                                 Stock      = @Stock,
                                 Image      = @Img,
                                 IsAvailable= @Avail
                             WHERE ProductId = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@CatId", categoryId);
            cmd.Parameters.AddWithValue("@Name",  product.Name);
            cmd.Parameters.AddWithValue("@Desc",  string.IsNullOrWhiteSpace(product.Description) ? (object)DBNull.Value : product.Description);
            cmd.Parameters.AddWithValue("@Price", product.Price);
            cmd.Parameters.AddWithValue("@Stock", product.Stock);
            cmd.Parameters.AddWithValue("@Img",   string.IsNullOrWhiteSpace(product.Image) ? (object)DBNull.Value : product.Image);
            cmd.Parameters.AddWithValue("@Avail", product.Stock > 0);
            cmd.Parameters.AddWithValue("@Id",    product.Id);

            // Step 4
            con.Open();

            // Step 5
            cmd.ExecuteNonQuery();

            // Step 6
            con.Close();
        }

        /// <summary>
        /// Deletes a product from the database by ProductId.
        /// </summary>
        public static bool DeleteProduct(int id)
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "DELETE FROM Products WHERE ProductId = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Id", id);
            con.Open();
            int rows = cmd.ExecuteNonQuery();
            con.Close();
            return rows > 0;
        }

        // Maps one reader row to a Product object
        private static Product MapProduct(SqlDataReader r)
        {
            return new Product
            {
                Id            = r.GetInt32(0),
                Name          = r.GetString(1),
                Category      = r["Category"] == DBNull.Value ? "" : r.GetString(2),
                Description   = r["Description"] == DBNull.Value ? "" : r.GetString(3),
                Price         = r.GetDecimal(4),
                Stock         = r.GetInt32(5),
                Image         = r["Image"] == DBNull.Value ? "" : r.GetString(6),
                RatingAverage = r["Rating"] == DBNull.Value ? 0 : (double)r.GetDecimal(7),
                IsNew         = false
            };
        }


        // ================================================================
        //  REVIEWS
        // ================================================================

        /// <summary>
        /// Returns all reviews for a product, newest first.
        /// Joins with Users to get the reviewer's name.
        /// </summary>
        public static List<Review> GetReviewsForProduct(int productId)
        {
            List<Review> list = new List<Review>();

            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"SELECT r.ReviewId, u.Name, r.Rating, r.Comment, r.CreatedAt
                             FROM Reviews r
                             JOIN Users u ON r.UserId = u.UserId
                             WHERE r.ProductId = @PId
                             ORDER BY r.CreatedAt DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@PId", productId);

            // Step 4
            con.Open();

            // Step 5
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                list.Add(new Review
                {
                    ProductId = productId,
                    Author    = reader.GetString(1),
                    Rating    = reader.GetInt32(2),
                    Body      = reader["Comment"] == DBNull.Value ? "" : reader.GetString(3),
                    PostedOn  = reader.GetDateTime(4)
                });
            }
            reader.Close();

            // Step 6
            con.Close();

            // Step 7
            return list;
        }

        /// <summary>
        /// Inserts a new review and updates the product's average rating.
        /// </summary>
        public static void AddReview(int userId, int productId, int rating, string comment)
        {
            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3 - insert review row
            string query = @"INSERT INTO Reviews (UserId, ProductId, Rating, Comment, CreatedAt)
                             VALUES (@Uid, @Pid, @Rating, @Comment, @Now);
                             UPDATE Products
                             SET Rating = (SELECT AVG(CAST(Rating AS FLOAT)) FROM Reviews WHERE ProductId = @Pid)
                             WHERE ProductId = @Pid;";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Uid",     userId);
            cmd.Parameters.AddWithValue("@Pid",     productId);
            cmd.Parameters.AddWithValue("@Rating",  rating);
            cmd.Parameters.AddWithValue("@Comment", string.IsNullOrWhiteSpace(comment) ? (object)DBNull.Value : comment);
            cmd.Parameters.AddWithValue("@Now",     DateTime.Now);

            // Step 4
            con.Open();

            // Step 5
            cmd.ExecuteNonQuery();

            // Step 6
            con.Close();

            // Step 7 - review saved successfully
        }


        // ================================================================
        //  OFFERS
        // ================================================================

        /// <summary>
        /// Returns all offers from the Offers table.
        /// </summary>
        public static List<Offer> GetAllOffers()
        {
            List<Offer> list = new List<Offer>();

            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"SELECT OfferId, Code, Title, Description, DiscountType,
                                    DiscountValue, MinAmount, EndDate, IsActive
                             FROM Offers
                             ORDER BY OfferId";
            SqlCommand cmd = new SqlCommand(query, con);

            // Step 4
            con.Open();

            // Step 5
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                string dtype = reader.GetString(4).ToLowerInvariant();
                decimal dval = reader.GetDecimal(5);
                decimal minSpend = reader["MinAmount"] == DBNull.Value ? 0m : reader.GetDecimal(6);
                DateTime expires = reader.GetDateTime(7);
                bool isActive = reader.GetBoolean(8);

                Offer offer;
                if (dtype == "percentage")
                    offer = new PercentageOffer { Percentage = (int)dval };
                else if (dtype == "fixed")
                    offer = new FlatOffer { Amount = dval };
                else
                    offer = new FreeShippingOffer { ShippingFee = dval };

                offer.Id           = reader.GetInt32(0);
                offer.Code         = reader.GetString(1);
                offer.Name         = reader.GetString(2);
                offer.Description  = reader["Description"] == DBNull.Value ? "" : reader.GetString(3);
                offer.MinimumSpend = minSpend;
                offer.ExpiresOn    = expires;
                offer.IsActive     = isActive;
                offer.Kicker       = offer.DiscountLabel;
                list.Add(offer);
            }
            reader.Close();

            // Step 6
            con.Close();

            // Step 7
            return list;
        }

        /// <summary>
        /// Finds an offer by its promo code string (case-insensitive).
        /// </summary>
        public static Offer FindOfferByCode(string code)
        {
            if (string.IsNullOrWhiteSpace(code)) return null;
            foreach (Offer o in GetAllOffers())
                if (string.Equals(o.Code, code.Trim(), StringComparison.OrdinalIgnoreCase))
                    return o;
            return null;
        }

        /// <summary>
        /// Inserts a new offer into the Offers table.
        /// </summary>
        public static void AddOffer(string code, string title, string desc,
                                    string dtype, decimal dval, decimal minAmt, DateTime endDate)
        {
            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"INSERT INTO Offers
                               (Code, Title, Description, DiscountType, DiscountValue, MinAmount, StartDate, EndDate, IsActive)
                             VALUES
                               (@Code, @Title, @Desc, @DType, @DVal, @Min, @Start, @End, 1)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Code",  code);
            cmd.Parameters.AddWithValue("@Title", title);
            cmd.Parameters.AddWithValue("@Desc",  string.IsNullOrWhiteSpace(desc) ? (object)DBNull.Value : desc);
            cmd.Parameters.AddWithValue("@DType", dtype);
            cmd.Parameters.AddWithValue("@DVal",  dval);
            cmd.Parameters.AddWithValue("@Min",   minAmt);
            cmd.Parameters.AddWithValue("@Start", DateTime.Now);
            cmd.Parameters.AddWithValue("@End",   endDate);

            // Step 4
            con.Open();

            // Step 5
            cmd.ExecuteNonQuery();

            // Step 6
            con.Close();

            // Step 7 - offer inserted successfully
        }

        /// <summary>
        /// Deletes an offer by its OfferId. Used by Admin.
        /// </summary>
        public static bool DeleteOffer(int id)
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "DELETE FROM Offers WHERE OfferId = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Id", id);
            con.Open();
            int rows = cmd.ExecuteNonQuery();
            con.Close();
            return rows > 0;
        }


        // ================================================================
        //  ORDERS
        // ================================================================

        /// <summary>
        /// Returns all orders from the Orders table, newest first.
        /// Joins Users and Payments to get name, email, and payment method,
        /// and populates each order's Lines from OrderItems.
        /// </summary>
        public static List<Order> GetAllOrders()
        {
            List<Order> list = new List<Order>();

            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"SELECT o.OrderId, u.Name, u.Email,
                                    o.OrderDate, o.Subtotal, o.Discount,
                                    o.DeliveryCharge, o.TotalAmount, o.Status,
                                    p.PaymentMethod
                             FROM Orders o
                             JOIN Users u ON o.UserId = u.UserId
                             LEFT JOIN Payments p ON p.OrderId = o.OrderId
                             ORDER BY o.OrderDate DESC";
            SqlCommand cmd = new SqlCommand(query, con);

            // Step 4
            con.Open();

            // Step 5
            SqlDataReader reader = cmd.ExecuteReader();
            Dictionary<int, Order> orderMap = new Dictionary<int, Order>();
            while (reader.Read())
            {
                int oid = reader.GetInt32(0);
                Order ord = new Order
                {
                    OrderNumber   = "DV-" + oid,
                    CustomerName  = reader.GetString(1),
                    CustomerEmail = reader.GetString(2),
                    PlacedOn      = reader.GetDateTime(3),
                    SubTotal      = reader.GetDecimal(4),
                    Discount      = reader.GetDecimal(5),
                    Shipping      = reader.GetDecimal(6),
                    Status        = reader["Status"] == DBNull.Value ? "Pending" : reader.GetString(8),
                    PaymentMethod = reader["PaymentMethod"] == DBNull.Value ? "COD" : reader.GetString(9)
                };
                list.Add(ord);
                orderMap[oid] = ord;
            }
            reader.Close();

            // Load OrderItems to populate Lines for each order
            if (list.Count > 0)
            {
                string itemsQuery = @"SELECT oi.OrderId, p.Name, oi.Quantity, oi.Price
                                      FROM OrderItems oi
                                      JOIN Products p ON oi.ProductId = p.ProductId";
                SqlCommand itemsCmd = new SqlCommand(itemsQuery, con);
                SqlDataReader itemReader = itemsCmd.ExecuteReader();
                while (itemReader.Read())
                {
                    int ordId = itemReader.GetInt32(0);
                    if (orderMap.ContainsKey(ordId))
                    {
                        orderMap[ordId].Lines.Add(new OrderLine
                        {
                            ProductName = itemReader.GetString(1),
                            Quantity    = itemReader.GetInt32(2),
                            Rate        = itemReader.GetDecimal(3)
                        });
                    }
                }
                itemReader.Close();
            }

            // Step 6
            con.Close();

            // Step 7
            return list;
        }

        /// <summary>
        /// Returns all orders placed by a specific user (by UserId), newest first.
        /// Populates order Lines from OrderItems.
        /// </summary>
        public static List<Order> GetOrdersForUser(int userId)
        {
            List<Order> list = new List<Order>();

            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"SELECT o.OrderId, o.OrderDate, o.Subtotal, o.Discount,
                                    o.DeliveryCharge, o.TotalAmount, o.Status, p.PaymentMethod
                             FROM Orders o
                             LEFT JOIN Payments p ON p.OrderId = o.OrderId
                             WHERE o.UserId = @Uid
                             ORDER BY o.OrderDate DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Uid", userId);

            // Step 4
            con.Open();

            // Step 5
            SqlDataReader reader = cmd.ExecuteReader();
            Dictionary<int, Order> orderMap = new Dictionary<int, Order>();
            while (reader.Read())
            {
                int oid = reader.GetInt32(0);
                Order ord = new Order
                {
                    OrderNumber   = "DV-" + oid,
                    PlacedOn      = reader.GetDateTime(1),
                    SubTotal      = reader.GetDecimal(2),
                    Discount      = reader.GetDecimal(3),
                    Shipping      = reader.GetDecimal(4),
                    Status        = reader["Status"] == DBNull.Value ? "Pending" : reader.GetString(6),
                    PaymentMethod = reader["PaymentMethod"] == DBNull.Value ? "COD" : reader.GetString(7)
                };
                list.Add(ord);
                orderMap[oid] = ord;
            }
            reader.Close();

            // Load OrderItems to populate Lines
            if (list.Count > 0)
            {
                string itemsQuery = @"SELECT oi.OrderId, p.Name, oi.Quantity, oi.Price
                                      FROM OrderItems oi
                                      JOIN Products p ON oi.ProductId = p.ProductId
                                      JOIN Orders o ON oi.OrderId = o.OrderId
                                      WHERE o.UserId = @Uid";
                SqlCommand itemsCmd = new SqlCommand(itemsQuery, con);
                itemsCmd.Parameters.AddWithValue("@Uid", userId);
                SqlDataReader itemReader = itemsCmd.ExecuteReader();
                while (itemReader.Read())
                {
                    int ordId = itemReader.GetInt32(0);
                    if (orderMap.ContainsKey(ordId))
                    {
                        orderMap[ordId].Lines.Add(new OrderLine
                        {
                            ProductName = itemReader.GetString(1),
                            Quantity    = itemReader.GetInt32(2),
                            Rate        = itemReader.GetDecimal(3)
                        });
                    }
                }
                itemReader.Close();
            }

            // Step 6
            con.Close();

            // Step 7
            return list;
        }

        /// <summary>
        /// Places a complete order. Writes to Orders, OrderItems, and Payments
        /// inside a single DB transaction so either all three succeed or none do.
        /// Returns the generated order number string (e.g. "DV-5").
        /// </summary>
        public static string PlaceOrder(int userId, int addressId, int? offerId,
                                        decimal subtotal, decimal discount, decimal delivery,
                                        string paymentMethod, List<CartItem> items)
        {
            // Step 2 - connection object
            SqlConnection con = new SqlConnection(connectionString);

            // Step 4 - open the connection
            con.Open();

            // Begin a transaction so all inserts succeed or all roll back
            SqlTransaction transaction = con.BeginTransaction();

            int orderId;
            try
            {
                // Step 3a - insert Order header
                string orderQuery = @"INSERT INTO Orders
                                        (UserId, AddressId, OfferId, OrderDate,
                                         Subtotal, Discount, DeliveryCharge, TotalAmount, Status)
                                      VALUES
                                        (@Uid, @Aid, @Oid, @Now, @Sub, @Disc, @Del, @Tot, 'Pending');
                                      SELECT SCOPE_IDENTITY();";
                SqlCommand orderCmd = new SqlCommand(orderQuery, con, transaction);
                orderCmd.Parameters.AddWithValue("@Uid",  userId);
                orderCmd.Parameters.AddWithValue("@Aid",  addressId);
                orderCmd.Parameters.AddWithValue("@Oid",  offerId.HasValue ? (object)offerId.Value : DBNull.Value);
                orderCmd.Parameters.AddWithValue("@Now",  DateTime.Now);
                orderCmd.Parameters.AddWithValue("@Sub",  subtotal);
                orderCmd.Parameters.AddWithValue("@Disc", discount);
                orderCmd.Parameters.AddWithValue("@Del",  delivery);
                orderCmd.Parameters.AddWithValue("@Tot",  subtotal - discount + delivery);

                // Step 5a - execute
                orderId = Convert.ToInt32(orderCmd.ExecuteScalar());

                // Step 3b - insert each cart item as an OrderItem row (Subtotal is computed column)
                foreach (CartItem item in items)
                {
                    string itemQuery = @"INSERT INTO OrderItems (OrderId, ProductId, Quantity, Price)
                                        VALUES (@Oid, @Pid, @Qty, @Price)";
                    SqlCommand itemCmd = new SqlCommand(itemQuery, con, transaction);
                    itemCmd.Parameters.AddWithValue("@Oid",   orderId);
                    itemCmd.Parameters.AddWithValue("@Pid",   item.ProductId);
                    itemCmd.Parameters.AddWithValue("@Qty",   item.Quantity);
                    itemCmd.Parameters.AddWithValue("@Price", item.Rate);
                    itemCmd.ExecuteNonQuery();

                    // Reduce stock count for each product ordered
                    string stockQuery = "UPDATE Products SET Stock = Stock - @Qty WHERE ProductId = @Pid AND Stock >= @Qty";
                    SqlCommand stockCmd = new SqlCommand(stockQuery, con, transaction);
                    stockCmd.Parameters.AddWithValue("@Qty", item.Quantity);
                    stockCmd.Parameters.AddWithValue("@Pid", item.ProductId);
                    stockCmd.ExecuteNonQuery();
                }

                // Step 3c - record the payment
                string payQuery = @"INSERT INTO Payments (OrderId, PaymentMethod, Amount, PaymentDate, Status)
                                    VALUES (@Oid, @Method, @Amt, @Now, 'Completed')";
                SqlCommand payCmd = new SqlCommand(payQuery, con, transaction);
                payCmd.Parameters.AddWithValue("@Oid",    orderId);
                payCmd.Parameters.AddWithValue("@Method", paymentMethod);
                payCmd.Parameters.AddWithValue("@Amt",    subtotal - discount + delivery);
                payCmd.Parameters.AddWithValue("@Now",    DateTime.Now);
                payCmd.ExecuteNonQuery();

                // Commit all changes
                transaction.Commit();
            }
            catch
            {
                // If anything fails, roll back so the DB stays clean
                transaction.Rollback();
                con.Close();
                throw;
            }

            // Step 6 - close the connection
            con.Close();

            // Step 7 - return the new order number
            return "DV-" + orderId;
        }

        /// <summary>
        /// Updates an order's status (e.g. Pending → In Transit → Delivered).
        /// </summary>
        public static void SetOrderStatus(int orderId, string status)
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "UPDATE Orders SET Status = @S WHERE OrderId = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@S",  status);
            cmd.Parameters.AddWithValue("@Id", orderId);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }


        // ================================================================
        //  ADDRESSES
        // ================================================================

        /// <summary>
        /// Returns all saved addresses for a user, default address first.
        /// </summary>
        public static List<Address> GetAddressesForUser(int userId)
        {
            List<Address> list = new List<Address>();

            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 3
            string query = @"SELECT AddressId, FullName, Phone, AddressLine,
                                    City, State, Pincode, IsDefault
                             FROM Addresses
                             WHERE UserId = @Uid
                             ORDER BY IsDefault DESC, AddressId";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Uid", userId);

            // Step 4
            con.Open();

            // Step 5
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                list.Add(new Address
                {
                    Id        = reader.GetInt32(0),
                    FullName  = reader.GetString(1),
                    Phone     = reader["Phone"] == DBNull.Value ? "" : reader.GetString(2),
                    Line1     = reader["AddressLine"] == DBNull.Value ? "" : reader.GetString(3),
                    City      = reader.GetString(4),
                    State     = reader.GetString(5),
                    Pincode   = reader.GetString(6),
                    IsDefault = reader.GetBoolean(7)
                });
            }
            reader.Close();

            // Step 6
            con.Close();

            // Step 7
            return list;
        }

        /// <summary>
        /// Inserts a new address. If IsDefault = true, clears other defaults first.
        /// Returns the auto-generated AddressId.
        /// </summary>
        public static int AddAddress(int userId, Address addr)
        {
            // Step 2
            SqlConnection con = new SqlConnection(connectionString);

            // Step 4 - open early so we can run two commands on same connection
            con.Open();

            // If this is the default address, clear other defaults first
            if (addr.IsDefault)
            {
                string clearQuery = "UPDATE Addresses SET IsDefault = 0 WHERE UserId = @Uid";
                SqlCommand clearCmd = new SqlCommand(clearQuery, con);
                clearCmd.Parameters.AddWithValue("@Uid", userId);
                clearCmd.ExecuteNonQuery();
            }

            // Step 3 - insert new address
            string query = @"INSERT INTO Addresses
                               (UserId, FullName, Phone, AddressLine, City, State, Pincode, IsDefault)
                             VALUES
                               (@Uid, @Name, @Phone, @Line, @City, @State, @Pin, @Def);
                             SELECT SCOPE_IDENTITY();";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Uid",   userId);
            cmd.Parameters.AddWithValue("@Name",  addr.FullName);
            cmd.Parameters.AddWithValue("@Phone", string.IsNullOrWhiteSpace(addr.Phone) ? (object)DBNull.Value : addr.Phone);
            cmd.Parameters.AddWithValue("@Line",  addr.Line1);
            cmd.Parameters.AddWithValue("@City",  addr.City);
            cmd.Parameters.AddWithValue("@State", addr.State);
            cmd.Parameters.AddWithValue("@Pin",   addr.Pincode);
            cmd.Parameters.AddWithValue("@Def",   addr.IsDefault);

            // Step 5 - execute
            int newId = Convert.ToInt32(cmd.ExecuteScalar());

            // Step 6 - close
            con.Close();

            // Step 7 - return new ID
            return newId;
        }


        // ================================================================
        //  DASHBOARD (Admin summary statistics)
        // ================================================================

        /// <summary>
        /// Total revenue = SUM of TotalAmount from all Orders.
        /// </summary>
        public static decimal GetTotalSales()
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "SELECT ISNULL(SUM(TotalAmount), 0) FROM Orders";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            decimal total = (decimal)cmd.ExecuteScalar();
            con.Close();
            return total;
        }

        /// <summary>
        /// Count of orders with status = 'Pending'.
        /// </summary>
        public static int GetPendingOrderCount()
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "SELECT COUNT(*) FROM Orders WHERE Status = 'Pending'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        /// <summary>
        /// Count of orders currently 'In Transit' or 'Out for Delivery'.
        /// </summary>
        public static int GetActiveOrderCount()
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "SELECT COUNT(*) FROM Orders WHERE Status IN ('In Transit', 'Out for Delivery')";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        /// <summary>
        /// Total number of registered customers in the Users table.
        /// </summary>
        public static int GetUserCount()
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "SELECT COUNT(*) FROM Users";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        /// <summary>
        /// Returns a SqlConnection object (used by AppData helpers that
        /// need to run their own inline queries).
        /// </summary>
        public static SqlConnection GetConnection()
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            return con;
        }
    }
}
