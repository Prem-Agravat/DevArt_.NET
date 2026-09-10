<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="DevArt.Admin.Customers" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Customers</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-head">
        <h1>Customer Management</h1>
        <a href="Dashboard.aspx" class="btn-outline">Back to Dashboard</a>
    </div>

    <asp:Panel ID="pnlStatus" runat="server" Visible="false">
        <asp:Literal ID="litStatus" runat="server" />
    </asp:Panel>

    <div class="stat-row">
        <div class="stat-tile">
            <div class="label">Total Users</div>
            <div class="value"><asp:Literal ID="litTotal" runat="server" /></div>
        </div>
        <div class="stat-tile">
            <div class="label">Newsletter Subscribers</div>
            <div class="value"><asp:Literal ID="litSubscribed" runat="server" /></div>
        </div>
    </div>

    <div class="admin-card">
        <div class="filter-bar">
            <span>All Users</span>
            <span style="display:flex;gap:8px;">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-input" placeholder="Search name or email" />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-outline"
                    CausesValidation="false" OnClick="btnSearch_Click" />
            </span>
        </div>

        <table class="data-table">
            <thead>
                <tr><th>User Name</th><th>Email id</th><th>City</th><th>Orders</th><th>Joined</th><th></th></tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptUsers" runat="server" OnItemCommand="rptUsers_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("FullName"))) %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Email"))) %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("City"))) %></td>
                            <td><%# Eval("OrderCount") %></td>
                            <td><%# Eval("CreatedOn", "{0:MMM yyyy}") %></td>
                            <td style="text-align:right;">
                                <asp:Button runat="server" CssClass="link-button" style="color:#c0392b;"
                                    CommandName="DeleteUser" CommandArgument='<%# Eval("Id") %>'
                                    Text="Delete" CausesValidation="false"
                                    OnClientClick="return confirm('Delete this user? This action cannot be undone.');" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
            No customers match that search.
        </asp:Panel>
    </div>

</asp:Content>
