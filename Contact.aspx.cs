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
            cmpCallDate.ValueToCompare = DateTime.Today.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

            if (!IsPostBack)
            {
                UserAccount user = Session["CurrentUser"] as UserAccount;
                if (user != null)
                {
                    txtName.Text = user.FullName;
                    txtEmail.Text = user.Email;
                    txtPhone.Text = user.Phone;
                }

                if (string.IsNullOrEmpty(txtRating.Text)) txtRating.Text = "5";
                if (string.IsNullOrEmpty(txtCallDate.Text)) txtCallDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                BindEnquiries();
            }
        }

        protected void cvMessage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string text = (args.Value ?? string.Empty).Trim();
            int words = text.Length == 0
                ? 0
                : text.Split(new[] { ' ', '\t', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries).Length;

            args.IsValid = words >= 1 && text.Length <= 500;
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            Page.Validate("Contact");
            if (!Page.IsValid) return;

            int rating;
            if (!int.TryParse(txtRating.Text.Trim(), out rating)) rating = 5;

            DateTime callDate;
            if (!DateTime.TryParse(txtCallDate.Text, out callDate)) callDate = DateTime.Today;

            Enquiry enquiry = new Enquiry
            {
                FullName = txtName.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                Phone = string.IsNullOrEmpty(txtPhone.Text) ? "9876543210" : txtPhone.Text.Trim(),
                Subject = string.IsNullOrEmpty(ddlSubject.SelectedValue) ? "General Inquiry" : ddlSubject.SelectedValue,
                Message = txtMessage.Text.Trim(),
                Rating = rating,
                PreferredCallDate = callDate
            };

            AppData.AddEnquiry(enquiry);

            pnlResult.Visible = true;
            pnlResult.CssClass = "form-alert success";
            litResult.Text = string.Format(
                "Thanks {0} - your message has been sent to our studio! We will reply within 1 working day.",
                Server.HtmlEncode(enquiry.FullName));

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
            txtPhone.Text = "9876543210";
            txtRating.Text = "5";
            txtCallDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            txtMessage.Text = string.Empty;
            ddlSubject.SelectedIndex = 0;
            chkCopy.Checked = false;
        }
    }
}
