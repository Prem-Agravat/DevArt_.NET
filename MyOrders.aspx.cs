using System;
using System.Linq;
using System.Web.UI;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Order history (Figma frame 21).</summary>
    public partial class MyOrders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserAccount user = Session["CurrentUser"] as UserAccount;

            pnlGuest.Visible = user == null;
            pnlOrders.Visible = user != null;

            if (user != null && !IsPostBack) Bind(user);
        }

        private void Bind(UserAccount user)
        {
            var orders = AppData.OrdersFor(user.Email).AsEnumerable();

            string status = ddlStatus.SelectedValue;
            if (!string.IsNullOrEmpty(status))
            {
                orders = orders.Where(o => string.Equals(o.Status, status, StringComparison.OrdinalIgnoreCase));
            }

            var rows = orders.Select(o => new
            {
                o.OrderNumber,
                o.PlacedOn,
                o.Status,
                o.StatusClass,
                o.Total,
                // One readable line for the whole order.
                Summary = o.Lines.Count == 1
                    ? o.Lines[0].ProductName
                    : o.Lines[0].ProductName + " + " + (o.Lines.Count - 1) + " more"
            }).ToList();

            rptOrders.DataSource = rows;
            rptOrders.DataBind();

            pnlEmpty.Visible = rows.Count == 0;
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            UserAccount user = Session["CurrentUser"] as UserAccount;
            if (user != null) Bind(user);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
        }
    }
}
