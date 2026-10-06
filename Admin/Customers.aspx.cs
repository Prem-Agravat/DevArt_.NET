using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>Customer list with delete (Figma frames 33, 34, 35).</summary>
    public partial class Customers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) Bind();
        }

        private void Bind()
        {
            var query = AppData.Users.AsEnumerable();

            string keyword = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(u =>
                    (u.FullName ?? string.Empty).IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (u.Email ?? string.Empty).IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            var rows = query
                .OrderBy(u => u.Id)
                .Select(u => new
                {
                    u.Id,
                    u.FullName,
                    u.Email,
                    u.City,
                    u.CreatedOn,
                    OrderCount = AppData.OrdersFor(u.Email).Count
                })
                .ToList();

            rptUsers.DataSource = rows;
            rptUsers.DataBind();
            pnlEmpty.Visible = rows.Count == 0;

            litTotal.Text = AppData.Users.Count().ToString();
            litSubscribed.Text = AppData.Users.Count(u => u.NewsletterOptIn).ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Bind();
        }

        protected void rptUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id)) return;

            UserAccount user = AppData.Users.FirstOrDefault(u => u.Id == id);
            if (user == null) return;

            if (e.CommandName == "ViewUser")
            {
                int orderCount = AppData.OrdersFor(user.Email).Count;
                ShowStatus("Customer details — Name: " + Server.HtmlEncode(user.FullName) + " | Email: " + Server.HtmlEncode(user.Email) + " | City: " + Server.HtmlEncode(user.City ?? "N/A") + " | Total Orders: " + orderCount, true);
            }
            else if (e.CommandName == "PromptDelete" || e.CommandName == "DeleteUser")
            {
                hfDeleteUserId.Value = id.ToString();
                pnlConfirmDeleteModal.Style["display"] = "flex";
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            int id;
            if (int.TryParse(hfDeleteUserId.Value, out id) && id > 0)
            {
                AppData.DeleteUser(id);
                pnlConfirmDeleteModal.Style["display"] = "none";
                pnlSuccessDeleteModal.Style["display"] = "flex";
                Bind();
            }
            else
            {
                pnlConfirmDeleteModal.Style["display"] = "none";
            }
        }

        protected void btnCancelDelete_Click(object sender, EventArgs e)
        {
            pnlConfirmDeleteModal.Style["display"] = "none";
        }

        protected void btnReturnToCustomers_Click(object sender, EventArgs e)
        {
            pnlSuccessDeleteModal.Style["display"] = "none";
            Bind();
        }

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }
    }
}
