using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    public partial class Shipping : Page
    {
        public int SelectedAddressId
        {
            get
            {
                object val = ViewState["SelectedAddressId"];
                return val != null ? (int)val : 0;
            }
            set { ViewState["SelectedAddressId"] = value; }
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

        protected void Page_Load(object sender, EventArgs e)
        {
            UserAccount user = Session["CurrentUser"] as UserAccount;

            // Guard: no customer, or nothing to ship.
            if (user == null)
            {
                Response.Redirect("Login.aspx?returnUrl=Shipping.aspx", false);
                return;
            }

            if (CartService.Items.Count == 0)
            {
                Response.Redirect("Cart.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                BindAddresses(user);
                BindSummary();
            }
        }

        private void BindAddresses(UserAccount user)
        {
            var list = AppData.AddressesFor(user.Email);

            int chosen = Session[CartService.ShipToKey] is int ? (int)Session[CartService.ShipToKey] : 0;
            if (chosen > 0 && list.Any(a => a.Id == chosen))
            {
                SelectedAddressId = chosen;
            }
            else if (list.Count > 0)
            {
                SelectedAddressId = list[0].Id;
            }

            rptAddresses.DataSource = list;
            rptAddresses.DataBind();

            var rowData = list.Select(a => new { a.Id, Display = a.FullName + " - " + a.OneLine + " (" + a.Label + ")" }).ToList();
            rblAddresses.DataSource = rowData;
            rblAddresses.DataBind();

            if (SelectedAddressId > 0 && rblAddresses.Items.FindByValue(SelectedAddressId.ToString()) != null)
            {
                rblAddresses.SelectedValue = SelectedAddressId.ToString();
            }

            hfSelectedAddressId.Value = SelectedAddressId.ToString();
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
            litTotal.Text = CartService.Total.ToString("N0");
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            int addressId = 0;
            if (!string.IsNullOrEmpty(hfSelectedAddressId.Value))
            {
                int.TryParse(hfSelectedAddressId.Value, out addressId);
            }
            if (addressId == 0 && rblAddresses.SelectedItem != null)
            {
                int.TryParse(rblAddresses.SelectedValue, out addressId);
            }

            if (addressId <= 0)
            {
                rfvAddress.IsValid = false;
                return;
            }

            Session[CartService.ShipToKey] = addressId;
            Response.Redirect("Payment.aspx", false);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx", false);
        }
    }
}
