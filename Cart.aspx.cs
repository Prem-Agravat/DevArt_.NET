using System;
using System.Collections.Generic;
using System.Linq;
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

        // ------------------------------------------------- server-side validators

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
            else if (e.CommandName == "Decrease")
            {
                CartItem line = CartService.Items.FirstOrDefault(i => i.ProductId == productId);
                if (line != null)
                {
                    CartService.SetQuantity(productId, line.Quantity - 1);
                    ShowStatus("Quantity updated.", true);
                }
            }
            else if (e.CommandName == "Increase")
            {
                CartItem line = CartService.Items.FirstOrDefault(i => i.ProductId == productId);
                if (line != null)
                {
                    CartService.SetQuantity(productId, line.Quantity + 1);
                    ShowStatus("Quantity updated.", true);
                }
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

            if (pnlCart != null) pnlCart.Visible = items.Count > 0;
            if (pnlEmpty != null) pnlEmpty.Visible = items.Count == 0;

            if (rptCart != null)
            {
                rptCart.DataSource = items;
                rptCart.DataBind();
            }

            if (items.Count == 0) return;

            if (litItemCount != null) litItemCount.Text = CartService.UnitCount.ToString();
            if (litSubTotal != null) litSubTotal.Text = CartService.SubTotal.ToString("N0");

            decimal discount = CartService.Discount;
            if (pnlDiscount != null) pnlDiscount.Visible = discount > 0;
            if (litPromoCode != null) litPromoCode.Text = Server.HtmlEncode(CartService.PromoCode ?? string.Empty);
            if (litDiscount != null) litDiscount.Text = discount.ToString("N0");

            decimal shipping = CartService.Shipping;
            if (litShipping != null) litShipping.Text = shipping == 0m ? "Calculated at next step" : "₹" + shipping.ToString("N0");

            if (litTotal != null) litTotal.Text = CartService.Total.ToString("N0");
            if (litEta != null) litEta.Text = DateTime.Today.AddDays(6).ToString("dddd, MMM d");
        }

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }
    }
}
