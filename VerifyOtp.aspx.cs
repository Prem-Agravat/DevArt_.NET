using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DevArt
{
    /// <summary>Step 2 of password recovery (Figma frame 4).</summary>
    public partial class VerifyOtp : Page
    {
        private const int OtpValidMinutes = 10;

        private string ResetEmail
        {
            get { return Session["ResetEmail"] as string; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // No email in Session means the visitor jumped straight here.
            if (string.IsNullOrEmpty(ResetEmail))
            {
                Response.Redirect("ForgotPassword.aspx", false);
                return;
            }

            litEmail.Text = Server.HtmlEncode(ResetEmail);

            if (!IsPostBack)
            {
                ShowSentNotice();
            }
        }

        private void ShowSentNotice()
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = "form-alert success";
            litMessage.Text = "OTP sent - please check your email. " +
                              "<em>Demo build: your code is <strong>" +
                              Server.HtmlEncode(Session["ResetOtp"] as string) + "</strong>.</em>";
        }

        /// <summary>The code must match the one issued and still be inside its window.</summary>
        protected void cvOtp_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string issued = Session["ResetOtp"] as string;
            DateTime? sentAt = Session["OtpSentAt"] as DateTime?;

            args.IsValid =
                !string.IsNullOrEmpty(issued) &&
                sentAt.HasValue &&
                DateTime.Now.Subtract(sentAt.Value).TotalMinutes <= OtpValidMinutes &&
                string.Equals(issued, (args.Value ?? string.Empty).Trim(), StringComparison.Ordinal);
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            Page.Validate("Otp");
            if (!Page.IsValid) return;

            // The code is single-use: burn it and mark the reset as authorised.
            Session.Remove("ResetOtp");
            Session["OtpVerified"] = true;

            Response.Redirect("ResetPassword.aspx", false);
        }

        protected void btnResend_Click(object sender, EventArgs e)
        {
            string otp = new Random(DateTime.Now.Millisecond).Next(1000, 10000).ToString();
            Session["ResetOtp"] = otp;
            Session["OtpSentAt"] = DateTime.Now;
            txtOtp.Text = string.Empty;
            ShowSentNotice();
        }
    }
}
