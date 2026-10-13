using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>
    /// Code-behind for Login.aspx - the customer sign-in screen.
    /// On success, stores the signed-in user in Session and redirects
    /// either back to the page that required login, or to Profile.aspx.
    /// </summary>
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Skip everything on post-backs (button clicks); only run on first load
            if (IsPostBack) return;

            // Check if Register.aspx or ResetPassword.aspx put a one-shot message in Session
            string flash = Session["AuthFlash"] as string;
            if (!string.IsNullOrEmpty(flash))
            {
                // Remove the message so it doesn't show again on the next page load
                Session.Remove("AuthFlash");
                pnlMessage.Visible = true;
                pnlMessage.CssClass = "form-alert success";
                litMessage.Text = flash;
            }
        }

        /// <summary>
        /// Server-side validator: checks that the email + password match a stored account.
        /// Returns IsValid = false if no matching user is found, which shows the
        /// "Invalid credentials" error message on the form.
        /// </summary>
        protected void cvCredentials_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = AppData.FindUser(txtEmail.Text, txtPassword.Text) != null;
        }

        /// <summary>
        /// Handles the Login button click.
        /// Validates credentials, stores the user in Session, then redirects.
        /// </summary>
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Re-run the "SignIn" validation group on the server.
            // This catches requests that bypassed JavaScript (e.g. curl or browser with JS off).
            Page.Validate("SignIn");
            if (!Page.IsValid) return;

            // Fetch the matching user object (credentials already confirmed valid above)
            UserAccount user = AppData.FindUser(txtEmail.Text, txtPassword.Text);

            // Store the user object and email in Session so every page can access them
            Session["CurrentUser"] = user;
            Session["UserEmail"] = user.Email;

            // Extend the session timeout to 2 hours if the user ticked "Remember me"
            if (chkRemember.Checked)
            {
                Session.Timeout = 120;
            }

            // Redirect back to whichever page sent the user here (e.g. Shipping.aspx),
            // or fall back to their profile if no returnUrl was provided
            string returnUrl = Request.QueryString["returnUrl"];
            Response.Redirect(string.IsNullOrEmpty(returnUrl) ? "Profile.aspx" : returnUrl, false);
        }
    }
}
