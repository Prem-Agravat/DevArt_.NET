<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="DevArt.Payment" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Payment</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="pay-page-wrapper">
        <h1 class="pay-page-title">Payment</h1>

        <div class="pay-container">

            <!-- LEFT COLUMN: Dashed Card Container -->
            <div class="pay-left-col">
                <div class="pay-dashed-card">

                    <!-- Steps Navigation -->
                    <div class="pay-steps-row">
                        <div class="pay-steps">
                            <span class="pay-step">Cart</span>
                            <span class="pay-step-sep">&gt;</span>
                            <span class="pay-step">Shipping</span>
                            <span class="pay-step-sep">&gt;</span>
                            <span class="pay-step active">Payment</span>
                        </div>
                    </div>

                    <!-- Header inside card -->
                    <h2 class="pay-section-heading">Payment Method</h2>

                    <asp:ValidationSummary ID="vsPay" runat="server"
                        ValidationGroup="Pay" CssClass="validation-summary"
                        HeaderText="The order could not be placed:" DisplayMode="BulletList" />

                    <!-- Payment Method Card -->
                    <div class="pay-method-card">
                        <asp:RadioButtonList ID="rblMethod" runat="server" RepeatLayout="Flow" RepeatDirection="Vertical" CssClass="pay-radio-list">
                            <asp:ListItem Text="COD(Cash On Delivery)" Value="COD" Selected="True" />
                        </asp:RadioButtonList>
                    </div>

                    <asp:RequiredFieldValidator ID="rfvMethod" runat="server"
                        ControlToValidate="rblMethod" InitialValue="" ValidationGroup="Pay"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Choose a payment method."
                        Text="Choose a payment method." />

                    <!-- Footer Actions -->
                    <div class="pay-actions-row">
                        <a href="Cart.aspx" class="pay-footer-return">&lt; Return to cart</a>
                        <asp:Button ID="btnPay" runat="server" Text="Pay ₹0"
                            CssClass="pay-submit-btn" ValidationGroup="Pay" OnClick="btnPay_Click" />
                    </div>

                </div>
            </div>

            <!-- RIGHT COLUMN: Order Summary Card -->
            <div class="pay-right-col">
                <div class="pay-summary-card">
                    <h2 class="pay-summary-title">Order Summary</h2>

                    <div class="pay-summary-items">
                        <asp:Repeater ID="rptLines" runat="server">
                            <ItemTemplate>
                                <div class="pay-item-row">
                                    <img src="<%# FormatImageUrl(Eval("Image")) %>" alt="<%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %>" class="pay-item-thumb" onerror="this.src='Images/category_cushion.jpg';" />
                                    <div class="pay-item-details">
                                        <div class="pay-item-name"><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></div>
                                        <div class="pay-item-meta"><%# string.IsNullOrEmpty(Convert.ToString(Eval("Variant"))) ? "Standard" : Server.HtmlEncode(Convert.ToString(Eval("Variant"))) %></div>
                                        <div class="pay-item-qty">Qty : <%# Eval("Quantity") %></div>
                                    </div>
                                    <div class="pay-item-price">&#8377;<%# Eval("Amount", "{0:N0}") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="pay-summary-divider"></div>

                    <div class="pay-summary-line">
                        <span class="label">Subtotal</span>
                        <span class="value">&#8377;<asp:Literal ID="litSubTotal" runat="server" /></span>
                    </div>

                    <asp:Panel ID="pnlDiscount" runat="server" Visible="false" CssClass="pay-summary-line discount">
                        <span class="label">Discount</span>
                        <span class="value">-&#8377;<asp:Literal ID="litDiscount" runat="server" /></span>
                    </asp:Panel>

                    <div class="pay-summary-line">
                        <span class="label">Shipping</span>
                        <span class="value muted"><asp:Literal ID="litShipping" runat="server" /></span>
                    </div>

                    <div class="pay-summary-divider"></div>

                    <div class="pay-summary-line total">
                        <span class="label">Total</span>
                        <span class="value">&#8377;<asp:Literal ID="litTotal" runat="server" /></span>
                    </div>
                </div>
            </div>

        </div>

        <!-- ORDER SUCCESSFUL POPUP MODAL OVERLAY -->
        <asp:Panel ID="pnlSuccessModal" runat="server" Visible="false" CssClass="pay-modal-overlay">
            <div class="pay-modal-card">

                <!-- Green Checkmark Circle -->
                <div class="pay-modal-icon-circle">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#2E7D32" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"></polyline>
                    </svg>
                </div>

                <!-- Title & Subtitle -->
                <h2 class="pay-modal-title">Order Successful!</h2>
                <p class="pay-modal-subtitle">
                    Thank you for supporting local artisans. Your unique pieces are being carefully prepared for their journey to you.
                </p>

                <!-- 2 Side-by-Side Cards (Order Number & Est Delivery) -->
                <div class="pay-modal-info-grid">
                    <div class="pay-modal-info-box">
                        <span class="label">ORDER NUMBER</span>
                        <h3 class="value"><asp:Literal ID="litModalOrderNum" runat="server" /></h3>
                    </div>
                    <div class="pay-modal-info-box">
                        <span class="label">EST. DELIVERY</span>
                        <h3 class="value"><asp:Literal ID="litModalDeliveryDate" runat="server" /></h3>
                    </div>
                </div>

                <!-- Order Summary Inner Card -->
                <div class="pay-modal-summary-box">
                    <h3 class="box-title">Order Summary</h3>
                    <p class="box-sub">Paid by COD (Cash On Delivery).</p>

                    <div class="box-items">
                        <asp:Repeater ID="rptModalItems" runat="server">
                            <ItemTemplate>
                                <div class="box-item-row">
                                    <span class="item-name"><%# Server.HtmlEncode(Convert.ToString(Eval("ProductName"))) %> &middot; Qty <%# Eval("Quantity") %></span>
                                    <span class="item-price">&#8377;<%# Eval("Amount", "{0:N0}") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="box-divider"></div>

                    <div class="box-total-row">
                        <span class="label">Total</span>
                        <span class="value">&#8377;<asp:Literal ID="litModalTotal" runat="server" /></span>
                    </div>

                    <!-- Delivery Address Subcard -->
                    <div class="box-address-subcard">
                        <div class="name"><asp:Literal ID="litModalAddressName" runat="server" /></div>
                        <div class="line"><asp:Literal ID="litModalAddressLine" runat="server" /></div>
                    </div>
                </div>

                <!-- Bottom Action Buttons -->
                <div class="pay-modal-actions">
                    <a href="Default.aspx" class="pay-modal-btn-home">Back to Home</a>
                    <a href="MyOrders.aspx" class="pay-modal-btn-track">Track this order</a>
                </div>

            </div>
        </asp:Panel>
    </main>

</asp:Content>
