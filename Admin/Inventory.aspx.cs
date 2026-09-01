using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>Product list with delete (Figma frames 28 and 36).</summary>
    public partial class Inventory : Page
    {
        private string SelectedCategory
        {
            get { return Request.QueryString["category"] ?? "All"; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string flash = Session["AdminFlash"] as string;
                if (!string.IsNullOrEmpty(flash))
                {
                    Session.Remove("AdminFlash");
                    ShowStatus(flash, true);
                }

                BindChips();
                BindProducts();
            }
        }

        private void BindChips()
        {
            List<object> chips = new List<object>
            {
                new { Text = "All", Value = "All", Css = SelectedCategory == "All" ? "active" : string.Empty }
            };

            chips.AddRange(AppData.Categories.Select(c => (object)new
            {
                Text = c,
                Value = c,
                Css = string.Equals(c, SelectedCategory, StringComparison.OrdinalIgnoreCase) ? "active" : string.Empty
            }));

            rptChips.DataSource = chips;
            rptChips.DataBind();
        }

        private void BindProducts()
        {
            List<Product> products = AppData.SearchProducts(SelectedCategory, null, "newest");
            rptProducts.DataSource = products;
            rptProducts.DataBind();
            pnlEmpty.Visible = products.Count == 0;
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "DeleteProduct") return;

            int id;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id)) return;

            Product product = AppData.FindProduct(id);
            if (product != null && AppData.DeleteProduct(id))
            {
                ShowStatus("Product deleted successfully: " + Server.HtmlEncode(product.Name) + ".", true);
            }
            else
            {
                ShowStatus("That product no longer exists.", false);
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
