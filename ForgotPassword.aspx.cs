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
            args.IsValid = AppData.FindUserByEmail(args.Value) != null;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.Validate("Forgot");
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();

            // A real build would mail this; the demo keeps it in Session and shows it
            // on the next screen so the flow can be walked through end to end.
            string otp = new Random(email.GetHashCode() ^ DateTime.Now.Millisecond)
                .Next(1000, 10000)
                .ToString();

            Session["ResetEmail"] = email;
            Session["ResetOtp"] = otp;
            Session["OtpSentAt"] = DateTime.Now;

            Response.Redirect("VerifyOtp.aspx", false);
        }
    }
}
