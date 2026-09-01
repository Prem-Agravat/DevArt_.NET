using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Account dashboard (Figma frames 17, 18 and 20).</summary>
    public partial class Profile : Page
    {
        /// <summary>The customer held in Session, or null for a guest.</summary>
        private UserAccount CurrentUser
        {
            get { return Session["CurrentUser"] as UserAccount; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            rngDob.MinimumValue = DateTime.Today.AddYears(-100).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            rngDob.MaximumValue = DateTime.Today.AddYears(-18).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

            bool signedIn = CurrentUser != null;
            pnlProfile.Visible = signedIn;
            pnlGuest.Visible = !signedIn;

            if (!signedIn) return;

            BindSidebar();

            if (!IsPostBack)
            {
                LoadProfile();
                BindOrders();
            }
        }

        private void LoadProfile()
        {
            UserAccount user = CurrentUser;

            litWho.Text = Server.HtmlEncode(user.ToString());
            txtName.Text = user.FullName;
            txtEmail.Text = user.Email;
            txtPhone.Text = user.Phone;
            txtPincode.Text = user.Pincode;
            chkNewsletter.Checked = user.NewsletterOptIn;

            if (!string.IsNullOrEmpty(user.City) && ddlCity.Items.FindByValue(user.City) != null)
            {
                ddlCity.SelectedValue = user.City;
            }

            if (user.DateOfBirth != DateTime.MinValue)
            {
                txtDob.Text = user.DateOfBirth.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            }

            Address primary = AppData.AddressesFor(user.Email).FirstOrDefault(a => a.IsDefault)
                              ?? AppData.AddressesFor(user.Email).FirstOrDefault();

            litAddress.Text = primary == null
                ? "No shipping address saved yet."
                : "<strong>" + Server.HtmlEncode(primary.FullName) + "</strong><br />" +
                  Server.HtmlEncode(primary.OneLine) + "<br />" +
                  Server.HtmlEncode(primary.Phone);
        }

        private void BindSidebar()
        {
            var orders = AppData.OrdersFor(CurrentUser.Email);
            litOrderCount.Text = orders.Count.ToString();
            litPending.Text = orders.Count(o => o.Status != "Delivered").ToString();
            litWishCount.Text = CartService.WishlistIds.Count.ToString();
        }

        private void BindOrders()
        {
            var rows = AppData.OrdersFor(CurrentUser.Email)
                .Take(3)
                .Select(o => new
                {
                    o.OrderNumber,
                    o.PlacedOn,
                    o.Status,
                    o.StatusClass,
                    o.Total,
                    Summary = o.Lines.Count == 1
                        ? o.Lines[0].ProductName
                        : o.Lines[0].ProductName + " + " + (o.Lines.Count - 1) + " more"
                })
                .ToList();

            rptRecent.DataSource = rows;
            rptRecent.DataBind();
            pnlNoOrders.Visible = rows.Count == 0;
        }

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }

        // ------------------------------------------------- server-side validators

        protected void cvCurrent_ServerValidate(object source, ServerValidateEventArgs args)
        {
            UserAccount user = CurrentUser;
            args.IsValid = user != null && user.Password == args.Value;
        }

        protected void cvNewStrength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = ValidationRules.IsStrongPassword(args.Value);
        }

        // --------------------------------------------------------------- actions

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Only the "Profile" group is validated - the password fields are untouched.
            Page.Validate("Profile");
            if (!Page.IsValid) return;

            UserAccount user = CurrentUser;

            DateTime dob;
            DateTime.TryParse(txtDob.Text, out dob);

            user.FullName = txtName.Text;
            user.Phone = txtPhone.Text.Trim();
            user.City = ddlCity.SelectedValue;
            user.Pincode = txtPincode.Text.Trim();
            user.DateOfBirth = dob;
            user.NewsletterOptIn = chkNewsletter.Checked;

            AppData.UpdateUser(user);
            Session["CurrentUser"] = user;

            litWho.Text = Server.HtmlEncode(user.ToString());
            ShowStatus("Your profile has been updated.", true);
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            Page.Validate("Password");
            if (!Page.IsValid) return;

            UserAccount user = CurrentUser;
            user.Password = txtNewPassword.Text;
            Session["CurrentUser"] = user;

            txtCurrentPassword.Text = string.Empty;
            txtNewPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;

            ShowStatus("Your password has been updated successfully.", true);
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            // Abandon clears every server-side Session value for this user.
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
        }
    }
}
