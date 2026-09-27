using System;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace DevArt.Models
{
    public static class EmailService
    {
        /// <summary>
        /// Sends a 4-digit OTP verification email to the specified recipient.
        /// Reads SMTP credentials from Web.config appSettings if available.
        /// Returns (success, errorMessage).
        /// </summary>
        public static bool SendOtpEmail(string recipientEmail, string otpCode, int expiryMinutes, out string errorMessage)
        {
            errorMessage = string.Empty;

            try
            {
                // Force TLS 1.2 for modern SMTP providers like Gmail/Outlook
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls;

                string smtpHost = ConfigurationManager.AppSettings["SmtpHost"] ?? "smtp.gmail.com";
                int smtpPort = 587;
                int.TryParse(ConfigurationManager.AppSettings["SmtpPort"] ?? "587", out smtpPort);
                string smtpUsername = ConfigurationManager.AppSettings["SmtpUsername"] ?? string.Empty;
                string smtpPassword = ConfigurationManager.AppSettings["SmtpPassword"] ?? string.Empty;
                string smtpFrom = ConfigurationManager.AppSettings["SmtpFrom"] ?? "noreply@devart.com";
                bool enableSsl = true;
                bool.TryParse(ConfigurationManager.AppSettings["SmtpEnableSsl"] ?? "true", out enableSsl);

                string subject = "DevArt - Your Password Reset Verification Code";
                string body = string.Format(@"
                    <div style=""font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 8px; overflow: hidden; background-color: #ffffff;"">
                        <div style=""background-color: #8B5E3C; padding: 20px; text-align: center; color: #ffffff;"">
                            <h1 style=""margin: 0; font-size: 24px;"">DevArt</h1>
                            <p style=""margin: 5px 0 0 0; font-size: 14px; opacity: 0.9;"">Password Reset Request</p>
                        </div>
                        <div style=""padding: 25px; color: #333333;"">
                            <p>Hello,</p>
                            <p>We received a request to reset your password for your DevArt account (<strong>{0}</strong>).</p>
                            <p>Use the following 4-digit verification code to complete your reset:</p>
                            <div style=""text-align: center; margin: 25px 0;"">
                                <span style=""display: inline-block; background-color: #F8F9FA; border: 2px dashed #8B5E3C; font-size: 32px; font-weight: bold; letter-spacing: 10px; color: #8B5E3C; padding: 12px 24px; border-radius: 6px;"">{1}</span>
                            </div>
                            <p style=""color: #d9534f; font-weight: bold; text-align: center;"">⚠️ Note: This code will expire in {2} minutes.</p>
                            <p style=""font-size: 13px; color: #777777; margin-top: 20px;"">If you did not request a password reset, please ignore this email or contact support.</p>
                        </div>
                        <div style=""background-color: #f8f9fa; padding: 15px; text-align: center; font-size: 12px; color: #888888; border-top: 1px solid #eeeeee;"">
                            &copy; DevArt Handicraft Store. All rights reserved.
                        </div>
                    </div>",
                    WebUtility.HtmlEncode(recipientEmail),
                    WebUtility.HtmlEncode(otpCode),
                    expiryMinutes);

                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(smtpFrom, "DevArt Store");
                    mail.To.Add(recipientEmail);
                    mail.Subject = subject;
                    mail.Body = body;
                    mail.IsBodyHtml = true;

                    using (SmtpClient client = new SmtpClient(smtpHost, smtpPort))
                    {
                        client.UseDefaultCredentials = false;
                        if (!string.IsNullOrEmpty(smtpUsername) && !string.IsNullOrEmpty(smtpPassword))
                        {
                            client.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                        }
                        client.EnableSsl = enableSsl;
                        client.DeliveryMethod = SmtpDeliveryMethod.Network;
                        client.Timeout = 15000;

                        client.Send(mail);
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
                return false;
            }
        }
    }
}
