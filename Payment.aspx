<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="DevArt.Payment" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Payment</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <p class="breadcrumb"><a href="Cart.aspx">Return to Cart</a></p>
        <h1 class="page-title">Payment</h1>

        <div class="steps">
            <span>Cart</span><i>&rsaquo;</i>
            <span>Shipping</span><i>&rsaquo;</i>
            <span class="active">Payment</span>
        </div>

        <div class="checkout-split">

            <div>
                <div class="panel">
                    <h3>Payment Method</h3>
                    <p class="panel-hint">Cash on delivery is available across Gujarat. Card payments are collected by our gateway, never by this page.</p>

                    <asp:ValidationSummary ID="vsPay" runat="server"
                        ValidationGroup="Pay" CssClass="validation-summary"
                        HeaderText="The order could not be placed:" DisplayMode="BulletList" />

                    <div class="pay-option">
                        <asp:RadioButtonList ID="rblMethod" runat="server" RepeatLayout="Flow" RepeatDirection="Vertical">
                            <asp:ListItem Text="COD (Cash On Delivery)" Value="COD" Selected="True" />
                        </asp:RadioButtonList>
                    </div>

                    <asp:RequiredFieldValidator ID="rfvMethod" runat="server"
                        ControlToValidate="rblMethod" InitialValue="" ValidationGroup="Pay"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Choose a payment method."
                        Text="Choose a payment method." />

                </div>

                <div class="panel">
                    <h3>Delivering To</h3>
                    <div class="address-card">
                        <asp:Literal ID="litAddress" runat="server" />
                    </div>
                </div>
            </div>

            <div class="panel">
                <h3>Order Summary</h3>
                <p class="panel-hint">Includes all taxes and duties.</p>

                <asp:Repeater ID="rptLines" runat="server">
                    <ItemTemplate>
                        <div class="summary-line">
                            <span><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %> &times; <%# Eval("Quantity") %></span>
                            <span>&#8377;<%# Eval("Amount", "{0:N0}") %></span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <div class="summary-line" style="border-top:1px solid #f0efec;margin-top:8px;padding-top:12px;">
                    <span>Subtotal</span><span>&#8377;<asp:Literal ID="litSubTotal" runat="server" /></span>
                </div>
                <asp:Panel ID="pnlDiscount" runat="server" Visible="false" CssClass="summary-line discount">
                    <span>Discount</span><span>-&#8377;<asp:Literal ID="litDiscount" runat="server" /></span>
                </asp:Panel>
                <div class="summary-line"><span>Shipping</span><span><asp:Literal ID="litShipping" runat="server" /></span></div>
                <div class="summary-line total"><span>Total</span><span>&#8377;<asp:Literal ID="litTotal" runat="server" /></span></div>

                <asp:Button ID="btnPay" runat="server" CssClass="newsletter-btn auth-submit"
                    ValidationGroup="Pay" OnClick="btnPay_Click" />
                <asp:Button ID="btnBack" runat="server" Text="Return to cart" CssClass="link-button"
                    CausesValidation="false" OnClick="btnBack_Click" style="margin-top:12px;" />
            </div>
        </div>
    </main>

</asp:Content>
