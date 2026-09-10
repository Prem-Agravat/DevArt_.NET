using System;

namespace DevArt.Models
{
    /// <summary>
    /// Abstract base for every human entity on the DevArt site.
    /// Demonstrates abstraction + encapsulation (CE545 - Section I, Unit 2/3).
    /// </summary>
    public abstract class Person
    {
        private string _fullName;

        protected Person()
        {
            CreatedOn = DateTime.Now;
        }

        public int Id { get; set; }

        public string FullName
        {
            get { return _fullName; }
            set { _fullName = string.IsNullOrWhiteSpace(value) ? string.Empty : value.Trim(); }
        }

        public string Email { get; set; }

        public string Phone { get; set; }

        public DateTime CreatedOn { get; set; }

        /// <summary>Every derived type must declare what it is.</summary>
        public abstract string Role { get; }

        /// <summary>Overridden by derived types - runtime polymorphism.</summary>
        public virtual string GetDisplayName()
        {
            return string.IsNullOrEmpty(FullName) ? Email : FullName;
        }

        public override string ToString()
        {
            return string.Format("{0} ({1})", GetDisplayName(), Role);
        }
    }
}
