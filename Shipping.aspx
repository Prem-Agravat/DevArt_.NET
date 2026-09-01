<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shipping.aspx.cs" Inherits="DevArt.Shipping" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Shipping Information</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <p class="breadcrumb"><a href="Cart.aspx">Return to Cart</a></p>
        <h1 class="page-title">Shipping Information</h1>

        <div class="steps">
            <span>Cart</span><i>&rsaquo;</i>
            <span class="active">Shipping</span><i>&rsaquo;</i>
            <span>Payment</span>
        </div>

        <div class="checkout-split">

            <div class="panel">
                <h3>Shipping Address</h3>
                <p class="panel-hint">Choose where this order should arrive, or add a new address.</p>

                <asp:ValidationSummary ID="vsShip" runat="server"
                    ValidationGroup="Ship" CssClass="validation-summary"
                    HeaderText="We cannot continue yet:" DisplayMode="BulletList" />

                <asp:RadioButtonList ID="rblAddresses" runat="server" CssClass="address-list"
                    DataTextField="Display" DataValueField="Id" RepeatLayout="Flow" RepeatDirection="Vertical" />

                <%-- InitialValue "" makes an unselected list fail the rule. --%>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                    ControlToValidate="rblAddresses" InitialValue="" ValidationGroup="Ship"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Choose a delivery address to continue."
                    Text="Choose a delivery address." />

                <p style="margin-top:16px;">
                    <a href="Address.aspx?returnUrl=Shipping.aspx" class="btn-outline">Add New Address</a>
                </p>

                <div class="form-actions">
                    <asp:Button ID="btnContinue" runat="server" Text="Continue to Payment"
                        CssClass="newsletter-btn" ValidationGroup="Ship" OnClick="btnContinue_Click" />
                    <asp:Button ID="btnBack" runat="server" Text="Return to cart" CssClass="link-button"
                        CausesValidation="false" OnClick="btnBack_Click" />
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
            </div>
        </div>
    </main>

</asp:Content>
