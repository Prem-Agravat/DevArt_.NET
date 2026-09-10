using System.Text.RegularExpressions;

namespace DevArt.Models
{
    /// <summary>
    /// Shared rules used by both the client-side validators (as regex strings on the
    /// .aspx pages) and the server-side CustomValidator handlers, so a request that
    /// bypasses JavaScript is rejected by exactly the same rule.
    /// </summary>
    public static class ValidationRules
    {
        public const string EmailPattern = @"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,10}$";
        public const string IndianMobilePattern = @"^[6-9]\d{9}$";
        public const string PincodePattern = @"^[1-9][0-9]{5}$";
        public const string NamePattern = @"^[A-Za-z][A-Za-z\.\s]{2,49}$";
        public const string PromoPattern = @"^[A-Z0-9]{5,12}$";

        /// <summary>
        /// Strong password: 8-20 chars, at least one upper, one lower, one digit,
        /// one special character and no whitespace.
        /// </summary>
        public static bool IsStrongPassword(string password)
        {
            if (string.IsNullOrEmpty(password)) return false;
            if (password.Length < 8 || password.Length > 20) return false;
            if (Regex.IsMatch(password, @"\s")) return false;
            return Regex.IsMatch(password, "[A-Z]")
                && Regex.IsMatch(password, "[a-z]")
                && Regex.IsMatch(password, "[0-9]")
                && Regex.IsMatch(password, @"[!@#$%^&*()_\-+=\[\]{};:,.?]");
        }

        public static bool IsValidEmail(string email)
        {
            return !string.IsNullOrWhiteSpace(email) && Regex.IsMatch(email.Trim(), EmailPattern);
        }

        public static bool IsValidMobile(string phone)
        {
            return !string.IsNullOrWhiteSpace(phone) && Regex.IsMatch(phone.Trim(), IndianMobilePattern);
        }
    }
}
