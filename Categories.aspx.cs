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

            if (AppData.Products == null) return;

            // LINQ grouping over the product collection builds the tiles - no hard-coded list.
            var tiles = AppData.Products
                .Where(p => p != null && !string.IsNullOrEmpty(p.Category))
                .GroupBy(p => p.Category)
                .Select(g => new
                {
                    Name = g.Key,
                    Count = g.Count(),
                    Image = g.FirstOrDefault()?.Image ?? ""
                })
                .OrderBy(t => t.Name)
                .ToList();

            if (rptCategories != null)
            {
                rptCategories.DataSource = tiles;
                rptCategories.DataBind();
            }
        }
    }
}
