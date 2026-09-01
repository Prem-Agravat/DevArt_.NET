using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Promotions listing (Figma frames 14 and 8).</summary>
    public partial class Offers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) Bind();
        }

        private void Bind()
        {
            rptOffers.DataSource = AppData.ActiveOffers;
            rptOffers.DataBind();
        }

        protected void rptOffers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Copy") return;

            string code = Convert.ToString(e.CommandArgument);

            // "Copy" parks the code on the cart, which is what the design's
            // "Offer Code Copied - Return to Cart" dialog does.
            CartService.PromoCode = code;

            pnlStatus.Visible = true;
            pnlStatus.CssClass = "form-alert success";
            litStatus.Text = "Offer code <strong>" + Server.HtmlEncode(code) +
                             "</strong> copied successfully. " +
                             "<a href=\"Cart.aspx\" style=\"text-decoration:underline;\">Return to cart</a> to apply it.";

            Bind();
        }
    }
}
