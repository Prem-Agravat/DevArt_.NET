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

            BindSummary();
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
            litShipping.Text = shipping == 0m ? "Free" : "₹" + shipping.ToString("N0");

            decimal total = CartService.Total;
            litTotal.Text = total.ToString("N0");
            btnPay.Text = "Pay ₹" + total.ToString("N0");

            Address a = ShipTo;
            litAddress.Text = "<strong>" + Server.HtmlEncode(a.FullName) + "</strong><br />" +
                              Server.HtmlEncode(a.OneLine) + "<br />" +
                              Server.HtmlEncode(a.Phone);
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            Page.Validate("Pay");
            if (!Page.IsValid) return;

            UserAccount user = (UserAccount)Session["CurrentUser"];

            Order order = new Order
            {
                OrderNumber = AppData.NextOrderNumber(),
                CustomerEmail = user.Email,
                CustomerName = user.FullName,
                PlacedOn = DateTime.Today,
                Status = "Pending",
                PaymentMethod = "COD (Cash On Delivery)",
                SubTotal = CartService.SubTotal,
                Discount = CartService.Discount,
                Shipping = CartService.Shipping,
                ShipTo = ShipTo
            };

            foreach (CartItem line in CartService.Items)
            {
                order.Lines.Add(new OrderLine
                {
                    ProductName = line.Name,
                    Variant = line.Variant,
                    Quantity = line.Quantity,
                    Rate = line.Rate
                });
            }

            AppData.AddOrder(order);

            // The cart has become an order - clear it and remember the number for the receipt.
            CartService.Clear();
            Session[CartService.LastOrderKey] = order.OrderNumber;

            Response.Redirect("OrderSuccess.aspx", false);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx", false);
        }
    }
}
