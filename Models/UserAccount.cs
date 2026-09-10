using System;

namespace DevArt.Models
{
    /// <summary>
    /// A registered DevArt customer. Inherits Person and overrides its members.
    /// </summary>
    public class UserAccount : Person
    {
        public string Password { get; set; }

        public string City { get; set; }

        public string Pincode { get; set; }

        public DateTime DateOfBirth { get; set; }

        public bool NewsletterOptIn { get; set; }

        public override string Role
        {
            get { return "Customer"; }
        }

        public int Age
        {
            get
            {
                if (DateOfBirth == DateTime.MinValue) return 0;
                int age = DateTime.Today.Year - DateOfBirth.Year;
                if (DateOfBirth.Date > DateTime.Today.AddYears(-age)) age--;
                return age;
            }
        }

        public override string GetDisplayName()
        {
            return base.GetDisplayName() + (Age > 0 ? ", " + Age : string.Empty);
        }
    }

    /// <summary>
    /// A message left through Contact.aspx. Sealed - no further specialisation.
    /// </summary>
    public sealed class Enquiry : Person
    {
        public string Subject { get; set; }

        public string Message { get; set; }

        public int Rating { get; set; }

        public DateTime PreferredCallDate { get; set; }

        public override string Role
        {
            get { return "Visitor"; }
        }
    }
}
