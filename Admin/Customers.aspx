<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="DevArt.Admin.Customers" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Customers</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .cust-page-title {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 24px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin: 0 0 24px 0 !important;
        }

        /* STAT CARD MATCHING IMAGE 2 */
        .cust-stat-card {
            background: #ffffff !important;
            border: 1.5px dashed #CBD5E1 !important;
            border-radius: 16px !important;
            padding: 18px 24px !important;
            width: 240px !important;
            margin-bottom: 28px !important;
            display: flex !important;
            align-items: center !important;
            gap: 16px !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02) !important;
        }

        .cust-stat-icon-box {
            width: 44px !important;
            height: 44px !important;
            border-radius: 12px !important;
            background: #F1F5F9 !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            flex-shrink: 0 !important;
        }

        .cust-stat-info {
            display: flex !important;
            flex-direction: column !important;
        }

        .cust-stat-label {
            font-size: 11px !important;
            font-weight: 800 !important;
            color: #475569 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
        }

        .cust-stat-value {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 24px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin-top: 2px !important;
        }

        /* MAIN USERS TABLE CARD MATCHING IMAGE 2 */
        .cust-table-card {
            background: #ffffff !important;
            border: 1.5px solid #E2E8F0 !important;
            border-radius: 20px !important;
            overflow: hidden !important;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03) !important;
        }

        .cust-card-header {
            background: #EBF3FE !important;
            padding: 16px 24px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            border-bottom: 1px solid #DCE7F7 !important;
        }

        .cust-card-title {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 16px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin: 0 !important;
        }

        .cust-search-box {
            display: flex !important;
            align-items: center !important;
            gap: 8px !important;
        }

        .cust-search-input {
            height: 36px !important;
            border: 1.5px solid #CBD5E1 !important;
            border-radius: 10px !important;
            padding: 0 14px !important;
            font-size: 13px !important;
            outline: none !important;
            background: #ffffff !important;
            width: 220px !important;
        }

        .cust-search-input:focus {
            border-color: #6E4125 !important;
        }

        .cust-search-btn {
            height: 36px !important;
            padding: 0 16px !important;
            border: 1.5px solid #CBD5E1 !important;
            border-radius: 10px !important;
            background: #ffffff !important;
            color: #475569 !important;
            font-size: 13px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
        }

        /* TABLE LAYOUT */
        .cust-table {
            width: 100% !important;
            border-collapse: collapse !important;
            text-align: left !important;
        }

        .cust-table th {
            background: #F8FAFC !important;
            padding: 14px 24px !important;
            font-size: 11px !important;
            font-weight: 800 !important;
            color: #475569 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
            border-bottom: 1px solid #E2E8F0 !important;
        }

        .cust-table td {
            padding: 16px 24px !important;
            font-size: 14px !important;
            color: #0F172A !important;
            vertical-align: middle !important;
            border-bottom: 1px solid #F1F5F9 !important;
        }

        /* ALTERNATING ROW BACKGROUNDS MATCHING IMAGE 2 */
        .cust-table tbody tr:nth-child(even) {
            background: #F4F7FC !important;
        }

        .cust-table tbody tr:nth-child(odd) {
            background: #ffffff !important;
        }

        .cust-table tbody tr:hover {
            background: #EDF2F7 !important;
        }

        .cust-user-name {
            font-weight: 700 !important;
            color: #0F172A !important;
        }

        .cust-user-email {
            font-weight: 500 !important;
            color: #475569 !important;
        }

        /* ACTION CIRCULAR BUTTONS MATCHING IMAGE 2 */
        .cust-actions-cell {
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
        }

        .cust-btn-icon-view {
            width: 36px !important;
            height: 36px !important;
            border-radius: 50% !important;
            background: #F4EBE3 !important;
            border: 1px solid #E6D8CE !important;
            color: #7C5235 !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            cursor: pointer !important;
            transition: transform 0.15s ease, background 0.15s ease !important;
            padding: 0 !important;
        }

        .cust-btn-icon-view:hover {
            background: #EFE4DC !important;
            transform: scale(1.05) !important;
        }

        .cust-btn-icon-delete {
            width: 36px !important;
            height: 36px !important;
            border-radius: 50% !important;
            background: #FFF1F2 !important;
            border: 1px solid #FECDD3 !important;
            color: #E11D48 !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            cursor: pointer !important;
            transition: transform 0.15s ease, background 0.15s ease !important;
            padding: 0 !important;
        }

        .cust-btn-icon-delete:hover {
            background: #FFE4E6 !important;
            transform: scale(1.05) !important;
        }

        /* FIXED POPUP OVERLAY & MODAL STYLES (CENTERED OVER SCREEN) */
        .inv-modal-overlay {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100vw !important;
            height: 100vh !important;
            background: rgba(15, 23, 42, 0.55) !important;
            backdrop-filter: blur(4px) !important;
            z-index: 999999 !important;
            display: flex;
            align-items: center !important;
            justify-content: center !important;
            padding: 20px !important;
            box-sizing: border-box !important;
        }

        .inv-modal-card {
            background: #ffffff !important;
            border-radius: 24px !important;
            width: 100% !important;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25) !important;
            overflow: hidden !important;
            position: relative !important;
            animation: custModalFadeIn 0.25s cubic-bezier(0.16, 1, 0.3, 1) !important;
        }

        @keyframes custModalFadeIn {
            from { opacity: 0; transform: scale(0.95) translateY(10px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- PAGE TITLE -->
    <h1 class="cust-page-title">Customer Management</h1>

    <asp:Panel ID="pnlStatus" runat="server" Visible="false" style="margin-bottom: 20px;">
        <asp:Literal ID="litStatus" runat="server" />
    </asp:Panel>

    <!-- TOP STAT CARD MATCHING IMAGE 2 -->
    <div class="cust-stat-card">
        <div class="cust-stat-icon-box">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#0F172A" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
            </svg>
        </div>
        <div class="cust-stat-info">
            <span class="cust-stat-label">Total Users</span>
            <div class="cust-stat-value"><asp:Literal ID="litTotal" runat="server" /></div>
            <asp:Literal ID="litSubscribed" runat="server" Visible="false" />
        </div>
    </div>

    <!-- MAIN CUSTOMER TABLE CARD MATCHING IMAGE 2 -->
    <div class="cust-table-card">
        <div class="cust-card-header">
            <h2 class="cust-card-title">All Users</h2>
            <div class="cust-search-box">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="cust-search-input" placeholder="Search name or email" />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="cust-search-btn" CausesValidation="false" OnClick="btnSearch_Click" />
            </div>
        </div>

        <table class="cust-table">
            <thead>
                <tr>
                    <th style="width: 35%;">USER NAME</th>
                    <th style="width: 45%;">EMAIL ID</th>
                    <th style="width: 20%;">OPERATIONS</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptUsers" runat="server" OnItemCommand="rptUsers_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td class="cust-user-name"><%# Server.HtmlEncode(Convert.ToString(Eval("FullName"))) %></td>
                            <td class="cust-user-email"><%# Server.HtmlEncode(Convert.ToString(Eval("Email"))) %></td>
                            <td>
                                <div class="cust-actions-cell">
                                    <asp:LinkButton runat="server" CssClass="cust-btn-icon-view" CommandName="ViewUser" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" title="View Customer Details">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                            <circle cx="12" cy="12" r="3"></circle>
                                        </svg>
                                    </asp:LinkButton>

                                    <a href="javascript:void(0);" onclick='<%# "openConfirmDeleteModal(" + Eval("Id") + ");" %>' class="cust-btn-icon-delete" title="Delete User">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="3 6 5 6 21 6"></polyline>
                                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                        </svg>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" style="padding: 40px; text-align: center; color: #64748B;">
            No users match that search.
        </asp:Panel>
    </div>

    <!-- DELETE CONFIRMATION POPUP MODAL (MATCHING IMAGE 2) -->
    <asp:Panel ID="pnlConfirmDeleteModal" runat="server" CssClass="inv-modal-overlay" style="display:none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #DC2626;">
            <asp:HiddenField ID="hfDeleteUserId" runat="server" Value="0" />

            <div style="width: 56px; height: 56px; background: #FEE2E2; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#DC2626" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                    <line x1="10" y1="11" x2="10" y2="17"></line>
                    <line x1="14" y1="11" x2="14" y2="17"></line>
                </svg>
            </div>

            <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 10px;">Delete Customer</h2>
            <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px; line-height: 1.5;">
                Are you sure you want to delete <strong>This User</strong>? This action cannot be undone.
            </p>

            <div style="display: flex; flex-direction: column; gap: 10px;">
                <asp:Button ID="btnConfirmDelete" runat="server" Text="Delete User" OnClick="btnConfirmDelete_Click" CausesValidation="false" style="width:100%; height:44px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:14px; font-weight:700; cursor:pointer;" />
                <asp:Button ID="btnCancelDelete" runat="server" Text="Cancel" OnClick="btnCancelDelete_Click" CausesValidation="false" style="width:100%; height:44px; background:#ffffff; color:#475569; border:1.5px solid #CBD5E1; border-radius:14px; font-size:14px; font-weight:700; cursor:pointer;" />
            </div>
        </div>
    </asp:Panel>

    <!-- SUCCESS DELETE POPUP MODAL (MATCHING IMAGE 1) -->
    <asp:Panel ID="pnlSuccessDeleteModal" runat="server" CssClass="inv-modal-overlay" style="display:none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #2563EB;">
            <div style="width: 56px; height: 56px; background: #D0E1FD; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#2563EB" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
            </div>

            <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 10px;">User Deleted!</h2>
            <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px;">User deleted successfully.</p>

            <asp:Button ID="btnReturnToCustomers" runat="server" Text="&larr; Return to Customer Management" OnClick="btnReturnToCustomers_Click" CausesValidation="false" style="width:100%; height:44px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:13.5px; font-weight:700; cursor:pointer;" />
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function openConfirmDeleteModal(id) {
            var hf = document.getElementById('<%= hfDeleteUserId.ClientID %>');
            var modal = document.getElementById('<%= pnlConfirmDeleteModal.ClientID %>');
            if (hf) hf.value = id;
            if (modal) modal.style.display = 'flex';
        }

        function closeConfirmDeleteModal() {
            var modal = document.getElementById('<%= pnlConfirmDeleteModal.ClientID %>');
            if (modal) modal.style.display = 'none';
        }

        function closeSuccessDeleteModal() {
            var modal = document.getElementById('<%= pnlSuccessDeleteModal.ClientID %>');
            if (modal) modal.style.display = 'none';
        }
    </script>

</asp:Content>

