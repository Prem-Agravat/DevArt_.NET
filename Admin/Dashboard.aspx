<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="DevArt.Admin.Dashboard" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Dashboard</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-head">
        <h1>Dashboard</h1>
        <a href="Inventory.aspx" class="btn-outline">Manage Inventory</a>
    </div>

    <div class="stat-row">
        <div class="stat-tile">
            <div class="label">Total Sales</div>
            <div class="value">&#8377;<asp:Literal ID="litSales" runat="server" /></div>
        </div>
        <div class="stat-tile">
            <div class="label">Total Orders</div>
            <div class="value"><asp:Literal ID="litOrders" runat="server" /></div>
        </div>
        <div class="stat-tile">
            <div class="label">Active Orders</div>
            <div class="value"><asp:Literal ID="litActive" runat="server" /></div>
        </div>
        <div class="stat-tile">
            <div class="label">Pending Orders</div>
            <div class="value"><asp:Literal ID="litPending" runat="server" /></div>
        </div>
        <div class="stat-tile">
            <div class="label">Customers</div>
            <div class="value"><asp:Literal ID="litCustomers" runat="server" /></div>
        </div>
    </div>

    <div class="admin-card">
        <div class="admin-head" style="margin-bottom:14px;">
            <h1 style="font-size:17px;">Recent Orders</h1>
            <a href="Orders.aspx" class="btn-outline btn-small">View All</a>
        </div>

        <table class="data-table">
            <thead>
                <tr><th>Order ID</th><th>Product</th><th>Customer</th><th>Placed</th><th>Status</th><th>Total</th></tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptOrders" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td>#<%# Eval("OrderNumber") %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Product"))) %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("CustomerName"))) %></td>
                            <td><%# Eval("PlacedOn", "{0:MMM d, yyyy}") %></td>
                            <td><span class="pill <%# Eval("StatusClass") %>"><%# Eval("Status") %></span></td>
                            <td>&#8377;<%# Eval("Total", "{0:N0}") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <div class="admin-card">
        <h1 style="font-size:17px;margin:0 0 4px;">Low stock</h1>
        <p class="panel-hint">Pieces with five or fewer left on the shelf.</p>
        <table class="data-table">
            <thead>
                <tr><th>Product</th><th>Category</th><th>Stock</th><th></th></tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptLowStock" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Category"))) %></td>
                            <td><%# Eval("Stock") %></td>
                            <td><a class="btn-outline btn-small" href='<%# "ProductEdit.aspx?id=" + Eval("Id") %>'>Restock</a></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

</asp:Content>
