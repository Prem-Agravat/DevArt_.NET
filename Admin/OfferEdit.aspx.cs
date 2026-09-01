using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>Add / edit / delete an offer (Figma frames 41, 42, 46).</summary>
    public partial class OfferEdit : Page
    {
        private int OfferId
        {
            get
            {
                int id;
                int.TryParse(Request.QueryString["id"], out id);
                return id;
            }
        }

        private bool IsEdit
        {
            get { return OfferId > 0; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            litHeading.Text = IsEdit ? "Edit Offer" : "Add Offer";
            btnSave.Text = IsEdit ? "Update Changes" : "Add Offer";
            btnDelete.Visible = IsEdit;

            // An offer has to expire after today, and "today" moves.
            cmpExpiry.ValueToCompare = DateTime.Today.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

            if (!IsPostBack && IsEdit)
            {
                LoadOffer();
            }

            ApplyTypeState();
        }

        private void LoadOffer()
        {
            Offer offer = AppData.FindOffer(OfferId);
            if (offer == null)
            {
                Response.Redirect("Offers.aspx", false);
                return;
            }

            txtKicker.Text = offer.Kicker;
            txtTitle.Text = offer.Name;
            txtCode.Text = offer.Code;
            txtDescription.Text = offer.Description;
            txtMinSpend.Text = offer.MinimumSpend.ToString("0.##", CultureInfo.InvariantCulture);
            txtExpiry.Text = offer.ExpiresOn.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            chkActive.Checked = offer.IsActive;

            // Which concrete subclass this is decides the type and the amount field.
            PercentageOffer percentage = offer as PercentageOffer;
            FlatOffer flat = offer as FlatOffer;

            if (percentage != null)
            {
                ddlType.SelectedValue = "Percentage";
                txtPercentage.Text = percentage.Percentage.ToString();
            }
            else if (flat != null)
            {
                ddlType.SelectedValue = "Flat";
                txtAmount.Text = flat.Amount.ToString("0.##", CultureInfo.InvariantCulture);
            }
            else
            {
                ddlType.SelectedValue = "FreeShipping";
            }
        }

        /// <summary>
        /// Only the validators belonging to the chosen discount type are enabled;
        /// a disabled validator never blocks the post-back.
        /// </summary>
        private void ApplyTypeState()
        {
            bool percentage = ddlType.SelectedValue == "Percentage";
            bool flat = ddlType.SelectedValue == "Flat";

            pnlPercentage.Visible = percentage;
            rfvPercentage.Enabled = percentage;
            rngPercentage.Enabled = percentage;

            pnlFlat.Visible = flat;
            rfvAmount.Enabled = flat;
            rngAmount.Enabled = flat;
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            ApplyTypeState();
        }

        // ------------------------------------------------- server-side validators

        protected void cvCode_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string code = (args.Value ?? string.Empty).Trim();
            args.IsValid = !AppData.Offers.Any(o =>
                o.Id != OfferId &&
                string.Equals(o.Code, code, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>A flat discount must not exceed the minimum spend that unlocks it.</summary>
        protected void cvMinSpend_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (ddlType.SelectedValue != "Flat")
            {
                args.IsValid = true;
                return;
            }

            decimal amount, minSpend;
            bool parsedAmount = decimal.TryParse(txtAmount.Text.Trim(), NumberStyles.Currency, CultureInfo.InvariantCulture, out amount);
            bool parsedMin = decimal.TryParse(txtMinSpend.Text.Trim(), NumberStyles.Currency, CultureInfo.InvariantCulture, out minSpend);

            // Let the range validators report unparseable input.
            args.IsValid = !parsedAmount || !parsedMin || minSpend == 0m || amount <= minSpend;
        }

        // --------------------------------------------------------------- actions

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("Offer");
            if (!Page.IsValid) return;

            decimal minSpend = decimal.Parse(txtMinSpend.Text.Trim(), NumberStyles.Currency, CultureInfo.InvariantCulture);
            DateTime expiry = DateTime.Parse(txtExpiry.Text, CultureInfo.InvariantCulture);

            // Build the concrete Offer subclass that matches the chosen type.
            Offer offer;
            switch (ddlType.SelectedValue)
            {
                case "Percentage":
                    offer = new PercentageOffer { Percentage = int.Parse(txtPercentage.Text.Trim()) };
                    break;
                case "Flat":
                    offer = new FlatOffer
                    {
                        Amount = decimal.Parse(txtAmount.Text.Trim(), NumberStyles.Currency, CultureInfo.InvariantCulture)
                    };
                    break;
                default:
                    offer = new FreeShippingOffer { ShippingFee = CartService.ShippingFee };
                    break;
            }

            offer.Kicker = txtKicker.Text.Trim();
            offer.Name = txtTitle.Text.Trim();
            offer.Code = txtCode.Text.Trim().ToUpperInvariant();
            offer.Description = txtDescription.Text.Trim();
            offer.MinimumSpend = minSpend;
            offer.ExpiresOn = expiry;
            offer.IsActive = chkActive.Checked;

            if (IsEdit)
            {
                AppData.ReplaceOffer(OfferId, offer);
                Session["AdminFlash"] = "Offer updated successfully: " + Server.HtmlEncode(offer.Code) + ".";
            }
            else
            {
                AppData.AddOffer(offer);
                Session["AdminFlash"] = "Offer added successfully: " + Server.HtmlEncode(offer.Code) + ".";
            }

            Response.Redirect("Offers.aspx", false);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Offer offer = AppData.FindOffer(OfferId);
            if (offer != null && AppData.DeleteOffer(OfferId))
            {
                Session["AdminFlash"] = "Offer deleted successfully: " + Server.HtmlEncode(offer.Code) + ".";
            }

            Response.Redirect("Offers.aspx", false);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Offers.aspx", false);
        }
    }
}
