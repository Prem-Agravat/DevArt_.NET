using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Promotions listing (Figma frames 14 and 8).</summary>
    public partial class Offers : Page
    {
        public int OfferCount { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) Bind();
        }

        private void Bind()
        {
            var offers = AppData.ActiveOffers;
            OfferCount = offers.Count;
            rptOffers.DataSource = offers;
            rptOffers.DataBind();
        }

        public string GetTopBarStyle(int itemIndex)
        {
            return (itemIndex % 2 == 1) ? "border-top-green" : "border-top-brown";
        }

        public string GetBadgeStyle(int itemIndex)
        {
            return (itemIndex % 2 == 1) ? "badge-green" : "badge-brown";
        }

        public string GetIconSvg(object item, int itemIndex)
        {
            Offer offer = item as Offer;
            if (offer is FreeShippingOffer)
            {
                return "<svg width=\"22\" height=\"22\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"#855335\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><rect x=\"1\" y=\"3\" width=\"15\" height=\"13\"></rect><polygon points=\"16 8 20 8 23 11 23 16 16 16 16 8\"></polygon><circle cx=\"5.5\" cy=\"18.5\" r=\"2.5\"></circle><circle cx=\"18.5\" cy=\"18.5\" r=\"2.5\"></circle></svg>";
            }
            else if (offer is FlatOffer)
            {
                return "<svg width=\"22\" height=\"22\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"#48680E\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 12 20 22 4 22 4 12\"></polyline><rect x=\"2\" y=\"7\" width=\"20\" height=\"5\"></rect><line x1=\"12\" y1=\"22\" x2=\"12\" y2=\"7\"></line><path d=\"M12 7H7.5a2.5 2.5 0 0 1 0-5C11 2 12 7 12 7z\"></path><path d=\"M12 7h4.5a2.5 2.5 0 0 0 0-5C13 2 12 7 12 7z\"></path></svg>";
            }
            else
            {
                string stroke = (itemIndex % 2 == 1) ? "#48680E" : "#855335";
                return string.Format("<svg width=\"22\" height=\"22\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"{0}\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><circle cx=\"12\" cy=\"12\" r=\"10\"></circle><path d=\"M12 8v8M8 12h8\"></path></svg>", stroke);
            }
        }

        public string GetHeadline(object item)
        {
            Offer offer = item as Offer;
            if (offer == null) return string.Empty;

            if (offer is FreeShippingOffer) return "Free Shipping";
            if (offer is FlatOffer) return "₹" + ((FlatOffer)offer).Amount.ToString("N0") + " OFF";
            if (offer is PercentageOffer) return ((PercentageOffer)offer).Percentage + "% OFF";

            return offer.Kicker;
        }

        public string GetSubhead(object item)
        {
            Offer offer = item as Offer;
            if (offer == null) return string.Empty;

            if (offer is FreeShippingOffer)
            {
                return offer.MinimumSpend > 0
                    ? "On Orders Over ₹" + offer.MinimumSpend.ToString("N0")
                    : "On All Artisanal Orders";
            }

            return offer.Name;
        }

        protected void rptOffers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Copy") return;

            string code = Convert.ToString(e.CommandArgument);

            CartService.PromoCode = code;

            if (pnlOfferCopySuccessModal != null)
            {
                pnlOfferCopySuccessModal.Style["display"] = "flex";
            }

            Bind();
        }

        protected void btnReturnToCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx", false);
        }
    }
}
