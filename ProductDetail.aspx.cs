using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevArt.Models;

namespace DevArt
{
    /// <summary>Item detail with reviews (Figma frame 19).</summary>
    public partial class ProductDetail : Page
    {
        private Product _product;

        private Product Current
        {
            get
            {
                if (_product == null)
                {
                    int id;
                    int.TryParse(Request.QueryString["id"], out id);
                    _product = AppData.FindProduct(id);
                }
                return _product;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Current == null)
            {
                pnlProduct.Visible = false;
                pnlMissing.Visible = true;
                return;
            }

            BindProduct();

            if (!IsPostBack)
            {
                UserAccount user = Session["CurrentUser"] as UserAccount;
                if (user != null) txtReviewer.Text = user.FullName;

                BindReviews();
            }
        }

        private void BindProduct()
        {
            Product p = Current;

            litCrumbName.Text = Server.HtmlEncode(p.Name);
            lnkCategory.Text = Server.HtmlEncode(p.Category);
            lnkCategory.NavigateUrl = "Collection.aspx?category=" + Server.UrlEncode(p.Category);

            imgProduct.ImageUrl = "~/Images/" + p.Image;
            imgProduct.AlternateText = p.Name;

            litKicker.Text = Server.HtmlEncode(p.Material);
            litName.Text = Server.HtmlEncode(p.Name);
            litPrice.Text = p.Price.ToString("N2");
            litDescription.Text = Server.HtmlEncode(p.Description);
            litReviewCount.Text = p.ReviewCount.ToString();
            litStars.Text = Stars(p.RatingAverage);

            litStock.Text = p.InStock
                ? p.Stock + " in stock &middot; ships from Rajkot within 2 working days"
                : "<span style=\"color:#c0392b;\">Currently out of stock</span>";

            btnAddToCart.Enabled = p.InStock;
        }

        private static string Stars(double rating)
        {
            int full = (int)Math.Round(rating);
            return new string('★', Math.Max(0, Math.Min(5, full))) +
                   new string('☆', Math.Max(0, 5 - full));
        }

        private void BindReviews()
        {
            List<Review> reviews = AppData.ReviewsFor(Current.Id);
            rptReviews.DataSource = reviews;
            rptReviews.DataBind();
            pnlNoReviews.Visible = reviews.Count == 0;
        }

        // ------------------------------------------------- server-side validators

        /// <summary>Quantity may not exceed what is actually on the shelf.</summary>
        protected void cvStock_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int quantity;
            if (!int.TryParse((args.Value ?? string.Empty).Trim(), out quantity))
            {
                args.IsValid = true;   // the RangeValidator already reports this
                return;
            }

            args.IsValid = Current != null && quantity <= Current.Stock;
        }

        protected void cvReviewBody_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string text = (args.Value ?? string.Empty).Trim();
            int words = text.Length == 0
                ? 0
                : text.Split(new[] { ' ', '\t', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries).Length;

            args.IsValid = words >= 5 && text.Length <= 400;
        }

        // --------------------------------------------------------------- actions

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Page.Validate("Buy");
            if (!Page.IsValid) return;

            int quantity = int.Parse(txtQuantity.Text.Trim());
            CartService.Add(Current, quantity);

            ShowStatus(quantity + " x " + Server.HtmlEncode(Current.Name) +
                       " added to your cart. <a href=\"Cart.aspx\" style=\"text-decoration:underline;\">View cart</a>", true);
        }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            bool added = CartService.AddToWishlist(Current.Id);
            ShowStatus(added
                    ? Server.HtmlEncode(Current.Name) + " saved to your wishlist."
                    : Server.HtmlEncode(Current.Name) + " is already on your wishlist.",
                added);
        }

        protected void btnPostReview_Click(object sender, EventArgs e)
        {
            Page.Validate("Review");
            if (!Page.IsValid) return;

            AppData.AddReview(new Review
            {
                ProductId = Current.Id,
                Author = txtReviewer.Text.Trim(),
                Title = txtReviewTitle.Text.Trim(),
                Body = txtReviewBody.Text.Trim(),
                Rating = int.Parse(txtRating.Text.Trim()),
                PostedOn = DateTime.Today
            });

            txtReviewTitle.Text = string.Empty;
            txtReviewBody.Text = string.Empty;
            txtRating.Text = string.Empty;

            pnlReviewDone.Visible = true;
            BindProduct();
            BindReviews();
        }

        private void ShowStatus(string text, bool success)
        {
            pnlStatus.Visible = true;
            pnlStatus.CssClass = success ? "form-alert success" : "form-alert error";
            litStatus.Text = text;
        }
    }
}
