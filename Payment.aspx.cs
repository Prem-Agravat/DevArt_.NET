using System;
using System.Web.UI;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Checkout step 3 - payment and order placement (Figma frame 15).</summary>
    public partial class Payment : Page
    {
        private Address ShipTo
        {
            get
            {
                int id = Session[CartService.ShipToKey] is int ? (int)Session[CartService.ShipToKey] : 0;
                return AppData.FindAddress(id);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            UserAccount user = Session["CurrentUser"] as UserAccount;

            if (user == null)
            {
                Response.Redirect("Login.aspx?returnUrl=Payment.aspx", false);
                return;
            }

            if (CartService.Items.Count == 0)
            {
                Response.Redirect("Cart.aspx", false);
                return;
            }

            if (ShipTo == null)
            {
                Response.Redirect("Shipping.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                BindSummary();
            }
        }

        public string FormatImageUrl(object imgObj)
        {
            string img = Convert.ToString(imgObj);
            if (string.IsNullOrWhiteSpace(img)) return "Images/category_cushion.jpg";
            if (img.StartsWith("Images/", StringComparison.OrdinalIgnoreCase) || img.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || img.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            {
                return img;
            }
            return "Images/" + img;
        }

        private void BindSummary()
        {
            rptLines.DataSource = CartService.Items;
            rptLines.DataBind();

            litSubTotal.Text = CartService.SubTotal.ToString("N0");

            decimal discount = CartService.Discount;
            pnlDiscount.Visible = discount > 0;
            litDiscount.Text = discount.ToString("N0");

            decimal shipping = CartService.Shipping;
            litShipping.Text = shipping == 0m ? "Calculated at next step" : "₹" + shipping.ToString("N0");

            decimal total = CartService.Total;
            litTotal.Text = total.ToString("N0");
            btnPay.Text = "Pay ₹" + total.ToString("N0");
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            Page.Validate("Pay");
            if (!Page.IsValid) return;

            UserAccount user = (UserAccount)Session["CurrentUser"];
            Address shipTo = ShipTo;

            // Resolve address ID from session (stored as int)
            int addressId = Session[CartService.ShipToKey] is int ? (int)Session[CartService.ShipToKey] : 0;
            if (addressId <= 0 && user != null)
            {
                var addrs = AppData.AddressesForUser(user.Id);
                addressId = addrs.Count > 0 ? addrs[0].Id : 1;
            }

            // Look up the offer ID from the promo code (null if no promo applied)
            int? offerId = null;
            Offer appliedOffer = AppData.FindOffer(CartService.PromoCode);
            if (appliedOffer != null) offerId = appliedOffer.Id;

            // Place the order in the database (Orders + OrderItems + Payments tables)
            string orderNumber = AppData.PlaceOrder(
                userId       : user.Id,
                addressId    : addressId,
                offerId      : offerId,
                subtotal     : CartService.SubTotal,
                discount     : CartService.Discount,
                delivery     : CartService.Shipping,
                paymentMethod: "COD (Cash On Delivery)",
                items        : CartService.Items
            );

            // Build a lightweight Order object for the confirmation modal display
            Order order = new Order
            {
                OrderNumber   = orderNumber,
                CustomerEmail = user.Email,
                CustomerName  = user.FullName,
                PlacedOn      = DateTime.Today,
                Status        = "Pending",
                PaymentMethod = "COD (Cash On Delivery)",
                SubTotal      = CartService.SubTotal,
                Discount      = CartService.Discount,
                Shipping      = CartService.Shipping,
                ShipTo        = shipTo
            };
            foreach (CartItem line in CartService.Items)
            {
                order.Lines.Add(new OrderLine
                {
                    ProductName = line.Name,
                    Variant     = line.Variant,
                    Quantity    = line.Quantity,
                    Rate        = line.Rate
                });
            }

            // Populate Modal Data
            litModalOrderNum.Text = order.OrderNumber;

            DateTime delStart = DateTime.Today.AddDays(3);
            DateTime delEnd = DateTime.Today.AddDays(5);
            litModalDeliveryDate.Text = delStart.ToString("MMM d") + " - " + delEnd.ToString("MMM d");

            rptModalItems.DataSource = order.Lines;
            rptModalItems.DataBind();

            litModalTotal.Text = order.Total.ToString("N0");

            if (shipTo != null)
            {
                litModalAddressName.Text = Server.HtmlEncode(shipTo.FullName);
                litModalAddressLine.Text = Server.HtmlEncode(shipTo.OneLine);
            }

            // Clear cart and store order key
            CartService.Clear();
            Session[CartService.LastOrderKey] = order.OrderNumber;

            // Display popup modal right on Payment page
            pnlSuccessModal.Visible = true;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx", false);
        }
    }
}
