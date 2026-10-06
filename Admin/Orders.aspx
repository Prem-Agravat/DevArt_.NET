<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="DevArt.Admin.Orders" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Orders</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .ord-page-title {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 24px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin: 0 0 24px 0 !important;
        }

        /* 3 METRIC STAT CARDS ROW */
        .ord-stats-grid {
            display: grid !important;
            grid-template-columns: repeat(3, 1fr) !important;
            gap: 18px !important;
            margin-bottom: 24px !important;
        }

        .ord-stat-card {
            background: #ffffff !important;
            border: 1.5px dashed #D1D5DB !important;
            border-radius: 16px !important;
            padding: 16px 20px !important;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02) !important;
            transition: transform 0.2s, box-shadow 0.2s !important;
        }

        .ord-stat-card:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05) !important;
        }

        .ord-stat-header {
            display: flex !important;
            align-items: center !important;
            gap: 8px !important;
            color: #475569 !important;
            font-size: 12.5px !important;
            font-weight: 700 !important;
            padding-bottom: 8px !important;
            border-bottom: 1.5px dashed #E2E8F0 !important;
            margin-bottom: 10px !important;
        }

        .ord-stat-icon {
            width: 18px !important;
            height: 18px !important;
            stroke: #475569 !important;
        }

        .ord-stat-value {
            font-size: 24px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            line-height: 1 !important;
        }

        /* RECENT ORDERS CONTAINER & TABLE */
        .ord-table-card {
            background: #ffffff !important;
            border-radius: 20px !important;
            border: 1px solid #E2E8F0 !important;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03) !important;
            overflow: hidden !important;
        }

        .ord-table-header-banner {
            background: #E6EDF5 !important;
            padding: 14px 24px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            border-bottom: 1px solid #D6E0EC !important;
        }

        .ord-table-title {
            font-size: 15px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin: 0 !important;
        }

        .ord-filter-group {
            display: flex !important;
            align-items: center !important;
            gap: 8px !important;
            font-size: 13px !important;
            color: #475569 !important;
            font-weight: 600 !important;
        }

        .ord-status-select {
            height: 36px !important;
            border: 1px solid #CBD5E1 !important;
            border-radius: 10px !important;
            padding: 0 12px !important;
            font-size: 13px !important;
            color: #0F172A !important;
            background: #ffffff url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23475569' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") no-repeat right 10px center !important;
            -webkit-appearance: none !important;
            appearance: none !important;
            padding-right: 28px !important;
            font-family: inherit !important;
            cursor: pointer !important;
        }

        /* DATA TABLE */
        .ord-data-table {
            width: 100% !important;
            border-collapse: collapse !important;
            text-align: left !important;
        }

        .ord-data-table th {
            background: #ffffff !important;
            padding: 14px 20px !important;
            font-size: 11.5px !important;
            font-weight: 800 !important;
            color: #475569 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
            border-bottom: 1.5px solid #E2E8F0 !important;
        }

        .ord-data-table td {
            padding: 14px 20px !important;
            font-size: 13.5px !important;
            color: #1E293B !important;
            vertical-align: middle !important;
            border-bottom: 1px solid #EDF2F7 !important;
        }

        /* ALTERNATING ROW COLORS (MATCHING IMAGE 2) */
        .ord-data-table tbody tr:nth-child(even) {
            background: #F4F7FC !important;
        }

        .ord-data-table tbody tr:nth-child(odd) {
            background: #ffffff !important;
        }

        .ord-data-table tbody tr:hover {
            background: #EAEFF7 !important;
        }

        .ord-id {
            font-weight: 800 !important;
            color: #0F172A !important;
        }

        .ord-product {
            font-weight: 500 !important;
            color: #1E293B !important;
        }

        .ord-customer {
            font-weight: 500 !important;
            color: #1E293B !important;
        }

        .ord-status-text {
            font-weight: 600 !important;
            font-size: 13px !important;
        }

        .ord-status-text.pending {
            color: #B45309 !important;
        }

        .ord-status-text.delivered {
            color: #15803D !important;
        }

        .ord-status-text.transit,
        .ord-status-text.out-for-delivery {
            color: #1D4ED8 !important;
        }

        .ord-action-btn {
            background: #ffffff !important;
            border: 1.5px solid #CBD5E1 !important;
            color: #475569 !important;
            border-radius: 16px !important;
            padding: 6px 14px !important;
            font-size: 12px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            transition: all 0.15s ease !important;
        }

        .ord-action-btn:hover {
            border-color: #855335 !important;
            color: #855335 !important;
            background: #FDFBF9 !important;
        }

        @media (max-width: 768px) {
            .ord-stats-grid {
                grid-template-columns: 1fr !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- PAGE TITLE -->
    <h1 class="ord-page-title">Orders Management</h1>

    <asp:Panel ID="pnlStatus" runat="server" Visible="false" style="margin-bottom: 20px;">
        <asp:Literal ID="litStatus" runat="server" />
    </asp:Panel>

    <!-- 3 STAT CARDS ROW (MATCHING IMAGE 2) -->
    <div class="ord-stats-grid">
        <!-- CARD 1: TOTAL ORDERS -->
        <div class="ord-stat-card">
            <div class="ord-stat-header">
                <svg class="ord-stat-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                    <line x1="3" y1="6" x2="21" y2="6"></line>
                    <path d="M16 10a4 4 0 0 1-8 0"></path>
                </svg>
                <span>Total Orders</span>
            </div>
            <div class="ord-stat-value"><asp:Literal ID="litTotal" runat="server" /></div>
        </div>

        <!-- CARD 2: ACTIVE ORDERS -->
        <div class="ord-stat-card">
            <div class="ord-stat-header">
                <svg class="ord-stat-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="1" y="3" width="15" height="13"></rect>
                    <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                    <circle cx="5.5" cy="18.5" r="2.5"></circle>
                    <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
                <span>Active Orders</span>
            </div>
            <div class="ord-stat-value"><asp:Literal ID="litActive" runat="server" /></div>
        </div>

        <!-- CARD 3: PENDING ORDERS -->
        <div class="ord-stat-card">
            <div class="ord-stat-header">
                <svg class="ord-stat-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                    <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                    <line x1="12" y1="22.08" x2="12" y2="12"></line>
                </svg>
                <span>Pending Orders</span>
            </div>
            <div class="ord-stat-value"><asp:Literal ID="litPending" runat="server" /></div>
        </div>
    </div>

    <!-- RECENT ORDERS TABLE CARD (MATCHING IMAGE 2) -->
    <div class="ord-table-card">
        <div class="ord-table-header-banner">
            <h3 class="ord-table-title">Recent Orders</h3>
            <div class="ord-filter-group">
                <span>Status:</span>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="ord-status-select"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                    <asp:ListItem Text="All" Value="" />
                    <asp:ListItem Text="Pending" Value="Pending" />
                    <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                    <asp:ListItem Text="In Transit" Value="In Transit" />
                    <asp:ListItem Text="Delivered" Value="Delivered" />
                </asp:DropDownList>
            </div>
        </div>

        <table class="ord-data-table">
            <thead>
                <tr>
                    <th>ORDER ID</th>
                    <th>PRODUCT</th>
                    <th>CUSTOMER</th>
                    <th>PLACED</th>
                    <th>TOTAL</th>
                    <th>STATUS</th>
                    <th style="text-align:right;">ACTION</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td class="ord-id">#<%# Eval("OrderNumber") %></td>
                            <td class="ord-product"><%# Server.HtmlEncode(Convert.ToString(Eval("Product"))) %></td>
                            <td class="ord-customer"><%# Server.HtmlEncode(Convert.ToString(Eval("CustomerName"))) %></td>
                            <td><%# Eval("PlacedOn", "{0:MMM d, yyyy}") %></td>
                            <td style="font-weight:700;">&#8377;<%# Eval("Total", "{0:N0}") %></td>
                            <td>
                                <span class='<%# "ord-status-text " + Convert.ToString(Eval("Status")).ToLowerInvariant().Replace(" ", "-") %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </td>
                            <td style="text-align:right; white-space:nowrap;">
                                <asp:Button runat="server" CssClass="ord-action-btn"
                                    CommandName="Advance" CommandArgument='<%# Eval("OrderNumber") %>'
                                    Text='<%# Eval("NextLabel") %>' CausesValidation="false"
                                    Visible='<%# !string.IsNullOrEmpty(Convert.ToString(Eval("NextStatus"))) %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state" style="padding: 40px; text-align: center; color: #64748B;">
            No orders found with that status.
        </asp:Panel>
    </div>

</asp:Content>

