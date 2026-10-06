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
            if (rngDob != null)
            {
                rngDob.MinimumValue = DateTime.Today.AddYears(-100).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
                rngDob.MaximumValue = DateTime.Today.AddYears(-18).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            }

            bool signedIn = CurrentUser != null;
            if (pnlProfile != null) pnlProfile.Visible = signedIn;
            if (pnlGuest != null) pnlGuest.Visible = !signedIn;

            if (!signedIn) return;

            BindSidebar();

            if (!IsPostBack)
            {
                LoadProfile();
                BindOrders();
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

        private void LoadProfile()
        {
            UserAccount user = CurrentUser;
            if (user == null) return;

            if (litUserName != null) litUserName.Text = Server.HtmlEncode(user.FullName);
            if (litUserEmail != null) litUserEmail.Text = Server.HtmlEncode(user.Email);
            if (litUserJoined != null) litUserJoined.Text = "Joined " + user.CreatedOn.ToString("MMM yyyy");

            if (litWho != null) litWho.Text = Server.HtmlEncode(user.ToString());
            if (txtName != null) txtName.Text = user.FullName;
            if (txtEmail != null) txtEmail.Text = user.Email;
            if (txtPhone != null) txtPhone.Text = user.Phone;
            if (txtPincode != null) txtPincode.Text = user.Pincode;
            if (chkNewsletter != null) chkNewsletter.Checked = user.NewsletterOptIn;

            if (ddlCity != null && !string.IsNullOrEmpty(user.City) && ddlCity.Items.FindByValue(user.City) != null)
            {
                ddlCity.SelectedValue = user.City;
            }

            if (txtDob != null && user.DateOfBirth != DateTime.MinValue)
            {
                txtDob.Text = user.DateOfBirth.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            }

            Address primary = AppData.AddressesFor(user.Email).FirstOrDefault(a => a.IsDefault)
                              ?? AppData.AddressesFor(user.Email).FirstOrDefault();

            if (primary != null)
            {
                if (txtStreetAddress != null) txtStreetAddress.Text = primary.Line1;
                if (txtState != null) txtState.Text = string.IsNullOrEmpty(primary.State) ? "Gujarat" : primary.State;
            }
            else
            {
                if (txtStreetAddress != null) txtStreetAddress.Text = "102, Craftmen's Plaza, Kalavad Road";
                if (txtState != null) txtState.Text = "Gujarat";
            }

            if (litAddress != null)
            {
                litAddress.Text = primary == null
                    ? "No shipping address saved yet."
                    : "<strong>" + Server.HtmlEncode(primary.FullName) + "</strong><br />" +
                      Server.HtmlEncode(primary.OneLine) + "<br />" +
                      Server.HtmlEncode(primary.Phone);
            }
        }

        private void BindSidebar()
        {
            if (CurrentUser == null) return;

            var orders = AppData.OrdersFor(CurrentUser.Email);
            int totalOrders = orders.Count;
            int pending = orders.Count(o => o.Status != "Delivered");
            int wishCount = CartService.WishlistIds.Count;

            if (litOrderCount != null) litOrderCount.Text = totalOrders.ToString();
            if (litPending != null) litPending.Text = pending.ToString();
            if (litWishCount != null) litWishCount.Text = wishCount.ToString();

            if (litStatArtworks != null) litStatArtworks.Text = (totalOrders == 0 ? 12 : totalOrders * 3).ToString();
            if (litStatPending != null) litStatPending.Text = pending.ToString();
            if (litStatWishlist != null) litStatWishlist.Text = (wishCount == 0 ? 24 : wishCount).ToString();
        }

        private void BindOrders()
        {
            if (CurrentUser == null) return;

            var orders = AppData.OrdersFor(CurrentUser.Email);

            var rows = orders.Take(3).Select(o =>
            {
                string firstProductName = o.Lines.Count > 0 ? o.Lines[0].ProductName : "Artisanal Piece";
                Product prod = AppData.Products.FirstOrDefault(p => p.Name.Equals(firstProductName, StringComparison.OrdinalIgnoreCase));
                string img = prod != null ? prod.Image : "category_cushion.jpg";

                return new
                {
                    o.OrderNumber,
                    o.PlacedOn,
                    o.Status,
                    o.StatusClass,
                    o.Total,
                    Summary = firstProductName,
                    Image = img
                };
            }).ToList();

            if (rptRecent != null)
            {
                rptRecent.DataSource = rows;
                rptRecent.DataBind();
            }
            if (pnlNoOrders != null) pnlNoOrders.Visible = rows.Count == 0;
        }

        private void ShowStatus(string text, bool success)
        {
            if (pnlStatus == null) return;
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            if (litStatus != null) litStatus.Text = text;
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
            if (user == null) return;

            DateTime dob = DateTime.Now;
            if (txtDob != null) DateTime.TryParse(txtDob.Text, out dob);

            if (txtName != null) user.FullName = txtName.Text;
            if (txtPhone != null) user.Phone = txtPhone.Text.Trim();
            if (ddlCity != null) user.City = ddlCity.SelectedValue;
            if (txtPincode != null) user.Pincode = txtPincode.Text.Trim();
            user.DateOfBirth = dob;
            if (chkNewsletter != null) user.NewsletterOptIn = chkNewsletter.Checked;

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
            if (user != null)
            {
                user.Password = txtNewPassword.Text;
                Session["CurrentUser"] = user;
            }

            txtCurrentPassword.Text = string.Empty;
            txtNewPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;

            if (pnlPasswordSuccessModal != null)
            {
                pnlPasswordSuccessModal.Style["display"] = "flex";
            }
            ShowStatus("Your password has been updated successfully.", true);
        }

        protected void btnBackToProfile_Click(object sender, EventArgs e)
        {
            if (pnlPasswordSuccessModal != null)
            {
                pnlPasswordSuccessModal.Style["display"] = "none";
            }
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            // Abandon clears every server-side Session value for this user.
            Session.Abandon();
            Response.Redirect("Default.aspx", false);
        }
    }
}
