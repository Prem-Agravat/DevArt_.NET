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

    <main class="item-detail-wrapper">

        <asp:Panel ID="pnlMissing" runat="server" Visible="false" CssClass="prof-empty-card" style="text-align:center;padding:40px;">
            <h3>That piece is no longer in the catalogue.</h3>
            <p><a href="Collection.aspx" style="color:#855335;font-weight:600;">Back to the collection</a></p>
        </asp:Panel>

        <asp:Panel ID="pnlProduct" runat="server">

            <!-- CENTERED PAGE TITLE -->
            <h1 class="item-detail-header-title">Item Detail</h1>

            <!-- BACK ARROW BUTTON -->
            <div class="item-detail-back-row">
                <a href="Collection.aspx" class="item-detail-back-btn" title="Back to Collection">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
            </div>

            <!-- BREADCRUMB (Hidden visually or subtle) -->
            <div style="display:none;">
                <asp:HyperLink ID="lnkCategory" runat="server" />
                <asp:Literal ID="litCrumbName" runat="server" />
                <asp:Literal ID="litKicker" runat="server" />
            </div>

            <asp:Panel ID="pnlStatus" runat="server" Visible="false" style="margin-bottom: 20px;">
                <asp:Literal ID="litStatus" runat="server" />
            </asp:Panel>

            <!-- MAIN PRODUCT SPLIT GRID -->
            <div class="item-detail-grid">

                <!-- LEFT SIDE: PRODUCT GALLERY -->
                <div class="item-detail-gallery">
                    <div class="item-detail-main-img-card">
                        <asp:Image ID="imgProduct" runat="server" CssClass="item-detail-main-img" />
                        
                        <!-- FLOATING WISHLIST HEART BUTTON -->
                        <asp:LinkButton ID="btnWishlist" runat="server" CssClass="item-detail-heart-btn" CausesValidation="false" OnClick="btnWishlist_Click" title="Save to Wishlist">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </asp:LinkButton>
                    </div>

                    <!-- THUMBNAIL PREVIEWS -->
                    <div class="item-detail-thumbs">
                        <img src="<%= imgProduct.ImageUrl %>" class="item-detail-thumb active" onclick="document.getElementById('<%= imgProduct.ClientID %>').src=this.src;" />
                        <img src="<%= imgProduct.ImageUrl %>" class="item-detail-thumb" onclick="document.getElementById('<%= imgProduct.ClientID %>').src=this.src;" />
                        <img src="<%= imgProduct.ImageUrl %>" class="item-detail-thumb" onclick="document.getElementById('<%= imgProduct.ClientID %>').src=this.src;" />
                    </div>

                    <!-- CAROUSEL DOTS -->
                    <div class="item-detail-dots">
                        <span class="dot active"></span>
                        <span class="dot"></span>
                        <span class="dot"></span>
                    </div>
                </div>

                <!-- RIGHT SIDE: PRODUCT SUMMARY & ACTIONS -->
                <div class="item-detail-summary">
                    <!-- BADGE PILL -->
                    <span class="item-detail-badge-pill">Handmade in Jaipur</span>

                    <!-- PRODUCT TITLE -->
                    <h1 class="item-detail-title"><asp:Literal ID="litName" runat="server" /></h1>

                    <!-- RATING & REVIEWS -->
                    <div class="item-detail-rating-row">
                        <span class="stars" style="color:#855335;letter-spacing:2px;font-size:16px;"><asp:Literal ID="litStars" runat="server" /></span>
                        <div class="review-subtext">(<asp:Literal ID="litReviewCount" runat="server" /> Reviews)</div>
                    </div>

                    <!-- PRICE -->
                    <div class="item-detail-price">&#8377;<asp:Literal ID="litPrice" runat="server" /></div>

                    <!-- DESCRIPTION -->
                    <p class="item-detail-desc">
                        <asp:Literal ID="litDescription" runat="server" />
                    </p>

                    <!-- 2x2 TRUST GRID WITH ICONS -->
                    <div class="item-detail-trust-grid">
                        <div class="item-detail-trust-card">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2"><path d="M12 2a10 10 0 0 1 10 10c0 5.5-4.5 10-10 10S2 17.5 2 12A10 10 0 0 1 12 2z"></path><path d="M12 6v6l4 2"></path></svg>
                            <span>Organic Cotton</span>
                        </div>
                        <div class="item-detail-trust-card">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path></svg>
                            <span>Artisan Crafted</span>
                        </div>
                        <div class="item-detail-trust-card">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path></svg>
                            <span>Eco-friendly Box</span>
                        </div>
                        <div class="item-detail-trust-card">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2"><path d="M7 11v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1v-8"></path><path d="M21 11V7a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v4"></path></svg>
                            <span>Ethical Production</span>
                        </div>
                    </div>

                    <asp:ValidationSummary ID="vsBuy" runat="server"
                        ValidationGroup="Buy" CssClass="validation-summary"
                        HeaderText="This item could not be added:" DisplayMode="BulletList" Visible="false" ShowSummary="false" />

                    <!-- QUANTITY & ADD TO CART ROW -->
                    <div class="item-detail-buy-row">
                        <!-- QUANTITY STEPPER PILL -->
                        <div class="item-detail-qty-stepper">
                            <button type="button" class="qty-btn" onclick="var el=document.getElementById('<%= txtQuantity.ClientID %>'); var v=parseInt(el.value)||1; if(v>1) el.value=v-1;">&minus;</button>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="qty-val-input" MaxLength="2" Text="1" />
                            <button type="button" class="qty-btn" onclick="var el=document.getElementById('<%= txtQuantity.ClientID %>'); var v=parseInt(el.value)||1; if(v<10) el.value=v+1;">&plus;</button>
                        </div>

                        <!-- ADD TO CART BUTTON -->
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart"
                            CssClass="item-detail-cart-btn" ValidationGroup="Buy" OnClick="btnAddToCart_Click" />

                        <!-- Hidden validators -->
                        <div style="display:none;">
                            <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ControlToValidate="txtQuantity" ValidationGroup="Buy" ErrorMessage="Quantity is required." />
                            <asp:RangeValidator ID="rngQuantity" runat="server" ControlToValidate="txtQuantity" ValidationGroup="Buy" Type="Integer" MinimumValue="1" MaximumValue="10" ErrorMessage="Quantity must be 1-10." />
                            <asp:CustomValidator ID="cvStock" runat="server" ControlToValidate="txtQuantity" ValidationGroup="Buy" OnServerValidate="cvStock_ServerValidate" ErrorMessage="More than in stock." />
                        </div>
                    </div>

                    <!-- STOCK INFO & ACCENT DIVIDER -->
                    <p class="item-detail-stock-text">
                        <asp:Literal ID="litStock" runat="server" />
                    </p>
                    <div class="item-detail-accent-divider"></div>
                </div>
            </div>

            <!-- CUSTOMER REVIEWS SECTION -->
            <div class="item-detail-reviews-section">
                <div class="item-detail-reviews-header">
                    <h2 class="item-detail-reviews-title">Customer Reviews</h2>
                    <a href="#writeReview" class="item-detail-write-link">Write a review</a>
                </div>

                <div class="item-detail-reviews-grid">
                    <asp:Repeater ID="rptReviews" runat="server">
                        <ItemTemplate>
                            <div class="item-detail-review-card">
                                <div>
                                    <div class="review-top-row">
                                        <span class="stars" style="color:#855335;font-size:13px;"><%# RenderStars(Eval("Rating")) %></span>
                                        <span class="review-date"><%# Eval("Ago") %></span>
                                    </div>
                                    <h4 class="review-headline">&ldquo;<%# Server.HtmlEncode(Convert.ToString(Eval("Title"))) %>&rdquo;</h4>
                                    <p class="review-body"><%# Server.HtmlEncode(Convert.ToString(Eval("Body"))) %></p>
                                </div>
                                <div class="review-author-row">
                                    <div class="author-avatar"><%# (Convert.ToString(Eval("Author")) + "A").Substring(0, 1).ToUpper() %></div>
                                    <span class="author-name"><%# Server.HtmlEncode(Convert.ToString(Eval("Author"))) %></span>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <asp:Panel ID="pnlNoReviews" runat="server" Visible="false" CssClass="prof-empty-card" style="margin:0;padding:24px;">
                    No reviews yet. Be the first to write one below.
                </asp:Panel>
            </div>

            <!-- WRITE A REVIEW FORM -->
            <div class="item-detail-write-card" id="writeReview">
                <h3 class="prof-img2-form-title">Write a review</h3>
                <p class="prof-img2-form-sub">Tell other collectors what arrived and how it felt.</p>

                <asp:Panel ID="pnlReviewDone" runat="server" Visible="false" CssClass="form-alert success" style="margin-bottom:16px;">
                    Thank you - your review is now live on this piece.
                </asp:Panel>

                <asp:ValidationSummary ID="vsReview" runat="server"
                    ValidationGroup="Review" CssClass="validation-summary"
                    HeaderText="Your review could not be posted:" DisplayMode="BulletList" Visible="false" ShowSummary="false" />

                <div class="form-grid">
                    <div class="form-field">
                        <label class="prof-img2-brown-label">YOUR NAME<span class="req">*</span></label>
                        <asp:TextBox ID="txtReviewer" runat="server" CssClass="prof-img2-input-white" placeholder="Full name" />
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
                        <label class="prof-img2-brown-label">RATING (1-5)<span class="req">*</span></label>
                        <asp:TextBox ID="txtRating" runat="server" CssClass="prof-img2-input-white" MaxLength="1" placeholder="5" />
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
                        <label class="prof-img2-brown-label">HEADLINE<span class="req">*</span></label>
                        <asp:TextBox ID="txtReviewTitle" runat="server" CssClass="prof-img2-input-white" MaxLength="60" placeholder="Stunning piece!" />
                        <asp:RequiredFieldValidator ID="rfvReviewTitle" runat="server"
                            ControlToValidate="txtReviewTitle" ValidationGroup="Review"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="A headline is required."
                            Text="A headline is required." />
                    </div>

                    <div class="form-field full">
                        <label class="prof-img2-brown-label">YOUR REVIEW<span class="req">*</span></label>
                        <asp:TextBox ID="txtReviewBody" runat="server" CssClass="prof-img2-input-white"
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

                <div class="form-actions" style="margin-top:20px;">
                    <asp:Button ID="btnPostReview" runat="server" Text="Post Review"
                        CssClass="prof-img2-save-pill-btn" ValidationGroup="Review" OnClick="btnPostReview_Click" />
                </div>
            </div>
        </asp:Panel>
    </main>

</asp:Content>
