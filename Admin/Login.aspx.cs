using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DevArt.Admin
{
    /// <summary>
    /// Staff sign-in, reached from the "Admin Panel" link on the customer login
    /// (Figma frame 1).
    /// </summary>
    public partial class AdminLogin : Page
    {
        // Demo credentials. A real build would read these from a Staff table.
        private const string StaffEmail = "admin@devart.com";
        private const string StaffPassword = "Admin@123";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void cvCredentials_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid =
                string.Equals(txtEmail.Text.Trim(), StaffEmail, StringComparison.OrdinalIgnoreCase) &&
                txtPassword.Text == StaffPassword;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Page.Validate("AdminLogin");
            if (!Page.IsValid) return;

            Session[AdminMaster.AdminSessionKey] = txtEmail.Text.Trim();
            Response.Redirect("Dashboard.aspx", false);
        }
    }
}
