using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Step 3 of password recovery (Figma frame 5).</summary>
    public partial class ResetPassword : Page
    {
        private UserAccount TargetUser
        {
            get { return AppData.FindUserByEmail(Session["ResetEmail"] as string); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            bool verified = Session["OtpVerified"] is bool && (bool)Session["OtpVerified"];

            // This screen is only reachable once the OTP step has passed.
            if (!verified || TargetUser == null)
            {
                Response.Redirect("ForgotPassword.aspx", false);
            }
        }

        protected void cvStrength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = ValidationRules.IsStrongPassword(args.Value);
        }

        protected void cvNotReused_ServerValidate(object source, ServerValidateEventArgs args)
        {
            UserAccount user = TargetUser;
            args.IsValid = user == null || user.Password != args.Value;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Page.Validate("Reset");
            if (!Page.IsValid) return;

            UserAccount user = TargetUser;
            user.Password = txtNewPassword.Text;

            // Close the recovery window behind us.
            Session.Remove("ResetEmail");
            Session.Remove("OtpVerified");
            Session.Remove("OtpSentAt");

            Session["AuthFlash"] = "Password updated successfully. Sign in with your new password.";
            Response.Redirect("Login.aspx", false);
        }
    }
}
