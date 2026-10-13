using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>
    /// Code-behind for Register.aspx - new customer sign-up form.
    /// Validates name, email uniqueness, password strength, and terms acceptance.
    /// On success, creates the account and redirects to Login.aspx with a welcome message.
    /// </summary>
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // The terms checkbox validator needs the rendered HTML id of the checkbox
            // so JavaScript can inspect it. ClientID is only known after the control tree builds.
            cvTerms.Attributes["data-terms"] = chkTerms.ClientID;
        }

        // ------------------------------------------------- server-side validators

        /// <summary>
        /// Checks that the entered email is not already registered.
        /// Returns IsValid = false if a duplicate is found, blocking registration.
        /// </summary>
        protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !AppData.EmailExists(args.Value);
        }

        /// <summary>
        /// Checks that the password meets complexity requirements:
        /// at least 8 characters, one uppercase, one lowercase, one digit, one special char.
        /// </summary>
        protected void cvPasswordStrength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = ValidationRules.IsStrongPassword(args.Value);
        }

        /// <summary>
        /// Ensures the Terms and Conditions checkbox has been ticked.
        /// A server-side check prevents a crafted request from bypassing the client check.
        /// </summary>
        protected void cvTerms_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkTerms.Checked;
        }

        // --------------------------------------------------------------- actions

        /// <summary>
        /// Handles the Register button click.
        /// Validates the form, creates a new UserAccount, adds it to the data store,
        /// then redirects to Login.aspx with a one-shot welcome message in Session.
        /// </summary>
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Run all validators in the "Register" group on the server
            Page.Validate("Register");
            if (!Page.IsValid) return;

            // Build the new account from the form fields
            UserAccount account = new UserAccount
            {
                FullName = txtName.Text,
                Email = txtEmail.Text.Trim(),
                Password = txtPassword.Text,
                // Auto-subscribe new accounts to the newsletter
                NewsletterOptIn = true
            };

            // Persist the new account in the in-memory data store
            AppData.AddUser(account);

            // Put a one-shot welcome message in Session; Login.aspx will display and then remove it
            Session["AuthFlash"] = "Welcome aboard, " + Server.HtmlEncode(account.FullName) +
                                   "! Your DevArt account is ready - sign in to continue.";
            Response.Redirect("Login.aspx", false);
        }
    }
}
