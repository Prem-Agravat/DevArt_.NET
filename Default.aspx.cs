using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>
    /// Code-behind for the Home page (Default.aspx).
    /// Handles the newsletter subscription form in the footer.
    /// Subscriber emails live in Application state so they persist across all
    /// user sessions for the lifetime of the web app process.
    /// </summary>
    public partial class _Default : Page
    {
        // Key used to read and write the subscriber list in Application state.
        // A constant prevents accidental typos when accessing the same slot.
        private const string SubscribersKey = "NewsletterSubscribers";

        /// <summary>
        /// Newsletter subscribers are shared by every visitor, so they live in
        /// Application state rather than Session (state management, Unit 8).
        /// </summary>
        private List<string> Subscribers
        {
            get
            {
                // Try to fetch an already-initialised list from Application state
                List<string> list = Application[SubscribersKey] as List<string>;
                if (list == null)
                {
                    // Lock so two simultaneous requests don't both create a new list
                    Application.Lock();
                    try
                    {
                        // Double-check inside the lock; another thread may have just created it
                        list = Application[SubscribersKey] as List<string> ?? new List<string>();
                        Application[SubscribersKey] = list;
                    }
                    finally
                    {
                        // Always unlock, even if an exception is thrown
                        Application.UnLock();
                    }
                }
                return list;
            }
        }

        // Page_Load is intentionally empty — the home page renders purely from markup.
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// Server-side validator: rejects an email that is already in the subscriber list.
        /// This fires after the RegularExpressionValidator checks the format, so here
        /// we only need to check for duplicates.
        /// </summary>
        protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = (args.Value ?? string.Empty).Trim();
            // IsValid = true means the email is NOT already subscribed
            args.IsValid = !Subscribers.Any(s => string.Equals(s, email, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>
        /// Handles the Subscribe button click.
        /// Validates the newsletter form, then safely adds the email to the
        /// Application-state subscriber list and shows a thank-you message.
        /// </summary>
        protected void btnSubscribe_Click(object sender, EventArgs e)
        {
            // Run all validators tagged "Newsletter" before doing anything
            Page.Validate("Newsletter");
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();

            // Defence in depth: re-check the email format on the server even though
            // the RegularExpressionValidator already does this client-side
            if (!ValidationRules.IsValidEmail(email)) return;

            // Add the email to the shared list, locking to prevent race conditions
            Application.Lock();
            try
            {
                Subscribers.Add(email);
            }
            finally
            {
                Application.UnLock();
            }

            // Clear the input and show the success message with the subscriber's email
            txtEmail.Text = string.Empty;
            pnlSubscribed.Visible = true;
            litSubscribed.Text = "Thanks for subscribing - your 10% welcome code is on its way to " +
                                 Server.HtmlEncode(email) + ".";
        }
    }
}
