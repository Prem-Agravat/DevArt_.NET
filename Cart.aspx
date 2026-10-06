<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="DevArt.Cart" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Your Cart</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="cart-v2-wrapper">
        <div class="cart-v2-top-bar">
            <a href="Collection.aspx" class="cart-v2-back-link">&larr; Back to Item Detail</a>
            <h1 class="cart-v2-page-title">Your Shopping Cart</h1>
        </div>

        <asp:Panel ID="pnlStatus" runat="server" Visible="false" style="max-width: 1140px; margin: 0 auto 20px;">
            <asp:Literal ID="litStatus" runat="server" />
        </asp:Panel>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="cart-v2-empty-card">
            <h2 class="empty-title">Your shopping cart is currently empty</h2>
            <p class="empty-sub">Explore our artisanal collection and add items to your cart.</p>
            <a href="Collection.aspx" class="cart-v2-empty-btn">Browse Our Collection</a>
        </asp:Panel>

        <asp:Panel ID="pnlCart" runat="server" CssClass="cart-v2-grid">

            <!-- LEFT COLUMN: Cart Items Container -->
            <div class="cart-v2-left-col">
                <div class="cart-v2-items-card">
                    <div class="cart-v2-items-header">
                        <h2 class="cart-v2-card-title">Your Shopping Cart</h2>
                        <span class="cart-v2-items-count">(<asp:Literal ID="litItemCount" runat="server" /> ITEMS)</span>
                    </div>

                    <asp:ValidationSummary ID="vsCart" runat="server"
                        ValidationGroup="Cart" CssClass="validation-summary"
                        HeaderText="The cart could not be updated:" DisplayMode="BulletList" />

                    <div class="cart-v2-items-list">
                        <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                            <ItemTemplate>
                                <div class="cart-v2-item-row">
                                    <!-- Remove Cross Button -->
                                    <asp:LinkButton runat="server" CssClass="cart-v2-remove-btn"
                                        CommandName="Remove" CommandArgument='<%# Eval("ProductId") %>'
                                        CausesValidation="false" title="Remove item">
                                        &times;
                                    </asp:LinkButton>

                                    <!-- Product Image -->
                                    <img src="<%# FormatImageUrl(Eval("Image")) %>" alt="<%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %>" class="cart-v2-item-img" onerror="this.src='Images/category_cushion.jpg';" />

                                    <!-- Item Details -->
                                    <div class="cart-v2-item-details">
                                        <h3 class="cart-v2-item-name"><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></h3>
                                        <div class="cart-v2-item-meta"><%# string.IsNullOrEmpty(Convert.ToString(Eval("Variant"))) ? "Standard" : Server.HtmlEncode(Convert.ToString(Eval("Variant"))) %></div>

                                        <!-- Quantity Stepper Pill -->
                                        <div class="cart-v2-qty-pill">
                                            <asp:LinkButton runat="server" CssClass="qty-btn"
                                                CommandName="Decrease" CommandArgument='<%# Eval("ProductId") %>'
                                                CausesValidation="false">&minus;</asp:LinkButton>
                                            <span class="qty-val"><%# Eval("Quantity") %></span>
                                            <asp:LinkButton runat="server" CssClass="qty-btn"
                                                CommandName="Increase" CommandArgument='<%# Eval("ProductId") %>'
                                                CausesValidation="false">&plus;</asp:LinkButton>
                                        </div>
                                    </div>

                                    <!-- Price -->
                                    <div class="cart-v2-item-price">&#8377;<%# Eval("Amount", "{0:N0}") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="cart-v2-left-footer">
                        <a href="Collection.aspx" class="cart-v2-continue-link">&larr; Continue Exploring</a>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN: Order Summary Card -->
            <div class="cart-v2-right-col">
                <div class="cart-v2-summary-card">
                    <h2 class="cart-v2-summary-title">Order Summary</h2>

                    <div class="cart-v2-summary-line">
                        <span class="label">Subtotal</span>
                        <span class="value">&#8377;<asp:Literal ID="litSubTotal" runat="server" /></span>
                    </div>

                    <asp:Panel ID="pnlDiscount" runat="server" Visible="false" CssClass="cart-v2-summary-line discount">
                        <span class="label">Discount (<asp:Literal ID="litPromoCode" runat="server" />)</span>
                        <span class="value">-&#8377;<asp:Literal ID="litDiscount" runat="server" /></span>
                    </asp:Panel>

                    <div class="cart-v2-summary-line">
                        <span class="label">Shipping</span>
                        <span class="value muted"><asp:Literal ID="litShipping" runat="server" /></span>
                    </div>

                    <!-- Promo Code Box -->
                    <div class="cart-v2-promo-box">
                        <label class="cart-v2-promo-label">PROMO CODE</label>
                        <div class="cart-v2-promo-input-row">
                            <asp:TextBox ID="txtPromo" runat="server" CssClass="cart-v2-promo-input" MaxLength="12" placeholder="ARTISAN10" />
                            <asp:Button ID="btnApplyPromo" runat="server" Text="Apply"
                                CssClass="cart-v2-promo-btn" ValidationGroup="Promo" OnClick="btnApplyPromo_Click" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPromo" runat="server"
                            ControlToValidate="txtPromo" ValidationGroup="Promo"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Enter a promo code first."
                            Text="Enter a promo code first." />
                        <asp:RegularExpressionValidator ID="revPromo" runat="server"
                            ControlToValidate="txtPromo" ValidationGroup="Promo"
                            CssClass="field-error" Display="Dynamic"
                            ValidationExpression="^[A-Za-z0-9]{5,12}$"
                            ErrorMessage="A promo code is 5-12 letters or digits."
                            Text="5-12 letters or digits." />
                        <asp:CustomValidator ID="cvPromo" runat="server"
                            ControlToValidate="txtPromo" ValidationGroup="Promo"
                            CssClass="field-error" Display="Dynamic"
                            OnServerValidate="cvPromo_ServerValidate"
                            ErrorMessage="Code is invalid or minimum spend not met."
                            Text="Code is invalid or minimum spend not met." />

                        <div class="cart-v2-offers-link-wrapper">
                            <a href="Offers.aspx" class="cart-v2-offers-link">&larr; View All Offers</a>
                        </div>
                    </div>

                    <div class="cart-v2-summary-divider"></div>

                    <!-- Total Line -->
                    <div class="cart-v2-total-block">
                        <div class="cart-v2-total-line">
                            <span class="label">Total</span>
                            <span class="value">&#8377;<asp:Literal ID="litTotal" runat="server" /></span>
                        </div>
                        <div class="cart-v2-total-subtext">Includes all taxes and duties</div>
                    </div>

                    <!-- Proceed to Checkout Button -->
                    <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout &rsaquo;"
                        CssClass="cart-v2-checkout-btn" CausesValidation="false" OnClick="btnCheckout_Click" />

                    <!-- Security Icons Row -->
                    <div class="cart-v2-trust-icons">
                        <span title="Secure Checkout">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#777777" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                            </svg>
                        </span>
                        <span title="Global Artisanal Shipping">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#777777" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="2" y1="12" x2="22" y2="12"></line>
                                <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path>
                            </svg>
                        </span>
                        <span title="Handcrafted Quality Guarantee">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#777777" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                            </svg>
                        </span>
                    </div>

                    <!-- Shipping Estimation Card -->
                    <div class="cart-v2-shipping-est-card">
                        <div class="est-icon">
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#48680E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="1" y="3" width="15" height="13"></rect>
                                <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                                <circle cx="5.5" cy="18.5" r="2.5"></circle>
                                <circle cx="18.5" cy="18.5" r="2.5"></circle>
                            </svg>
                        </div>
                        <div class="est-content">
                            <h4 class="est-title">Shipping Estimation</h4>
                            <p class="est-desc">
                                Free delivery to Rajkot, Gujarat (Arriving by <asp:Literal ID="litEta" runat="server" />).
                            </p>
                        </div>
                    </div>

                </div>
            </div>

        </asp:Panel>
    </main>

</asp:Content>
