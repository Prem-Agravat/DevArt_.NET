using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>
    /// Add-address form (Figma frame 6). Named AddressPage so the class does not
    /// collide with DevArt.Models.Address.
    /// </summary>
    public partial class AddressPage : Page
    {
        private string ReturnUrl
        {
            get
            {
                string url = Request.QueryString["returnUrl"];
                return string.IsNullOrEmpty(url) ? "Profile.aspx" : url;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            UserAccount user = Session["CurrentUser"] as UserAccount;
            if (user == null)
            {
                Response.Redirect("Login.aspx?returnUrl=Address.aspx", false);
                return;
            }

            lnkBack.NavigateUrl = ReturnUrl;
            lnkBack.Text = ReturnUrl.StartsWith("Shipping", StringComparison.OrdinalIgnoreCase)
                ? "Return to Shipping"
                : "Return to Profile";

            if (!IsPostBack)
            {
                txtName.Text = user.FullName;
                txtPhone.Text = user.Phone;
                txtCity.Text = user.City;
                txtPincode.Text = user.Pincode;
            }
        }

        /// <summary>Server-side twin of validateAddressLine().</summary>
        protected void cvLine1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = (args.Value ?? string.Empty).Trim().Length >= 6;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("Address");
            if (!Page.IsValid) return;

            Address address = new Address
            {
                FullName = txtName.Text.Trim(),
                Phone = txtPhone.Text.Trim(),
                Line1 = txtLine1.Text.Trim(),
                Line2 = txtLine2.Text.Trim(),
                City = txtCity.Text.Trim(),
                State = ddlState.SelectedValue,
                Pincode = txtPincode.Text.Trim(),
                Label = rblLabel.SelectedValue,
                IsDefault = chkDefault.Checked
            };

            AppData.AddAddress(address);

            // Ship straight to the new address if we came from checkout.
            Session[CartService.ShipToKey] = address.Id;

            Response.Redirect(ReturnUrl, false);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(ReturnUrl, false);
        }
    }
}
