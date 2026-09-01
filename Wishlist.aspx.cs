using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Saved pieces (Figma frame 22).</summary>
    public partial class Wishlist : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) Bind();
        }

        private void Bind()
        {
            List<Product> products = CartService.WishlistProducts;

            rptWishlist.DataSource = products;
            rptWishlist.DataBind();

            litCount.Text = products.Count.ToString();
            pnlEmpty.Visible = products.Count == 0;
        }

        protected void rptWishlist_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out productId)) return;

            Product product = AppData.FindProduct(productId);

            if (e.CommandName == "AddToCart" && product != null)
            {
                CartService.Add(product, 1);
                CartService.RemoveFromWishlist(productId);
                ShowStatus(Server.HtmlEncode(product.Name) + " moved to your cart.", true);
            }
            else if (e.CommandName == "Remove")
            {
                CartService.RemoveFromWishlist(productId);
                ShowStatus("Removed from your wishlist.", true);
            }

            Bind();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
        }

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }
    }
}
