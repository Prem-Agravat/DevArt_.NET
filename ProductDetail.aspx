<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="DevArt.ProductDetail" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Item Detail</asp:Content>

<asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        // Client-side half of cvReviewBody; ProductDetail.aspx.cs re-checks it in C#.
        function validateReviewBody(sender, args) {
            var text = (args.Value || "").trim();
            var words = text.length === 0 ? 0 : text.split(/\s+/).length;
            args.IsValid = words >= 5 && text.length <= 400;
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">

        <asp:Panel ID="pnlMissing" runat="server" Visible="false" CssClass="empty-state">
            That piece is no longer in the catalogue. <a href="Collection.aspx" style="color:#5069a6;">Back to the collection</a>.
        </asp:Panel>

        <asp:Panel ID="pnlProduct" runat="server">

            <p class="breadcrumb">
                <a href="Collection.aspx">Our Collection</a> &nbsp;/&nbsp;
                <asp:HyperLink ID="lnkCategory" runat="server" /> &nbsp;/&nbsp;
                <asp:Literal ID="litCrumbName" runat="server" />
            </p>

            <asp:Panel ID="pnlStatus" runat="server" Visible="false">
                <asp:Literal ID="litStatus" runat="server" />
            </asp:Panel>

            <div class="detail-split">
                <div class="detail-image">
                    <asp:Image ID="imgProduct" runat="server" />
                </div>

                <div>
                    <span class="product-card kicker" style="border:none;padding:0;background:none;font-size:11px;letter-spacing:0.1em;text-transform:uppercase;color:#a0a0a0;">
                        <asp:Literal ID="litKicker" runat="server" />
                    </span>
                    <h1 class="page-title" style="margin-top:6px;"><asp:Literal ID="litName" runat="server" /></h1>

                    <p style="margin:0;">
                        <span class="stars"><asp:Literal ID="litStars" runat="server" /></span>
                        <span style="font-size:12px;color:#8c8c8c;">(<asp:Literal ID="litReviewCount" runat="server" /> Reviews)</span>
                    </p>

                    <div class="detail-price">&#8377;<asp:Literal ID="litPrice" runat="server" /></div>

                    <p style="font-size:13.5px;line-height:1.8;color:#5a5a5a;">
                        <asp:Literal ID="litDescription" runat="server" />
                    </p>

                    <div class="trust-grid">
                        <div>Organic Cotton</div>
                        <div>Eco-friendly Box</div>
                        <div>Artisan Crafted</div>
                        <div>Ethical Production</div>
                    </div>

                    <asp:ValidationSummary ID="vsBuy" runat="server"
                        ValidationGroup="Buy" CssClass="validation-summary"
                        HeaderText="This item could not be added:" DisplayMode="BulletList" />

                    <div class="qty-control">
                        <div class="form-field" style="gap:4px;">
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-input" MaxLength="2" Text="1" />
                            <asp:RequiredFieldValidator ID="rfvQuantity" runat="server"
                                ControlToValidate="txtQuantity" ValidationGroup="Buy"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Quantity is required."
                                Text="Quantity is required." />
                            <%-- Integer range also rejects "two", "2.5" and negatives. --%>
                            <asp:RangeValidator ID="rngQuantity" runat="server"
                                ControlToValidate="txtQuantity" ValidationGroup="Buy"
                                Type="Integer" MinimumValue="1" MaximumValue="10"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Quantity must be a whole number from 1 to 10 per order."
                                Text="Quantity must be 1-10." />
                            <%-- Cannot order more than the artisan has on the shelf. --%>
                            <asp:CustomValidator ID="cvStock" runat="server"
                                ControlToValidate="txtQuantity" ValidationGroup="Buy"
                                CssClass="field-error" Display="Dynamic"
                                OnServerValidate="cvStock_ServerValidate"
                                ErrorMessage="We do not have that many in stock right now."
                                Text="More than we have in stock." />
                        </div>

                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart"
                            CssClass="newsletter-btn" ValidationGroup="Buy" OnClick="btnAddToCart_Click" />
                        <asp:Button ID="btnWishlist" runat="server" Text="Save to Wishlist"
                            CssClass="btn-outline" CausesValidation="false" OnClick="btnWishlist_Click" />
                    </div>

                    <p style="font-size:12px;color:#8c8c8c;margin-top:14px;">
                        <asp:Literal ID="litStock" runat="server" />
                    </p>
                </div>
            </div>

            <h2 class="section-heading">Customer Reviews</h2>

            <div class="review-grid">
                <asp:Repeater ID="rptReviews" runat="server">
                    <ItemTemplate>
                        <div class="review-card">
                            <div class="when"><%# Eval("Ago") %></div>
                            <h4>&ldquo;<%# Server.HtmlEncode(Convert.ToString(Eval("Title"))) %>&rdquo;</h4>
                            <p><%# Server.HtmlEncode(Convert.ToString(Eval("Body"))) %></p>
                            <div class="who"><%# Server.HtmlEncode(Convert.ToString(Eval("Author"))) %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlNoReviews" runat="server" Visible="false" CssClass="empty-state">
                No reviews yet - be the first to write one.
            </asp:Panel>

            <div class="panel" style="margin-top:26px; max-width:720px;">
                <h3>Write a review</h3>
                <p class="panel-hint">Tell other collectors what arrived and how it felt.</p>

                <asp:Panel ID="pnlReviewDone" runat="server" Visible="false" CssClass="form-alert success">
                    Thank you - your review is now live on this piece.
                </asp:Panel>

                <asp:ValidationSummary ID="vsReview" runat="server"
                    ValidationGroup="Review" CssClass="validation-summary"
                    HeaderText="Your review could not be posted:" DisplayMode="BulletList" />

                <div class="form-grid">
                    <div class="form-field">
                        <label>Your Name<span class="req">*</span></label>
                        <asp:TextBox ID="txtReviewer" runat="server" CssClass="form-input" placeholder="Full name" />
                        <asp:RequiredFieldValidator ID="rfvReviewer" runat="server"
                            ControlToValidate="txtReviewer" ValidationGroup="Review"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Your name is required."
                            Text="Your name is required." />
                        <asp:RegularExpressionValidator ID="revReviewer" runat="server"
                            ControlToValidate="txtReviewer" ValidationGroup="Review"
                            CssClass="field-error" Display="Dynamic"
                            ValidationExpression="^[A-Za-z][A-Za-z\.\s]{2,49}$"
                            ErrorMessage="Reviewer name must be 3-50 letters."
                            Text="Name must be 3-50 letters." />
                    </div>

                    <div class="form-field">
                        <label>Rating (1-5)<span class="req">*</span></label>
                        <asp:TextBox ID="txtRating" runat="server" CssClass="form-input" MaxLength="1" placeholder="5" />
                        <asp:RequiredFieldValidator ID="rfvRating" runat="server"
                            ControlToValidate="txtRating" ValidationGroup="Review"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="A rating is required."
                            Text="A rating is required." />
                        <asp:RangeValidator ID="rngRating" runat="server"
                            ControlToValidate="txtRating" ValidationGroup="Review"
                            Type="Integer" MinimumValue="1" MaximumValue="5"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Rating must be a whole number from 1 to 5."
                            Text="Rating must be 1-5." />
                    </div>

                    <div class="form-field full">
                        <label>Headline<span class="req">*</span></label>
                        <asp:TextBox ID="txtReviewTitle" runat="server" CssClass="form-input" MaxLength="60" placeholder="Stunning piece!" />
                        <asp:RequiredFieldValidator ID="rfvReviewTitle" runat="server"
                            ControlToValidate="txtReviewTitle" ValidationGroup="Review"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="A headline is required."
                            Text="A headline is required." />
                    </div>

                    <div class="form-field full">
                        <label>Your Review<span class="req">*</span></label>
                        <asp:TextBox ID="txtReviewBody" runat="server" CssClass="form-input"
                            TextMode="MultiLine" Rows="4" placeholder="What did you think of the craftsmanship?" />
                        <asp:RequiredFieldValidator ID="rfvReviewBody" runat="server"
                            ControlToValidate="txtReviewBody" ValidationGroup="Review"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Please write your review."
                            Text="Please write your review." />
                        <asp:CustomValidator ID="cvReviewBody" runat="server"
                            ControlToValidate="txtReviewBody" ValidationGroup="Review"
                            CssClass="field-error" Display="Dynamic"
                            ClientValidationFunction="validateReviewBody"
                            OnServerValidate="cvReviewBody_ServerValidate"
                            ErrorMessage="A review needs at least 5 words and must stay under 400 characters."
                            Text="Write at least 5 words." />
                    </div>
                </div>

                <div class="form-actions">
                    <asp:Button ID="btnPostReview" runat="server" Text="Post Review"
                        CssClass="newsletter-btn" ValidationGroup="Review" OnClick="btnPostReview_Click" />
                </div>
            </div>
        </asp:Panel>
    </main>

</asp:Content>
