using System;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Step 1 of password recovery.</summary>
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Clear any leftover verified flag from previous reset sessions
                Session.Remove("OtpVerified");
            }
        }

        protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Allow sending OTP to any email entered
            args.IsValid = true;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.Validate("Forgot");
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();
            string otp = GenerateOtp();

            Session["ResetEmail"] = email;
            Session["ResetOtp"] = otp;
            Session["OtpSentAt"] = DateTime.Now;
            Session.Remove("OtpVerified");

            string mailErr;
            bool sent = EmailService.SendOtpEmail(email, otp, 5, out mailErr);
            Session["OtpEmailSent"] = sent;
            Session["OtpEmailError"] = mailErr;

            Response.Redirect("VerifyOtp.aspx", false);
        }

        public static string GenerateOtp()
        {
            byte[] bytes = new byte[4];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(bytes);
            }
            int value = Math.Abs(BitConverter.ToInt32(bytes, 0)) % 9000 + 1000;
            return value.ToString();
        }
    }
}
