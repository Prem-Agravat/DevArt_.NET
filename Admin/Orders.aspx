<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="DevArt.Admin.Orders" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Orders</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-head">
        <h1>Orders Management</h1>
        <a href="Dashboard.aspx" class="btn-outline">Back to Dashboard</a>
    </div>

    <asp:Panel ID="pnlStatus" runat="server" Visible="false">
        <asp:Literal ID="litStatus" runat="server" />
    </asp:Panel>

    <div class="stat-row">
        <div class="stat-tile">
            <div class="label">Total Orders</div>
            <div class="value"><asp:Literal ID="litTotal" runat="server" /></div>
        </div>
        <div class="stat-tile">
            <div class="label">Active Orders</div>
            <div class="value"><asp:Literal ID="litActive" runat="server" /></div>
        </div>
        <div class="stat-tile">
            <div class="label">Pending Orders</div>
            <div class="value"><asp:Literal ID="litPending" runat="server" /></div>
        </div>
    </div>

    <div class="admin-card">
        <div class="filter-bar">
            <span>Recent Orders</span>
            <span>
                Status:
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-input"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                    <asp:ListItem Text="All" Value="" />
                    <asp:ListItem Text="Pending" Value="Pending" />
                    <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                    <asp:ListItem Text="In Transit" Value="In Transit" />
                    <asp:ListItem Text="Delivered" Value="Delivered" />
                </asp:DropDownList>
            </span>
        </div>

        <table class="data-table">
            <thead>
                <tr><th>Order ID</th><th>Product</th><th>Customer</th><th>Placed</th><th>Total</th><th>Status</th><th></th></tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td>#<%# Eval("OrderNumber") %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Product"))) %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("CustomerName"))) %></td>
                            <td><%# Eval("PlacedOn", "{0:MMM d, yyyy}") %></td>
                            <td>&#8377;<%# Eval("Total", "{0:N0}") %></td>
                            <td><span class="pill <%# Eval("StatusClass") %>"><%# Eval("Status") %></span></td>
                            <td style="text-align:right;white-space:nowrap;">
                                <asp:Button runat="server" CssClass="btn-outline btn-small"
                                    CommandName="Advance" CommandArgument='<%# Eval("OrderNumber") %>'
                                    Text='<%# Eval("NextLabel") %>' CausesValidation="false"
                                    Visible='<%# !string.IsNullOrEmpty(Convert.ToString(Eval("NextStatus"))) %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
            No orders with that status.
        </asp:Panel>
    </div>

</asp:Content>
