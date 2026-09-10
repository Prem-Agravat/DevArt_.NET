using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Step 1 of password recovery (Figma frame 3).</summary>
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Allow sending OTP to any email entered (registered or unregistered)
            args.IsValid = true;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.Validate("Forgot");
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();

            string otp = new Random(email.GetHashCode() ^ DateTime.Now.Millisecond)
                .Next(1000, 10000)
                .ToString();

            Session["ResetEmail"] = email;
            Session["ResetOtp"] = otp;
            Session["OtpSentAt"] = DateTime.Now;

            string mailErr;
            bool sent = EmailService.SendOtpEmail(email, otp, 5, out mailErr);
            Session["OtpEmailSent"] = sent;
            Session["OtpEmailError"] = mailErr;

            Response.Redirect("VerifyOtp.aspx", false);
        }
    }
}
