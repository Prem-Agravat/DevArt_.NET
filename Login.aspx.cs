using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>
    /// Sign-in screen (Figma frame 1). Registration lives on its own page,
    /// exactly as the design lays it out.
    /// </summary>
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Flash message handed over by Register / ResetPassword through Session.
            string flash = Session["AuthFlash"] as string;
            if (!string.IsNullOrEmpty(flash))
            {
                Session.Remove("AuthFlash");
                pnlMessage.Visible = true;
                pnlMessage.CssClass = "form-alert success";
                litMessage.Text = flash;
            }
        }

        /// <summary>Checks the credentials against the user collection.</summary>
        protected void cvCredentials_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = AppData.FindUser(txtEmail.Text, txtPassword.Text) != null;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Re-run the group on the server; a post-back that skipped JavaScript
            // is rejected here in exactly the same way.
            Page.Validate("SignIn");
            if (!Page.IsValid) return;

            UserAccount user = AppData.FindUser(txtEmail.Text, txtPassword.Text);

            // Server-side state management for the signed-in customer.
            Session["CurrentUser"] = user;
            Session["UserEmail"] = user.Email;

            if (chkRemember.Checked)
            {
                Session.Timeout = 120;
            }

            // Return to whatever page sent the visitor here, else the profile.
            string returnUrl = Request.QueryString["returnUrl"];
            Response.Redirect(string.IsNullOrEmpty(returnUrl) ? "Profile.aspx" : returnUrl, false);
        }
    }
}
