using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>Add / edit / delete a product (Figma frames 29, 37, 36).</summary>
    public partial class ProductEdit : Page
    {
        /// <summary>0 when adding, otherwise the product being edited.</summary>
        private int ProductId
        {
            get
            {
                int id;
                int.TryParse(Request.QueryString["id"], out id);
                return id;
            }
        }

        private bool IsEdit
        {
            get { return ProductId > 0; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            litHeading.Text = IsEdit ? "Edit Product" : "Add New Product";
            btnSave.Text = IsEdit ? "Update Changes" : "Save Product";
            btnDelete.Visible = IsEdit;

            if (IsPostBack) return;

            if (!IsEdit) return;

            Product product = AppData.FindProduct(ProductId);
            if (product == null)
            {
                Response.Redirect("Inventory.aspx", false);
                return;
            }

            txtName.Text = product.Name;
            txtMaterial.Text = product.Material;
            txtDescription.Text = product.Description;
            txtPrice.Text = product.Price.ToString("0.##", CultureInfo.InvariantCulture);
            txtStock.Text = product.Stock.ToString();
            chkNew.Checked = product.IsNew;

            if (ddlCategory.Items.FindByValue(product.Category) != null)
                ddlCategory.SelectedValue = product.Category;

            if (ddlImage.Items.FindByValue(product.Image) != null)
                ddlImage.SelectedValue = product.Image;
        }

        // ------------------------------------------------- server-side validators

        /// <summary>Product names must be unique across the catalogue.</summary>
        protected void cvName_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string name = (args.Value ?? string.Empty).Trim();
            args.IsValid = !AppData.Products.Any(p =>
                p.Id != ProductId &&
                string.Equals(p.Name, name, StringComparison.OrdinalIgnoreCase));
        }

        protected void cvDescription_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string text = (args.Value ?? string.Empty).Trim();
            int words = text.Length == 0
                ? 0
                : text.Split(new[] { ' ', '\t', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries).Length;

            args.IsValid = words >= 10 && text.Length <= 600;
        }

        // --------------------------------------------------------------- actions

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("Product");
            if (!Page.IsValid) return;

            Product product = new Product
            {
                Id = ProductId,
                Name = txtName.Text.Trim(),
                Category = ddlCategory.SelectedValue,
                Material = txtMaterial.Text.Trim(),
                Description = txtDescription.Text.Trim(),
                Image = ddlImage.SelectedValue,
                Price = decimal.Parse(txtPrice.Text.Trim(), NumberStyles.Currency, CultureInfo.InvariantCulture),
                Stock = int.Parse(txtStock.Text.Trim()),
                IsNew = chkNew.Checked
            };

            if (IsEdit)
            {
                AppData.UpdateProduct(product);
                Session["AdminFlash"] = "Product updated successfully: " + Server.HtmlEncode(product.Name) + ".";
            }
            else
            {
                AppData.AddProduct(product);
                Session["AdminFlash"] = "Product saved successfully: " + Server.HtmlEncode(product.Name) + ".";
            }

            Response.Redirect("Inventory.aspx", false);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Product product = AppData.FindProduct(ProductId);
            if (product != null && AppData.DeleteProduct(ProductId))
            {
                Session["AdminFlash"] = "Product deleted successfully: " + Server.HtmlEncode(product.Name) + ".";
            }

            Response.Redirect("Inventory.aspx", false);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inventory.aspx", false);
        }
    }
}
