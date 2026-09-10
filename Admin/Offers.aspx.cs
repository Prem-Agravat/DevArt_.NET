using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>
    /// Offer list (Figma frames 32, 39). Named AdminOffers so it does not clash
    /// with the customer-facing DevArt.Offers page.
    /// </summary>
    public partial class AdminOffers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            string flash = Session["AdminFlash"] as string;
            if (!string.IsNullOrEmpty(flash))
            {
                Session.Remove("AdminFlash");
                ShowStatus(flash, true);
            }

            Bind();
        }

        private void Bind()
        {
            var offers = AppData.Offers.OrderBy(o => o.Id).ToList();
            rptOffers.DataSource = offers;
            rptOffers.DataBind();
            pnlEmpty.Visible = offers.Count == 0;
        }

        protected void rptOffers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "DeleteOffer") return;

            int id;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id)) return;

            Offer offer = AppData.FindOffer(id);
            if (offer != null && AppData.DeleteOffer(id))
            {
                ShowStatus("Offer deleted successfully: " + Server.HtmlEncode(offer.Code) + ".", true);
            }
            else
            {
                ShowStatus("That offer no longer exists.", false);
            }

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
