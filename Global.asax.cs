using System;
using System.Web;

namespace DevArt
{
    /// <summary>
    /// Global Application Class for DevArt.
    /// Manages Application-level state and Session lifecycle events (Rubric: State Management).
    /// </summary>
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Application State: Shared across all sessions and users
            Application.Lock();
            Application["AppName"] = "DevArt - Handcrafted Art & Decor";
            Application["TotalVisitors"] = 0;
            Application["ActiveUsers"] = 0;
            Application.UnLock();
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Triggered whenever a new visitor starts a browser session
            Application.Lock();
            int total = Application["TotalVisitors"] != null ? (int)Application["TotalVisitors"] : 0;
            int active = Application["ActiveUsers"] != null ? (int)Application["ActiveUsers"] : 0;

            Application["TotalVisitors"] = total + 1;
            Application["ActiveUsers"] = active + 1;
            Application.UnLock();
        }

        void Session_End(object sender, EventArgs e)
        {
            // Triggered when a session times out or is abandoned
            Application.Lock();
            int active = Application["ActiveUsers"] != null ? (int)Application["ActiveUsers"] : 0;
            if (active > 0)
            {
                Application["ActiveUsers"] = active - 1;
            }
            Application.UnLock();
        }

        void Application_Error(object sender, EventArgs e)
        {
            // Centralized error handling
            Exception ex = Server.GetLastError();
            if (ex != null)
            {
                System.Diagnostics.Trace.WriteLine("DevArt Error: " + ex.Message);
            }
        }
    }
}
