using System;
using System.Web.UI;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Order confirmation (Figma frame 16).</summary>
    public partial class OrderSuccess : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string number = Session[CartService.LastOrderKey] as string;
            Order order = AppData.FindOrder(number);

            // Nothing to confirm - send the visitor somewhere useful.
            if (order == null)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            litOrderNumber.Text = Server.HtmlEncode(order.OrderNumber);
            litEta.Text = order.PlacedOn.AddDays(4).ToString("MMM d") + " - " +
                          order.EstimatedDelivery.ToString("MMM d");
            litMethod.Text = Server.HtmlEncode(order.PaymentMethod);
            litTotal.Text = order.Total.ToString("N0");

            rptLines.DataSource = order.Lines;
            rptLines.DataBind();

            if (order.ShipTo != null)
            {
                litAddress.Text = "<strong>" + Server.HtmlEncode(order.ShipTo.FullName) + "</strong><br />" +
                                  Server.HtmlEncode(order.ShipTo.OneLine);
            }
        }
    }
}
