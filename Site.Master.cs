using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>
    /// Shared shell for every customer-facing page (Syllabus Unit 6 - Master Page).
    /// Holds the header, nav, live cart/wishlist badges, footer, and the
    /// Login/Register modal so no content page has to repeat that markup.
    /// </summary>
    public partial class SiteMaster : MasterPage
    {
        // ---------------------------------------------------------------- session

        /// <summary>The signed-in customer, or null.</summary>
        public UserAccount CurrentUser
        {
            get { return Session["CurrentUser"] as UserAccount; }
        }

        // ---------------------------------------------------------------- page load

        protected void Page_Load(object sender, EventArgs e)
        {
            UserAccount user = CurrentUser;
            if (user != null)
            {
                // Logged-in: show "Hi, Name" -> Profile; hide the modal trigger button
                lnkAuth.Text = "Hi, " + Server.HtmlEncode(user.FullName.Split(' ')[0]);
                lnkAuth.NavigateUrl = "~/Profile.aspx";
                lnkAuth.Visible = true;

                // Hide the open-modal button via JavaScript (it is a plain <button>)
                Page.ClientScript.RegisterStartupScript(GetType(), "hideModalBtn",
                    "var b=document.getElementById('btnOpenAuthModal');if(b)b.style.display='none';", true);
            }
            else
            {
                lnkAuth.Visible = false;
            }

            int cartCount = CartLines.Sum(i => i.Quantity);
            litCartCount.Text = cartCount > 0 ? "<span class=\"badge\">" + cartCount + "</span>" : string.Empty;

            int wishCount = Wishlist.Count;
            litWishCount.Text = wishCount > 0 ? "<span class=\"badge\">" + wishCount + "</span>" : string.Empty;

            // Wire up the terms-checkbox id for the register modal validator
            mrcvTerms.Attributes["data-terms"] = mrchkTerms.ClientID;
        }

        // ---------------------------------------------------------------- nav helper

        /// <summary>Marks the active nav link so the current tab is highlighted.</summary>
        protected string NavClass(string page)
        {
            string current = Path.GetFileNameWithoutExtension(
                Request.AppRelativeCurrentExecutionFilePath ?? string.Empty);
            return string.Equals(current, page, StringComparison.OrdinalIgnoreCase) ? "active" : string.Empty;
        }

        // ---------------------------------------------------------------- session helpers

        private List<CartItem> CartLines
        {
            get { return Session["CartItems"] as List<CartItem> ?? new List<CartItem>(); }
        }

        private List<int> Wishlist
        {
            get { return Session["Wishlist"] as List<int> ?? new List<int>(); }
        }

        // ================================================================ MODAL LOGIN

        /// <summary>Server-side credential check for the modal login form (Customer + Admin).</summary>
        protected void mcvCredentials_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = mtxtEmail.Text.Trim();
            string pass = mtxtPassword.Text;

            // Admin check
            if (string.Equals(email, "admin@devart.com", StringComparison.OrdinalIgnoreCase) && pass == "Admin@123")
            {
                args.IsValid = true;
                return;
            }

            // Customer check
            args.IsValid = AppData.FindUser(email, pass) != null;
        }

        protected void btnModalLogin_Click(object sender, EventArgs e)
        {
            // Store which panel to reopen if the page reloads after a failed post-back
            ViewState["ModalOpenPanel"] = "login";

            Page.Validate("ModalLogin");
            if (!Page.IsValid) return;

            string email = mtxtEmail.Text.Trim();
            string pass = mtxtPassword.Text;

            // Admin login route
            if (string.Equals(email, "admin@devart.com", StringComparison.OrdinalIgnoreCase) && pass == "Admin@123")
            {
                Session["AdminUser"] = email;
                Response.Redirect("~/Admin/Dashboard.aspx", false);
                return;
            }

            // Customer login route
            UserAccount user = AppData.FindUser(email, pass);
            Session["CurrentUser"] = user;
            Session["UserEmail"]   = user.Email;

            if (mchkRemember.Checked)
                Session.Timeout = 120;

            // Panel is no longer needed - clear the flag and stay on the same page
            ViewState["ModalOpenPanel"] = string.Empty;

            // Refresh the page so the header shows "Hi, Name" without navigating away
            Response.Redirect(Request.Url.AbsoluteUri, false);
        }

        // ================================================================ MODAL REGISTER

        protected void mrcvEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !AppData.EmailExists(args.Value);
        }

        protected void mrcvPasswordStrength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = ValidationRules.IsStrongPassword(args.Value);
        }

        protected void mrcvTerms_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = mrchkTerms.Checked;
        }

        protected void btnModalRegister_Click(object sender, EventArgs e)
        {
            ViewState["ModalOpenPanel"] = "register";

            Page.Validate("ModalRegister");
            if (!Page.IsValid) return;

            UserAccount account = new UserAccount
            {
                FullName        = mrtxtName.Text.Trim(),
                Email           = mrtxtEmail.Text.Trim(),
                Password        = mrtxtPassword.Text,
                NewsletterOptIn = true
            };

            AppData.AddUser(account);

            // Auto sign-in after registration
            Session["CurrentUser"] = account;
            Session["UserEmail"]   = account.Email;

            ViewState["ModalOpenPanel"] = string.Empty;

            // Refresh so the header shows "Hi, Name"
            Response.Redirect(Request.Url.AbsoluteUri, false);
        }

        // ================================================================ MODAL FORGOT PASSWORD

        protected void mcvFEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = AppData.FindUserByEmail(args.Value) != null;
        }

        protected void btnModalForgot_Click(object sender, EventArgs e)
        {
            ViewState["ModalOpenPanel"] = "forgot";

            Page.Validate("ModalForgot");
            if (!Page.IsValid) return;

            string email = mfEmail.Text.Trim();

            string otp = new Random(email.GetHashCode() ^ DateTime.Now.Millisecond)
                .Next(1000, 10000)
                .ToString();

            Session["ResetEmail"] = email;
            Session["ResetOtp"] = otp;
            Session["OtpSentAt"] = DateTime.Now;

            ShowOtpSentNotice();
            ViewState["ModalOpenPanel"] = "otp";
        }

        // ================================================================ MODAL VERIFY OTP

        private void ShowOtpSentNotice()
        {
            mlitOtpEmail.Text = Server.HtmlEncode(Session["ResetEmail"] as string);
            mpnlOtpSent.Visible = true;
            mlitOtpMsg.Text = "OTP sent - please check your email. " +
                              "<em>Demo build: your code is <strong>" +
                              Server.HtmlEncode(Session["ResetOtp"] as string) + "</strong>.</em>";
        }

        protected void mcvOtp_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string issued = Session["ResetOtp"] as string;
            DateTime? sentAt = Session["OtpSentAt"] as DateTime?;

            args.IsValid =
                !string.IsNullOrEmpty(issued) &&
                sentAt.HasValue &&
                DateTime.Now.Subtract(sentAt.Value).TotalMinutes <= 10 &&
                string.Equals(issued, (args.Value ?? string.Empty).Trim(), StringComparison.Ordinal);
        }

        protected void btnModalOtp_Click(object sender, EventArgs e)
        {
            ViewState["ModalOpenPanel"] = "otp";

            Page.Validate("ModalOtp");
            if (!Page.IsValid) return;

            // Mark OTP as verified
            Session.Remove("ResetOtp");
            Session["OtpVerified"] = true;

            ViewState["ModalOpenPanel"] = "reset";
        }

        protected void btnModalOtpResend_Click(object sender, EventArgs e)
        {
            string otp = new Random(DateTime.Now.Millisecond).Next(1000, 10000).ToString();
            Session["ResetOtp"] = otp;
            Session["OtpSentAt"] = DateTime.Now;
            moOtp.Text = string.Empty;
            ShowOtpSentNotice();

            ViewState["ModalOpenPanel"] = "otp";
        }

        // ================================================================ MODAL RESET PASSWORD

        private UserAccount TargetResetUser
        {
            get { return AppData.FindUserByEmail(Session["ResetEmail"] as string); }
        }

        protected void mcvRstStrength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = ValidationRules.IsStrongPassword(args.Value);
        }

        protected void mcvRstNotReused_ServerValidate(object source, ServerValidateEventArgs args)
        {
            UserAccount user = TargetResetUser;
            args.IsValid = user == null || user.Password != args.Value;
        }

        protected void btnModalReset_Click(object sender, EventArgs e)
        {
            ViewState["ModalOpenPanel"] = "reset";

            bool verified = Session["OtpVerified"] is bool && (bool)Session["OtpVerified"];
            UserAccount user = TargetResetUser;

            if (!verified || user == null)
            {
                // Safety catch
                ViewState["ModalOpenPanel"] = "forgot";
                return;
            }

            Page.Validate("ModalReset");
            if (!Page.IsValid) return;

            // Update password
            user.Password = mrstPassword.Text;

            // Cleanup session
            Session.Remove("ResetEmail");
            Session.Remove("OtpVerified");
            Session.Remove("OtpSentAt");

            // Auto-login the user
            Session["CurrentUser"] = user;
            Session["UserEmail"] = user.Email;

            ViewState["ModalOpenPanel"] = string.Empty;

            // Refresh the page
            Response.Redirect(Request.Url.AbsoluteUri, false);
        }
    }
}

