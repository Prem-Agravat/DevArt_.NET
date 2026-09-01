using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Checkout step 2 - delivery address (Figma frame 13).</summary>
    public partial class Shipping : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserAccount user = Session["CurrentUser"] as UserAccount;

            // Guard: no customer, or nothing to ship.
            if (user == null)
            {
                Response.Redirect("Login.aspx?returnUrl=Shipping.aspx", false);
                return;
            }

            if (CartService.Items.Count == 0)
            {
                Response.Redirect("Cart.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                BindAddresses(user);
                BindSummary();
            }
        }

        private void BindAddresses(UserAccount user)
        {
            var rows = AppData.AddressesFor(user.Email)
                .Select(a => new
                {
                    a.Id,
                    Display = a.FullName + " - " + a.OneLine + " (" + a.Label + ")"
                })
                .ToList();

            rblAddresses.DataSource = rows;
            rblAddresses.DataBind();

            int chosen = Session[CartService.ShipToKey] is int ? (int)Session[CartService.ShipToKey] : 0;
            ListItem preselect = chosen > 0 ? rblAddresses.Items.FindByValue(chosen.ToString()) : null;
            if (preselect != null)
            {
                preselect.Selected = true;
            }
            else if (rblAddresses.Items.Count == 1)
            {
                rblAddresses.Items[0].Selected = true;
            }
        }

        private void BindSummary()
        {
            rptLines.DataSource = CartService.Items;
            rptLines.DataBind();

            litSubTotal.Text = CartService.SubTotal.ToString("N0");

            decimal discount = CartService.Discount;
            pnlDiscount.Visible = discount > 0;
            litDiscount.Text = discount.ToString("N0");

            decimal shipping = CartService.Shipping;
            litShipping.Text = shipping == 0m ? "Free" : "₹" + shipping.ToString("N0");
            litTotal.Text = CartService.Total.ToString("N0");
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            Page.Validate("Ship");
            if (!Page.IsValid) return;

            Session[CartService.ShipToKey] = int.Parse(rblAddresses.SelectedValue);
            Response.Redirect("Payment.aspx", false);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx", false);
        }
    }
}
