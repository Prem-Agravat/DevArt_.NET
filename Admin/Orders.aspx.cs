using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>Order fulfilment (Figma frame 31).</summary>
    public partial class Orders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) Bind();
        }

        /// <summary>The next stage in the fulfilment chain, or empty when delivered.</summary>
        private static string NextStatusFor(string status)
        {
            switch ((status ?? string.Empty).ToLowerInvariant())
            {
                case "pending": return "Out for Delivery";
                case "out for delivery": return "In Transit";
                case "in transit": return "Delivered";
                default: return string.Empty;
            }
        }

        private void Bind()
        {
            litTotal.Text = AppData.Orders.Count().ToString();
            litActive.Text = AppData.ActiveOrderCount.ToString();
            litPending.Text = AppData.PendingOrderCount.ToString();

            var query = AppData.Orders.AsEnumerable();

            string filter = ddlStatus.SelectedValue;
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(o => string.Equals(o.Status, filter, StringComparison.OrdinalIgnoreCase));
            }

            var rows = query
                .OrderByDescending(o => o.PlacedOn)
                .Select(o => new
                {
                    o.OrderNumber,
                    o.CustomerName,
                    o.PlacedOn,
                    o.Status,
                    o.StatusClass,
                    o.Total,
                    Product = o.Lines.Count == 0
                        ? "-"
                        : o.Lines[0].ProductName + (o.Lines.Count > 1 ? " + " + (o.Lines.Count - 1) : string.Empty),
                    NextStatus = NextStatusFor(o.Status),
                    NextLabel = "Mark " + NextStatusFor(o.Status)
                })
                .ToList();

            rptOrders.DataSource = rows;
            rptOrders.DataBind();
            pnlEmpty.Visible = rows.Count == 0;
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind();
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Advance") return;

            string number = Convert.ToString(e.CommandArgument);
            Order order = AppData.FindOrder(number);
            if (order == null) return;

            string next = NextStatusFor(order.Status);
            if (string.IsNullOrEmpty(next)) return;

            AppData.SetOrderStatus(number, next);

            pnlStatus.Visible = true;
            pnlStatus.CssClass = "form-alert success";
            litStatus.Text = "Order #" + Server.HtmlEncode(number) + " is now <strong>" + next + "</strong>.";

            Bind();
        }
    }
}
