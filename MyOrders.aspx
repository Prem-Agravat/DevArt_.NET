<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="DevArt.MyOrders" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - My Orders</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <h1 class="page-title">My Orders</h1>
        <p class="page-subtitle">Review your past artisanal purchases and track current shipments.</p>

        <asp:Panel ID="pnlGuest" runat="server" Visible="false" CssClass="panel empty-state">
            Please <a href="Login.aspx?returnUrl=MyOrders.aspx" style="color:#5069a6;">sign in</a> to see your order history.
        </asp:Panel>

        <asp:Panel ID="pnlOrders" runat="server" CssClass="layout-split">

            <div class="side-panel">
                <h4>Account</h4>
                <div class="side-nav">
                    <a href="Profile.aspx">Profile</a>
                    <a href="MyOrders.aspx" class="active">My Orders</a>
                    <a href="Wishlist.aspx">Wishlist</a>
                    <a href="Profile.aspx#password">Change Password</a>
                    <a href="Contact.aspx">Help &amp; Support</a>
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="danger"
                        CausesValidation="false" OnClick="btnLogout_Click" Text="Logout" />
                </div>
            </div>

            <div>
                <div class="filter-bar">
                    <span>Order History</span>
                    <span>
                        Show:
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-input"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                            <asp:ListItem Text="All orders" Value="" />
                            <asp:ListItem Text="Pending" Value="Pending" />
                            <asp:ListItem Text="In Transit" Value="In Transit" />
                            <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                            <asp:ListItem Text="Delivered" Value="Delivered" />
                        </asp:DropDownList>
                    </span>
                </div>

                <asp:Repeater ID="rptOrders" runat="server">
                    <ItemTemplate>
                        <div class="order-row">
                            <div class="meta">
                                <strong><%# Server.HtmlEncode(Convert.ToString(Eval("Summary"))) %></strong>
                                <span>Order #<%# Eval("OrderNumber") %> &middot; Placed <%# Eval("PlacedOn", "{0:MMM d, yyyy}") %></span>
                            </div>
                            <div style="display:flex;align-items:center;gap:14px;">
                                <span class="pill <%# Eval("StatusClass") %>"><%# Eval("Status") %></span>
                                <strong>&#8377;<%# Eval("Total", "{0:N0}") %></strong>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
                    No orders in this view yet.
                    <a href="Collection.aspx" style="color:#5069a6;">Start with our collection</a>.
                </asp:Panel>
            </div>
        </asp:Panel>
    </main>

</asp:Content>
