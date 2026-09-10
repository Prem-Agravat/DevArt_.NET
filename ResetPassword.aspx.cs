using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Step 3 of password recovery (Figma frame 5).</summary>
    public partial class ResetPassword : Page
    {
        private string ResetEmail
        {
            get { return Session["ResetEmail"] as string; }
        }

        private UserAccount TargetUser
        {
            get { return AppData.FindUserByEmail(ResetEmail); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            bool verified = Session["OtpVerified"] is bool && (bool)Session["OtpVerified"];

            // This screen is only reachable once the OTP step has passed.
            if (!verified || string.IsNullOrEmpty(ResetEmail))
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
            if (user == null)
            {
                string email = ResetEmail;
                string defaultName = email.Contains("@") ? email.Split('@')[0] : email;
                user = new UserAccount
                {
                    Email = email,
                    FullName = defaultName,
                    Password = txtNewPassword.Text,
                    Phone = "",
                    CreatedOn = DateTime.Now
                };
                AppData.AddUser(user);
            }
            else
            {
                user.Password = txtNewPassword.Text;
            }

            // Close the recovery window behind us.
            Session.Remove("ResetEmail");
            Session.Remove("OtpVerified");
            Session.Remove("OtpSentAt");

            Session["AuthFlash"] = "Password updated successfully. Sign in with your new password.";
            Response.Redirect("Login.aspx", false);
        }
    }
}
