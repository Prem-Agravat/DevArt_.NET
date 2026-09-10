<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderSuccess.aspx.cs" Inherits="DevArt.OrderSuccess" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Order Successful</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <div class="success-hero">
            <div class="success-badge">&#10003;</div>
            <h1 class="page-title">Order Successful!</h1>
            <p class="page-subtitle" style="margin: 0 auto 30px;">
                Thank you for supporting local artisans. Your unique pieces are being carefully
                prepared for their journey to you.
            </p>

            <div class="stat-row">
                <div class="stat-tile">
                    <div class="label">Order Number</div>
                    <div class="value">#<asp:Literal ID="litOrderNumber" runat="server" /></div>
                </div>
                <div class="stat-tile">
                    <div class="label">Est. Delivery</div>
                    <div class="value" style="font-size:17px;"><asp:Literal ID="litEta" runat="server" /></div>
                </div>
            </div>

            <div class="panel" style="text-align:left;">
                <h3>Order Summary</h3>
                <p class="panel-hint">Paid by <asp:Literal ID="litMethod" runat="server" />.</p>

                <asp:Repeater ID="rptLines" runat="server">
                    <ItemTemplate>
                        <div class="summary-line">
                            <span><%# Server.HtmlEncode(Convert.ToString(Eval("ProductName"))) %> &middot; Qty <%# Eval("Quantity") %></span>
                            <span>&#8377;<%# Eval("Amount", "{0:N0}") %></span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <div class="summary-line total"><span>Total</span><span>&#8377;<asp:Literal ID="litTotal" runat="server" /></span></div>

                <div class="address-card" style="margin-top:18px;">
                    <asp:Literal ID="litAddress" runat="server" />
                </div>
            </div>

            <div class="form-actions" style="justify-content:center;">
                <a href="Default.aspx" class="newsletter-btn">Back to Home</a>
                <a href="MyOrders.aspx" class="btn-outline">Track this order</a>
            </div>
        </div>
    </main>

</asp:Content>
