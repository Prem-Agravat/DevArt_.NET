using System;
using System.IO;
using System.Web.UI;

namespace DevArt.Admin
{
    /// <summary>
    /// Shell for the store-staff pages (Figma frames 27-33). A second master page
    /// keeps the admin chrome completely separate from the storefront chrome.
    /// </summary>
    public partial class AdminMaster : MasterPage
    {
        public const string AdminSessionKey = "AdminUser";

        protected void Page_Load(object sender, EventArgs e)
        {
            string admin = Session[AdminSessionKey] as string;

            // Every page that uses this master is behind the admin sign-in.
            if (string.IsNullOrEmpty(admin))
            {
                Response.Redirect("~/Default.aspx", false);
                return;
            }

            litAdminEmail.Text = Server.HtmlEncode(admin);
        }

        protected string NavClass(string page)
        {
            string current = Path.GetFileNameWithoutExtension(Request.AppRelativeCurrentExecutionFilePath ?? string.Empty);
            return string.Equals(current, page, StringComparison.OrdinalIgnoreCase) ? "active" : string.Empty;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Remove(AdminSessionKey);
            Response.Redirect("~/Default.aspx", false);
        }
    }
}
