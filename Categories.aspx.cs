using System;
using System.Linq;
using System.Web.UI;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Category landing page (Figma frame 10).</summary>
    public partial class Categories : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // LINQ grouping over the product collection builds the tiles - no hard-coded list.
            var tiles = AppData.Products
                .GroupBy(p => p.Category)
                .Select(g => new
                {
                    Name = g.Key,
                    Count = g.Count(),
                    Image = g.First().Image
                })
                .OrderBy(t => t.Name)
                .ToList();

            rptCategories.DataSource = tiles;
            rptCategories.DataBind();

            rptNew.DataSource = AppData.Products.Where(p => p.IsNew).Take(4).ToList();
            rptNew.DataBind();
        }
    }
}
