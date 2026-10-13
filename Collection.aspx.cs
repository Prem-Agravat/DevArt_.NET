using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>
    /// Code-behind for Collection.aspx — the main product catalogue page.
    /// Supports category filtering (via query string), keyword search, and sort order.
    /// Users can add products to the cart or wishlist directly from this page.
    /// </summary>
    public partial class Collection : Page
    {
        /// <summary>
        /// Reads the "category" query string parameter set by category links.
        /// Defaults to "All" if no filter is selected.
        /// Example URL: Collection.aspx?category=Torans
        /// </summary>
        private string SelectedCategory
        {
            get { return Request.QueryString["category"] ?? "All"; }
        }

        /// <summary>
        /// Runs when the page first loads (or after a sort change redirect).
        /// Sets the sort dropdown to match the URL, then loads the filters and products.
        /// IsPostBack is false on the first visit but true when an ASP.NET button causes a form submit.
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Restore sort selection from URL so the page is bookmarkable
                string sort = Request.QueryString["sort"];
                if (!string.IsNullOrEmpty(sort) && ddlSort.Items.FindByValue(sort) != null)
                {
                    ddlSort.SelectedValue = sort;
                }

                // Load the left-hand category filter links and the product grid
                BindFilters();
                BindProducts();
            }
        }

        /// <summary>
        /// Builds the category filter links in the left sidebar.
        /// The currently selected category gets the CSS class "active" so it appears highlighted.
        /// </summary>
        private void BindFilters()
        {
            // Always include "All pieces" as the first option
            List<object> filters = new List<object>
            {
                new { Text = "All pieces", Value = "All", Css = SelectedCategory == "All" ? "active" : string.Empty }
            };

            // Add one link per distinct category found in the product data
            filters.AddRange(AppData.Categories.Select(c => (object)new
            {
                Text  = c,
                Value = c,
                Css   = string.Equals(c, SelectedCategory, StringComparison.OrdinalIgnoreCase) ? "active" : string.Empty
            }));

            rptFilters.DataSource = filters;
            rptFilters.DataBind();
        }

        /// <summary>
        /// Loads the matching products into the repeater grid.
        /// Uses the current category, any keyword from the search box, and the selected sort.
        /// Also updates the "Showing X artisanal pieces" count and shows an empty-state panel.
        /// </summary>
        private void BindProducts()
        {
            // Search with the current filters — AppData.SearchProducts handles all the logic
            List<Product> products = AppData.SearchProducts(
                SelectedCategory,
                Request.QueryString["q"],   // keyword from the header search box
                ddlSort.SelectedValue       // chosen sort order
            );

            rptProducts.DataSource = products;
            rptProducts.DataBind();

            // Show the count and toggle the empty-state panel
            litCount.Text     = products.Count.ToString();
            pnlEmpty.Visible  = products.Count == 0;
        }

        /// <summary>
        /// Fires when the user picks a different sort option from the drop-down.
        /// Redirects to a new URL that includes both the current category and the new sort,
        /// so the sorted listing is shareable and bookmarkable.
        /// </summary>
        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect(
                "Collection.aspx?category=" + Server.UrlEncode(SelectedCategory) +
                "&sort=" + ddlSort.SelectedValue,
                false); // false = don't raise a ThreadAbortException
        }

        /// <summary>
        /// Handles button clicks inside each product card (Add to Cart / Wishlist).
        /// The CommandName tells us which action to take.
        /// The CommandArgument carries the product ID.
        /// </summary>
        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Parse the product ID from the button's CommandArgument
            int productId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out productId)) return;

            // Look up the product in the catalogue
            Product product = AppData.FindProduct(productId);
            if (product == null) return;

            if (e.CommandName == "AddToCart")
            {
                // Add one unit to the session cart and show a green success message
                CartService.Add(product, 1);
                ShowStatus(Server.HtmlEncode(product.Name) + " added to your cart. " +
                           "<a href=\"Cart.aspx\" style=\"text-decoration:underline;\">View cart</a>", true);
            }
            else if (e.CommandName == "AddToWishlist")
            {
                // AddToWishlist returns false if the item is already saved
                bool added = CartService.AddToWishlist(productId);
                ShowStatus(added
                    ? Server.HtmlEncode(product.Name) + " saved to your wishlist."
                    : Server.HtmlEncode(product.Name) + " is already on your wishlist.",
                    added);
            }

            // Re-bind the product grid so counts and stock badges stay current
            BindProducts();
        }

        /// <summary>
        /// Shows a colored status bar below the page title.
        /// success=true shows green; success=false shows red.
        /// </summary>
        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible  = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text     = text;
        }
    }
}
