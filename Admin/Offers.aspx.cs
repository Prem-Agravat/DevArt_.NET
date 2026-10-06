using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt.Admin
{
    /// <summary>
    /// Offer list and management modal popup (Figma frames 32, 39).
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
            UpdateDiscountValueVisibility();

            // Check query string parameters for popups
            string action = Request.QueryString["action"];
            string editIdStr = Request.QueryString["editId"];

            if (action == "add")
            {
                OpenModalForAdd();
            }
            else if (!string.IsNullOrEmpty(editIdStr))
            {
                int editId;
                if (int.TryParse(editIdStr, out editId))
                {
                    OpenModalForEdit(editId);
                }
            }
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
            int id;
            int.TryParse(Convert.ToString(e.CommandArgument), out id);

            if (e.CommandName == "ToggleActive")
            {
                Offer offer = AppData.FindOffer(id);
                if (offer != null)
                {
                    offer.IsActive = !offer.IsActive;
                    AppData.ReplaceOffer(offer.Id, offer);
                    ShowStatus("Offer status updated for " + Server.HtmlEncode(offer.Code) + ".", true);
                    Bind();
                }
            }
            else if (e.CommandName == "EditOffer")
            {
                OpenModalForEdit(id);
            }
            else if (e.CommandName == "DeleteOffer")
            {
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
        }

        private void HideAllModals()
        {
            pnlOfferModal.Style["display"] = "none";
            pnlSuccessModal.Style["display"] = "none";
            pnlConfirmDeleteOfferModal.Style["display"] = "none";
            pnlSuccessDeleteOfferModal.Style["display"] = "none";
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateDiscountValueVisibility();
            HideAllModals();
            pnlOfferModal.Style["display"] = "flex";
        }

        private void UpdateDiscountValueVisibility()
        {
            string selected = ddlType.SelectedValue;
            if (selected == "Percentage")
            {
                pnlValue.Visible = true;
                lblValueLabel.Text = "Discount Percentage (%) *";
            }
            else if (selected == "Flat")
            {
                pnlValue.Visible = true;
                lblValueLabel.Text = "Discount Amount (₹) *";
            }
            else
            {
                pnlValue.Visible = false;
            }
        }

        private void OpenModalForAdd()
        {
            HideAllModals();
            hfOfferId.Value = "0";
            lblModalTitle.Text = "Add Offer";
            txtKicker.Text = string.Empty;
            txtTitle.Text = string.Empty;
            txtCode.Text = string.Empty;
            ddlType.SelectedValue = "Percentage";
            txtDiscountValue.Text = "15";
            txtMinSpend.Text = "0";
            txtExpiry.Text = DateTime.Today.AddDays(30).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            chkActive.Checked = true;
            chkOneTime.Checked = false;
            pnlModalError.Visible = false;
            btnDeleteOfferModal.Visible = false;
            btnSaveOfferModal.Text = "Add Offer";

            UpdateDiscountValueVisibility();
            pnlOfferModal.Style["display"] = "flex";
        }

        private void OpenModalForEdit(int id)
        {
            HideAllModals();
            Offer offer = AppData.FindOffer(id);
            if (offer == null) return;

            hfOfferId.Value = offer.Id.ToString();
            lblModalTitle.Text = "Edit Offer";
            txtKicker.Text = offer.Kicker;
            txtTitle.Text = offer.Name;
            txtCode.Text = offer.Code;
            txtMinSpend.Text = offer.MinimumSpend.ToString("0.##", CultureInfo.InvariantCulture);
            txtExpiry.Text = offer.ExpiresOn.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            chkActive.Checked = offer.IsActive;
            chkOneTime.Checked = false;
            pnlModalError.Visible = false;
            btnDeleteOfferModal.Visible = true;
            btnSaveOfferModal.Text = "Update Changes";

            PercentageOffer percentage = offer as PercentageOffer;
            FlatOffer flat = offer as FlatOffer;

            if (percentage != null)
            {
                ddlType.SelectedValue = "Percentage";
                txtDiscountValue.Text = percentage.Percentage.ToString();
            }
            else if (flat != null)
            {
                ddlType.SelectedValue = "Flat";
                txtDiscountValue.Text = flat.Amount.ToString("0.##", CultureInfo.InvariantCulture);
            }
            else
            {
                ddlType.SelectedValue = "FreeShipping";
                txtDiscountValue.Text = string.Empty;
            }

            UpdateDiscountValueVisibility();
            pnlOfferModal.Style["display"] = "flex";
        }

        protected void btnDeleteOfferModal_Click(object sender, EventArgs e)
        {
            HideAllModals();
            int offerId;
            if (int.TryParse(hfOfferId.Value, out offerId) && offerId > 0)
            {
                hfDeleteOfferId.Value = offerId.ToString();
            }
            pnlConfirmDeleteOfferModal.Style["display"] = "flex";
        }

        protected void btnConfirmDeleteOffer_Click(object sender, EventArgs e)
        {
            int offerId;
            if (int.TryParse(hfDeleteOfferId.Value, out offerId) && offerId > 0)
            {
                AppData.DeleteOffer(offerId);
            }
            HideAllModals();
            pnlSuccessDeleteOfferModal.Style["display"] = "flex";
            Bind();
        }

        protected void btnCancelDeleteOffer_Click(object sender, EventArgs e)
        {
            HideAllModals();
        }

        protected void btnReturnToOffersAfterDelete_Click(object sender, EventArgs e)
        {
            HideAllModals();
            Bind();
        }

        protected void btnSaveOfferModal_Click(object sender, EventArgs e)
        {
            string kicker = txtKicker.Text.Trim();
            string title = txtTitle.Text.Trim();
            string code = txtCode.Text.Trim().ToUpperInvariant();
            string type = ddlType.SelectedValue;
            string valStr = txtDiscountValue.Text.Trim();
            string minSpendStr = txtMinSpend.Text.Trim();
            string expiryStr = txtExpiry.Text.Trim();

            if (string.IsNullOrEmpty(kicker) || string.IsNullOrEmpty(title) || string.IsNullOrEmpty(code) || string.IsNullOrEmpty(expiryStr))
            {
                ShowModalError("Please fill in all required fields (Offer Name, Title, Promo Code, Expiry Date).");
                return;
            }

            int offerId;
            int.TryParse(hfOfferId.Value, out offerId);

            if (AppData.Offers.Any(o => o.Id != offerId && string.Equals(o.Code, code, StringComparison.OrdinalIgnoreCase)))
            {
                ShowModalError("Another offer already uses promo code '" + code + "'.");
                return;
            }

            decimal minSpend = 0m;
            decimal.TryParse(minSpendStr, NumberStyles.Currency, CultureInfo.InvariantCulture, out minSpend);

            DateTime expiry;
            if (!DateTime.TryParse(expiryStr, CultureInfo.InvariantCulture, DateTimeStyles.None, out expiry))
            {
                ShowModalError("Please enter a valid expiration date.");
                return;
            }

            Offer offer;
            if (type == "Percentage")
            {
                int pct;
                if (!int.TryParse(valStr, out pct) || pct < 1 || pct > 99)
                {
                    ShowModalError("Percentage discount must be a number between 1 and 99.");
                    return;
                }
                offer = new PercentageOffer { Percentage = pct };
            }
            else if (type == "Flat")
            {
                decimal amt;
                if (!decimal.TryParse(valStr, NumberStyles.Currency, CultureInfo.InvariantCulture, out amt) || amt <= 0)
                {
                    ShowModalError("Flat discount amount must be a positive number.");
                    return;
                }
                offer = new FlatOffer { Amount = amt };
            }
            else
            {
                offer = new FreeShippingOffer { ShippingFee = CartService.ShippingFee };
            }

            offer.Kicker = kicker;
            offer.Name = title;
            offer.Code = code;
            offer.Description = kicker + " - " + title;
            offer.MinimumSpend = minSpend;
            offer.ExpiresOn = expiry;
            offer.IsActive = chkActive.Checked;

            if (offerId > 0)
            {
                offer.Id = offerId;
                AppData.ReplaceOffer(offerId, offer);
                lblSuccessTitle.Text = "Offer Updated!";
                lblSuccessSub.Text = "Offer updated successfully.";
                btnBackToOffers.Text = "← Return to Offers";
            }
            else
            {
                AppData.AddOffer(offer);
                lblSuccessTitle.Text = "Offer Added!";
                lblSuccessSub.Text = "Offer added successfully.";
                btnBackToOffers.Text = "← Return to Offers";
            }

            HideAllModals();
            pnlSuccessModal.Style["display"] = "flex";
            Bind();
        }

        protected void btnCancelModal_Click(object sender, EventArgs e)
        {
            HideAllModals();
        }

        protected void btnBackToOffers_Click(object sender, EventArgs e)
        {
            HideAllModals();
            Bind();
        }

        private void ShowModalError(string error)
        {
            pnlModalError.Visible = true;
            litModalError.Text = Server.HtmlEncode(error);
            HideAllModals();
            pnlOfferModal.Style["display"] = "flex";
        }

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }
    }
}

