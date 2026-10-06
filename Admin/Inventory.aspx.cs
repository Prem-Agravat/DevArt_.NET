using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>Product list with popup modal for Add/Edit product (matching Figma frames).</summary>
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

                // Check if redirected to edit or add via QueryString
                if (!string.IsNullOrEmpty(Request.QueryString["editId"]))
                {
                    int editId;
                    if (int.TryParse(Request.QueryString["editId"], out editId))
                    {
                        OpenEditModal(editId);
                    }
                }
                else if (string.Equals(Request.QueryString["action"], "add", StringComparison.OrdinalIgnoreCase))
                {
                    OpenAddModal();
                }
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

        public string FormatImageUrl(object imgObj)
        {
            string img = Convert.ToString(imgObj);
            if (string.IsNullOrEmpty(img)) return "../Images/category_cushion.jpg";
            if (img.StartsWith("Images/", StringComparison.OrdinalIgnoreCase) ||
                img.StartsWith("http://", StringComparison.OrdinalIgnoreCase) ||
                img.StartsWith("https://", StringComparison.OrdinalIgnoreCase)) return "../" + img;
            if (img.StartsWith("../", StringComparison.OrdinalIgnoreCase)) return img;
            return "../Images/" + img;
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id)) return;

            if (e.CommandName == "DeleteProduct")
            {
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
            else if (e.CommandName == "EditProduct")
            {
                OpenEditModal(id);
            }
        }

        protected void btnAddProductFab_Click(object sender, EventArgs e)
        {
            OpenAddModal();
        }

        private void OpenAddModal()
        {
            hfProductId.Value = "0";
            lblModalTitle.InnerText = "Add New Product";
            btnSaveModalText.InnerText = "Save Product";
            btnDeleteModal.Visible = false;

            txtName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtPrice.Text = "0.00";
            txtStock.Text = "1";
            chkNew.Checked = false;
            ddlCategory.SelectedIndex = 0;
            hfSelectedImage.Value = "category_torans.jpg";

            pnlSuccessModal.Style["display"] = "none";
            pnlConfirmDeleteModal.Style["display"] = "none";
            pnlSuccessDeleteModal.Style["display"] = "none";
            pnlProductModal.Style["display"] = "flex";
        }

        private void OpenEditModal(int id)
        {
            Product product = AppData.FindProduct(id);
            if (product == null)
            {
                ShowStatus("Product not found.", false);
                return;
            }

            hfProductId.Value = product.Id.ToString();
            lblModalTitle.InnerText = "Edit Product";
            btnSaveModalText.InnerText = "Save Product";
            btnDeleteModal.Visible = true;

            txtName.Text = product.Name;
            txtDescription.Text = product.Description;
            txtPrice.Text = product.Price.ToString("0.##", CultureInfo.InvariantCulture);
            txtStock.Text = product.Stock.ToString();
            chkNew.Checked = product.IsNew;

            if (ddlCategory.Items.FindByValue(product.Category) != null)
                ddlCategory.SelectedValue = product.Category;
            else
                ddlCategory.SelectedIndex = 0;

            hfSelectedImage.Value = product.Image ?? "category_torans.jpg";

            pnlSuccessModal.Style["display"] = "none";
            pnlConfirmDeleteModal.Style["display"] = "none";
            pnlSuccessDeleteModal.Style["display"] = "none";
            pnlProductModal.Style["display"] = "flex";
        }

        protected void btnSaveModal_Click(object sender, EventArgs e)
        {
            Page.Validate("ProductModal");
            if (!Page.IsValid)
            {
                pnlSuccessModal.Style["display"] = "none";
                pnlConfirmDeleteModal.Style["display"] = "none";
                pnlSuccessDeleteModal.Style["display"] = "none";
                pnlProductModal.Style["display"] = "flex";
                return;
            }

            int productId;
            int.TryParse(hfProductId.Value, out productId);
            bool isEdit = productId > 0;

            string selectedImg = !string.IsNullOrEmpty(hfSelectedImage.Value) ? hfSelectedImage.Value : "category_torans.jpg";

            Product existingProduct = isEdit ? AppData.FindProduct(productId) : null;
            string materialVal = existingProduct != null && !string.IsNullOrEmpty(existingProduct.Material)
                ? existingProduct.Material
                : txtName.Text.Trim();

            Product product = new Product
            {
                Id = productId,
                Name = txtName.Text.Trim(),
                Category = ddlCategory.SelectedValue,
                Material = materialVal,
                Description = txtDescription.Text.Trim(),
                Image = selectedImg,
                Price = decimal.Parse(txtPrice.Text.Trim(), NumberStyles.Currency, CultureInfo.InvariantCulture),
                Stock = int.Parse(txtStock.Text.Trim()),
                IsNew = chkNew.Checked
            };

            if (isEdit)
            {
                AppData.UpdateProduct(product);
                ShowStatus("Product updated successfully: " + Server.HtmlEncode(product.Name) + ".", true);
                lblSuccessTitle.InnerText = "Product Updated!";
                lblSuccessSub.InnerText = "successfully Updated.";
            }
            else
            {
                AppData.AddProduct(product);
                ShowStatus("Product saved successfully: " + Server.HtmlEncode(product.Name) + ".", true);
                lblSuccessTitle.InnerText = "Product Saved!";
                lblSuccessSub.InnerText = "successfully Saved.";
            }

            pnlProductModal.Style["display"] = "none";
            pnlConfirmDeleteModal.Style["display"] = "none";
            pnlSuccessDeleteModal.Style["display"] = "none";
            pnlSuccessModal.Style["display"] = "flex";
            BindProducts();
        }

        protected void btnBackToInventory_Click(object sender, EventArgs e)
        {
            pnlSuccessModal.Style["display"] = "none";
            pnlConfirmDeleteModal.Style["display"] = "none";
            pnlSuccessDeleteModal.Style["display"] = "none";
            pnlProductModal.Style["display"] = "none";
            BindProducts();
        }

        protected void btnCancelModal_Click(object sender, EventArgs e)
        {
            pnlProductModal.Style["display"] = "none";
            pnlSuccessModal.Style["display"] = "none";
            pnlConfirmDeleteModal.Style["display"] = "none";
            pnlSuccessDeleteModal.Style["display"] = "none";
        }

        protected void btnDeleteModal_Click(object sender, EventArgs e)
        {
            int productId;
            if (int.TryParse(hfProductId.Value, out productId) && productId > 0)
            {
                hfDeleteProductId.Value = productId.ToString();
            }
            pnlProductModal.Style["display"] = "none";
            pnlConfirmDeleteModal.Style["display"] = "flex";
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            int productId;
            if (int.TryParse(hfDeleteProductId.Value, out productId) && productId > 0)
            {
                AppData.DeleteProduct(productId);
            }
            pnlProductModal.Style["display"] = "none";
            pnlConfirmDeleteModal.Style["display"] = "none";
            pnlSuccessDeleteModal.Style["display"] = "flex";
            BindProducts();
        }

        protected void btnCancelDelete_Click(object sender, EventArgs e)
        {
            pnlConfirmDeleteModal.Style["display"] = "none";
        }

        protected void btnReturnToInventory_Click(object sender, EventArgs e)
        {
            pnlSuccessDeleteModal.Style["display"] = "none";
            pnlConfirmDeleteModal.Style["display"] = "none";
            pnlProductModal.Style["display"] = "none";
            BindProducts();
        }

        protected void cvName_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int productId;
            int.TryParse(hfProductId.Value, out productId);
            string name = (args.Value ?? string.Empty).Trim();
            args.IsValid = !AppData.Products.Any(p =>
                p.Id != productId &&
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

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }
    }
}

