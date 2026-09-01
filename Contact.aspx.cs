using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // "Not in the past" has to be recalculated per request, so ValueToCompare
            // is assigned here rather than hard-coded in the markup.
            cmpCallDate.ValueToCompare = DateTime.Today.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

            if (!IsPostBack)
            {
                // Pre-fill from the signed-in customer held in Session, if there is one.
                UserAccount user = Session["CurrentUser"] as UserAccount;
                if (user != null)
                {
                    txtName.Text = user.FullName;
                    txtEmail.Text = user.Email;
                    txtPhone.Text = user.Phone;
                }

                BindEnquiries();
            }
        }

        /// <summary>
        /// Server-side twin of validateMessageLength(): at least 10 words, at most 500 chars.
        /// </summary>
        protected void cvMessage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string text = (args.Value ?? string.Empty).Trim();
            int words = text.Length == 0
                ? 0
                : text.Split(new[] { ' ', '\t', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries).Length;

            args.IsValid = words >= 10 && text.Length <= 500;
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            Page.Validate("Contact");
            if (!Page.IsValid) return;

            int rating;
            int.TryParse(txtRating.Text.Trim(), out rating);

            DateTime callDate;
            DateTime.TryParse(txtCallDate.Text, out callDate);

            Enquiry enquiry = new Enquiry
            {
                FullName = txtName.Text,
                Email = txtEmail.Text.Trim(),
                Phone = txtPhone.Text.Trim(),
                Subject = ddlSubject.SelectedValue,
                Message = txtMessage.Text.Trim(),
                Rating = rating,
                PreferredCallDate = callDate
            };

            AppData.AddEnquiry(enquiry);

            pnlResult.Visible = true;
            pnlResult.CssClass = "form-alert success";
            litResult.Text = string.Format(
                "Thanks {0} - enquiry #{1} is with our studio. We will call you on {2}{3}.",
                Server.HtmlEncode(enquiry.FullName),
                enquiry.Id,
                enquiry.PreferredCallDate.ToString("dd MMM yyyy"),
                chkCopy.Checked ? " and a copy has been sent to " + Server.HtmlEncode(enquiry.Email) : string.Empty);

            ClearForm();
            BindEnquiries();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearForm();
            pnlResult.Visible = false;
        }

        private void BindEnquiries()
        {
            var list = AppData.Enquiries.OrderByDescending(x => x.Id).ToList();
            pnlEnquiries.Visible = list.Count > 0;
            rptEnquiries.DataSource = list;
            rptEnquiries.DataBind();
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtRating.Text = string.Empty;
            txtCallDate.Text = string.Empty;
            txtMessage.Text = string.Empty;
            ddlSubject.SelectedIndex = 0;
            chkCopy.Checked = false;
        }
    }
}
