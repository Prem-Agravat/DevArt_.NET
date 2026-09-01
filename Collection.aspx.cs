using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Catalogue listing with category filter and sort (Figma frame 11).</summary>
    public partial class Collection : Page
    {
        /// <summary>Category filter, carried in the query string so it can be linked to.</summary>
        private string SelectedCategory
        {
            get { return Request.QueryString["category"] ?? "All"; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sort = Request.QueryString["sort"];
                if (!string.IsNullOrEmpty(sort) && ddlSort.Items.FindByValue(sort) != null)
                {
                    ddlSort.SelectedValue = sort;
                }

                BindFilters();
                BindProducts();
            }
        }

        private void BindFilters()
        {
            List<object> filters = new List<object>
            {
                new { Text = "All pieces", Value = "All", Css = SelectedCategory == "All" ? "active" : string.Empty }
            };

            filters.AddRange(AppData.Categories.Select(c => (object)new
            {
                Text = c,
                Value = c,
                Css = string.Equals(c, SelectedCategory, StringComparison.OrdinalIgnoreCase) ? "active" : string.Empty
            }));

            rptFilters.DataSource = filters;
            rptFilters.DataBind();
        }

        private void BindProducts()
        {
            List<Product> products = AppData.SearchProducts(SelectedCategory, Request.QueryString["q"], ddlSort.SelectedValue);

            rptProducts.DataSource = products;
            rptProducts.DataBind();

            litCount.Text = products.Count.ToString();
            pnlEmpty.Visible = products.Count == 0;
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Keep the filter and the sort in the URL so the listing is shareable.
            Response.Redirect("Collection.aspx?category=" + Server.UrlEncode(SelectedCategory) +
                              "&sort=" + ddlSort.SelectedValue, false);
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out productId)) return;

            Product product = AppData.FindProduct(productId);
            if (product == null) return;

            if (e.CommandName == "AddToCart")
            {
                CartService.Add(product, 1);
                ShowStatus(Server.HtmlEncode(product.Name) + " added to your cart. " +
                           "<a href=\"Cart.aspx\" style=\"text-decoration:underline;\">View cart</a>", true);
            }
            else if (e.CommandName == "AddToWishlist")
            {
                bool added = CartService.AddToWishlist(productId);
                ShowStatus(added
                        ? Server.HtmlEncode(product.Name) + " saved to your wishlist."
                        : Server.HtmlEncode(product.Name) + " is already on your wishlist.",
                    added);
            }

            BindProducts();
        }

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }
    }
}
