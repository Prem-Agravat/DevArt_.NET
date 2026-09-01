<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="DevArt.Cart" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Your Cart</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <p class="breadcrumb"><a href="Collection.aspx">Continue Exploring</a></p>
        <h1 class="page-title">Your Shopping Cart</h1>
        <p class="page-subtitle">Review your selected items before checkout.</p>

        <div class="steps">
            <span class="active">Cart</span><i>&rsaquo;</i>
            <span>Shipping</span><i>&rsaquo;</i>
            <span>Payment</span>
        </div>

        <asp:Panel ID="pnlStatus" runat="server" Visible="false">
            <asp:Literal ID="litStatus" runat="server" />
        </asp:Panel>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="panel empty-state">
            Your shopping cart is currently empty.<br />
            <a href="Collection.aspx" class="btn-outline" style="margin-top:14px;">Browse Our Collection</a>
        </asp:Panel>

        <asp:Panel ID="pnlCart" runat="server" CssClass="checkout-split">

            <div>
                <div class="panel">
                    <h3>Your Shopping Cart (<asp:Literal ID="litItemCount" runat="server" /> items)</h3>
                    <p class="panel-hint">Quantities are validated between 1 and 10 per line, in the browser and again on the server.</p>

                    <asp:ValidationSummary ID="vsCart" runat="server"
                        ValidationGroup="Cart" CssClass="validation-summary"
                        HeaderText="The cart could not be updated:" DisplayMode="BulletList" />

                    <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                        <ItemTemplate>
                            <div class="cart-line">
                                <div class="thumb">
                                    <img src='<%# "Images/" + Eval("Image") %>' alt='<%# Eval("Name") %>' />
                                </div>
                                <div class="meta">
                                    <strong><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></strong>
                                    <span><%# Server.HtmlEncode(Convert.ToString(Eval("Variant"))) %></span>
                                    <div style="margin-top:8px; display:flex; gap:8px; align-items:flex-start;">
                                        <asp:TextBox runat="server" ID="txtQty" CssClass="form-input"
                                            Text='<%# Eval("Quantity") %>' MaxLength="2"
                                            style="width:64px; text-align:center; padding:7px;" />
                                        <asp:RangeValidator runat="server" ID="rngQty"
                                            ControlToValidate="txtQty" ValidationGroup="Cart"
                                            Type="Integer" MinimumValue="1" MaximumValue="10"
                                            CssClass="field-error" Display="Dynamic"
                                            ErrorMessage="Quantity must be a whole number from 1 to 10 per line."
                                            Text="1-10 only." />
                                        <asp:Button runat="server" CssClass="btn-outline btn-small"
                                            CommandName="Update" CommandArgument='<%# Eval("ProductId") %>'
                                            Text="Update" ValidationGroup="Cart" />
                                        <asp:Button runat="server" CssClass="link-button"
                                            CommandName="Remove" CommandArgument='<%# Eval("ProductId") %>'
                                            Text="Remove" CausesValidation="false" />
                                    </div>
                                </div>
                                <div class="amount">&#8377;<%# Eval("Amount", "{0:N0}") %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div class="form-actions">
                        <asp:Button ID="btnEmpty" runat="server" Text="Empty cart" CssClass="link-button"
                            CausesValidation="false" OnClick="btnEmpty_Click" />
                    </div>
                </div>

                <div class="panel">
                    <h3>Shipping Estimation</h3>
                    <p class="panel-hint" style="margin:0;">
                        Free delivery to Rajkot, Gujarat on orders over &#8377;1,500
                        (arriving by <asp:Literal ID="litEta" runat="server" />).
                    </p>
                </div>
            </div>

            <div>
                <div class="panel">
                    <h3>Order Summary</h3>
                    <p class="panel-hint">Includes all taxes and duties.</p>

                    <div class="summary-line"><span>Subtotal</span><span>&#8377;<asp:Literal ID="litSubTotal" runat="server" /></span></div>
                    <asp:Panel ID="pnlDiscount" runat="server" Visible="false" CssClass="summary-line discount">
                        <span>Discount (<asp:Literal ID="litPromoCode" runat="server" />)</span>
                        <span>-&#8377;<asp:Literal ID="litDiscount" runat="server" /></span>
                    </asp:Panel>
                    <div class="summary-line"><span>Shipping</span><span><asp:Literal ID="litShipping" runat="server" /></span></div>
                    <div class="summary-line total"><span>Total</span><span>&#8377;<asp:Literal ID="litTotal" runat="server" /></span></div>

                    <div style="margin-top:20px;">
                        <asp:ValidationSummary ID="vsPromo" runat="server"
                            ValidationGroup="Promo" CssClass="validation-summary"
                            HeaderText="The promo code was not applied:" DisplayMode="BulletList" />

                        <div class="form-field">
                            <label>Promo Code</label>
                            <div style="display:flex; gap:8px;">
                                <asp:TextBox ID="txtPromo" runat="server" CssClass="form-input"
                                    MaxLength="12" placeholder="ARTISAN20" />
                                <asp:Button ID="btnApplyPromo" runat="server" Text="Apply"
                                    CssClass="newsletter-btn" ValidationGroup="Promo" OnClick="btnApplyPromo_Click" />
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
                                ErrorMessage="A promo code is 5-12 letters or digits, with no spaces."
                                Text="5-12 letters or digits, no spaces." />
                            <%-- Existence, expiry and the minimum-spend rule are data questions,
                                 so they are answered on the server. --%>
                            <asp:CustomValidator ID="cvPromo" runat="server"
                                ControlToValidate="txtPromo" ValidationGroup="Promo"
                                CssClass="field-error" Display="Dynamic"
                                OnServerValidate="cvPromo_ServerValidate"
                                ErrorMessage="That code is not valid, has expired, or your cart is below its minimum spend."
                                Text="This code cannot be used on this cart." />
                        </div>

                        <p style="font-size:11.5px;color:#8c8c8c;margin:10px 0 0;">
                            <a href="Offers.aspx" style="color:#5069a6;">View all offers</a>
                        </p>
                    </div>

                    <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout"
                        CssClass="newsletter-btn auth-submit" CausesValidation="false" OnClick="btnCheckout_Click" />
                </div>
            </div>
        </asp:Panel>
    </main>

</asp:Content>
