<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="DevArt.Admin.Dashboard" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Dashboard</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- WELCOME TITLE -->
    <div class="admin-welcome-section">
        <h1 class="admin-welcome-title">Welcome <span class="highlight-red">back, Admin.</span></h1>
        <p class="admin-welcome-sub">admin@devart.com</p>
    </div>

    <!-- 4 STAT SUMMARY CARDS -->
    <div class="admin-stats-grid">
        <!-- TOTAL SALES -->
        <div class="admin-stat-card">
            <div class="admin-stat-head">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="6" width="20" height="12" rx="2"></rect><circle cx="12" cy="12" r="2"></circle><path d="M6 12h.01M18 12h.01"></path></svg>
                <span>Total Sales</span>
            </div>
            <div class="admin-stat-dashed-line"></div>
            <div class="admin-stat-val">&#8377;<asp:Literal ID="litSales" runat="server" /></div>
        </div>

        <!-- TOTAL ORDERS -->
        <div class="admin-stat-card">
            <div class="admin-stat-head">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path><line x1="3" y1="6" x2="21" y2="6"></line><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
                <span>Total Orders</span>
            </div>
            <div class="admin-stat-dashed-line"></div>
            <div class="admin-stat-val"><asp:Literal ID="litOrders" runat="server" /></div>
        </div>

        <!-- CUSTOMERS -->
        <div class="admin-stat-card">
            <div class="admin-stat-head">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle></svg>
                <span>Customers</span>
            </div>
            <div class="admin-stat-dashed-line"></div>
            <div class="admin-stat-val"><asp:Literal ID="litCustomers" runat="server" /></div>
        </div>

        <!-- ACTIVE ORDERS -->
        <div class="admin-stat-card">
            <div class="admin-stat-head">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="3" width="15" height="13"></rect><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon><circle cx="5.5" cy="18.5" r="2.5"></circle><circle cx="18.5" cy="18.5" r="2.5"></circle></svg>
                <span>Active Orders</span>
            </div>
            <div class="admin-stat-dashed-line"></div>
            <div class="admin-stat-val"><asp:Literal ID="litActive" runat="server" /></div>
        </div>
    </div>

    <!-- RECENT ORDERS CARD TABLE -->
    <div class="admin-table-card">
        <div class="admin-table-header-row">
            <h3 class="admin-table-title">Recent Orders</h3>
            <a href="Orders.aspx" class="admin-table-view-all">View All</a>
        </div>

        <table class="admin-custom-table">
            <thead>
                <tr>
                    <th>ORDER ID</th>
                    <th>PRODUCT</th>
                    <th>CUSTOMER</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptOrders" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td class="font-bold">#<%# Eval("OrderNumber") %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Product"))) %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("CustomerName"))) %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <!-- Hidden literals for backend code compatibility if needed -->
    <div style="display:none;">
        <asp:Literal ID="litPending" runat="server" />
        <asp:Repeater ID="rptLowStock" runat="server"><ItemTemplate></ItemTemplate></asp:Repeater>
    </div>

</asp:Content>
