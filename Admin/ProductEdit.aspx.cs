using System;
using System.Web.UI;

namespace DevArt.Admin
{
    /// <summary>
    /// Legacy Add / Edit page redirector to Inventory.aspx popup modal.
    /// </summary>
    public partial class ProductEdit : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            int.TryParse(Request.QueryString["id"], out id);
            if (id > 0)
            {
                Response.Redirect("Inventory.aspx?editId=" + id, false);
            }
            else
            {
                Response.Redirect("Inventory.aspx?action=add", false);
            }
        }
    }
}

