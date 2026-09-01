using System;
using System.Linq;
using System.Web.UI;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>Store overview (Figma frame 27).</summary>
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            litSales.Text = AppData.TotalSales.ToString("N2");
            litOrders.Text = AppData.Orders.Count().ToString();
            litActive.Text = AppData.ActiveOrderCount.ToString();
            litPending.Text = AppData.PendingOrderCount.ToString();
            litCustomers.Text = AppData.Users.Count().ToString();

            rptOrders.DataSource = AppData.Orders
                .OrderByDescending(o => o.PlacedOn)
                .Take(6)
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
                        : o.Lines[0].ProductName + (o.Lines.Count > 1 ? " + " + (o.Lines.Count - 1) : string.Empty)
                })
                .ToList();
            rptOrders.DataBind();

            rptLowStock.DataSource = AppData.Products
                .Where(p => p.Stock <= 5)
                .OrderBy(p => p.Stock)
                .ToList();
            rptLowStock.DataBind();
        }
    }
}
