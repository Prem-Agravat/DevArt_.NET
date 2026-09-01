using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Registration screen (Figma frame 2).</summary>
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // The terms validator needs the rendered id of the checkbox to inspect it
            // from JavaScript; ClientID is only known once the control tree is built.
            cvTerms.Attributes["data-terms"] = chkTerms.ClientID;
        }

        // ------------------------------------------------- server-side validators

        protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !AppData.EmailExists(args.Value);
        }

        protected void cvPasswordStrength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = ValidationRules.IsStrongPassword(args.Value);
        }

        protected void cvTerms_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkTerms.Checked;
        }

        // --------------------------------------------------------------- actions

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Page.Validate("Register");
            if (!Page.IsValid) return;

            UserAccount account = new UserAccount
            {
                FullName = txtName.Text,
                Email = txtEmail.Text.Trim(),
                Password = txtPassword.Text,
                NewsletterOptIn = true
            };

            AppData.AddUser(account);

            // Hand a one-shot message to Login.aspx through Session.
            Session["AuthFlash"] = "Welcome aboard, " + Server.HtmlEncode(account.FullName) +
                                   "! Your DevArt account is ready - sign in to continue.";
            Response.Redirect("Login.aspx", false);
        }
    }
}
