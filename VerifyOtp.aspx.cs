using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Step 2 of password recovery.</summary>
    public partial class VerifyOtp : Page
    {
        private const int OtpValidMinutes = 5;

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

            bool emailSent = Session["OtpEmailSent"] is bool && (bool)Session["OtpEmailSent"];

            if (emailSent)
            {
                pnlMessage.CssClass = "form-alert success";
                litMessage.Text = "An OTP code has been sent to your email (expires in 5 minutes).";
            }
            else
            {
                pnlMessage.CssClass = "form-alert danger";
                string err = Session["OtpEmailError"] as string;
                litMessage.Text = "Could not send OTP email" + (!string.IsNullOrEmpty(err) ? ": " + Server.HtmlEncode(err) : ". Please try again.");
            }
        }

        /// <summary>The code must match the one issued and still be inside its 5-minute window.</summary>
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
            string email = ResetEmail;
            if (string.IsNullOrEmpty(email))
            {
                Response.Redirect("ForgotPassword.aspx", false);
                return;
            }

            string otp = ForgotPassword.GenerateOtp();
            Session["ResetOtp"] = otp;
            Session["OtpSentAt"] = DateTime.Now;
            txtOtp.Text = string.Empty;

            string mailErr;
            bool sent = EmailService.SendOtpEmail(email, otp, 5, out mailErr);
            Session["OtpEmailSent"] = sent;
            Session["OtpEmailError"] = mailErr;

            ShowSentNotice();
        }
    }
}
