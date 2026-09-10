using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Shopping cart (Figma frame 12).</summary>
    public partial class Cart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtPromo.Text = CartService.PromoCode;
                BindCart();
            }
        }

        // ------------------------------------------------- server-side validators

        /// <summary>
        /// The code must exist, still be active, and clear its minimum spend for
        /// this particular cart - none of which the browser can know.
        /// </summary>
        protected void cvPromo_ServerValidate(object source, ServerValidateEventArgs args)
        {
            Offer offer = AppData.FindOffer(args.Value);
            args.IsValid = offer != null && offer.IsUsable(CartService.SubTotal);
        }

        // --------------------------------------------------------------- actions

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out productId)) return;

            if (e.CommandName == "Remove")
            {
                CartService.Remove(productId);
                ShowStatus("Item removed from your cart.", true);
            }
            else if (e.CommandName == "Update")
            {
                Page.Validate("Cart");
                if (!Page.IsValid) return;

                TextBox box = e.Item.FindControl("txtQty") as TextBox;
                int quantity;
                if (box != null && int.TryParse(box.Text.Trim(), out quantity))
                {
                    CartService.SetQuantity(productId, quantity);
                    ShowStatus("Quantity updated.", true);
                }
            }

            BindCart();
        }

        protected void btnEmpty_Click(object sender, EventArgs e)
        {
            CartService.Clear();
            txtPromo.Text = string.Empty;
            ShowStatus("Your cart has been emptied.", true);
            BindCart();
        }

        protected void btnApplyPromo_Click(object sender, EventArgs e)
        {
            Page.Validate("Promo");
            if (!Page.IsValid) return;

            string code = txtPromo.Text.Trim().ToUpperInvariant();
            CartService.PromoCode = code;

            Offer offer = AppData.FindOffer(code);
            ShowStatus("Promo code " + code + " applied - " + offer.DiscountLabel + " on this order.", true);
            BindCart();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (CartService.Items.Count == 0)
            {
                ShowStatus("Add something to your cart before checking out.", false);
                return;
            }

            // Checkout needs an identified customer.
            if (Session["CurrentUser"] == null)
            {
                Response.Redirect("Login.aspx?returnUrl=Shipping.aspx", false);
                return;
            }

            Response.Redirect("Shipping.aspx", false);
        }

        // ----------------------------------------------------------------- render

        private void BindCart()
        {
            List<CartItem> items = CartService.Items;

            pnlCart.Visible = items.Count > 0;
            pnlEmpty.Visible = items.Count == 0;

            rptCart.DataSource = items;
            rptCart.DataBind();

            if (items.Count == 0) return;

            litItemCount.Text = CartService.UnitCount.ToString();
            litSubTotal.Text = CartService.SubTotal.ToString("N0");

            decimal discount = CartService.Discount;
            pnlDiscount.Visible = discount > 0;
            litPromoCode.Text = Server.HtmlEncode(CartService.PromoCode ?? string.Empty);
            litDiscount.Text = discount.ToString("N0");

            decimal shipping = CartService.Shipping;
            litShipping.Text = shipping == 0m ? "Free" : "₹" + shipping.ToString("N0");

            litTotal.Text = CartService.Total.ToString("N0");
            litEta.Text = DateTime.Today.AddDays(6).ToString("dddd, MMM d");
        }

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }
    }
}
