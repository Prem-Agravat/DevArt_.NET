using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    public partial class _Default : Page
    {
        private const string SubscribersKey = "NewsletterSubscribers";

        /// <summary>
        /// Newsletter subscribers are shared by every visitor, so they live in
        /// Application state rather than Session (state management, Unit 8).
        /// </summary>
        private List<string> Subscribers
        {
            get
            {
                List<string> list = Application[SubscribersKey] as List<string>;
                if (list == null)
                {
                    Application.Lock();
                    try
                    {
                        list = Application[SubscribersKey] as List<string> ?? new List<string>();
                        Application[SubscribersKey] = list;
                    }
                    finally
                    {
                        Application.UnLock();
                    }
                }
                return list;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>Rejects an address that has already subscribed.</summary>
        protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = (args.Value ?? string.Empty).Trim();
            args.IsValid = !Subscribers.Any(s => string.Equals(s, email, StringComparison.OrdinalIgnoreCase));
        }

        protected void btnSubscribe_Click(object sender, EventArgs e)
        {
            Page.Validate("Newsletter");
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();

            // Defence in depth: the same rule the RegularExpressionValidator applies.
            if (!ValidationRules.IsValidEmail(email)) return;

            Application.Lock();
            try
            {
                Subscribers.Add(email);
            }
            finally
            {
                Application.UnLock();
            }

            txtEmail.Text = string.Empty;
            pnlSubscribed.Visible = true;
            litSubscribed.Text = "Thanks for subscribing - your 10% welcome code is on its way to " +
                                 Server.HtmlEncode(email) + ".";
        }
    }
}
