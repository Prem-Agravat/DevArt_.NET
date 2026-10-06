<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Offers.aspx.cs" Inherits="DevArt.Admin.AdminOffers" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Offers</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .off-page-title {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 24px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin: 0 0 24px 0 !important;
        }

        /* 2-COLUMN CARDS GRID MATCHING IMAGE 2 */
        .off-cards-grid {
            display: grid !important;
            grid-template-columns: repeat(2, 1fr) !important;
            gap: 24px !important;
            margin-bottom: 40px !important;
        }

        @media (max-width: 860px) {
            .off-cards-grid {
                grid-template-columns: 1fr !important;
            }
        }

        .off-card {
            background: #ffffff !important;
            border: 1.5px dashed #CBD5E1 !important;
            border-radius: 20px !important;
            overflow: hidden !important;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02) !important;
            transition: transform 0.2s, box-shadow 0.2s !important;
            display: flex !important;
            flex-direction: column !important;
        }

        .off-card:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05) !important;
        }

        /* TOP BANNER WITH LIGHT BLUE BACKGROUND */
        .off-card-banner {
            background: #EBF3FE !important;
            padding: 16px 20px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            border-bottom: 1px solid #DCE7F7 !important;
        }

        .off-card-banner-left {
            display: flex !important;
            align-items: center !important;
            gap: 12px !important;
        }

        .off-card-icon-box {
            width: 36px !important;
            height: 36px !important;
            border-radius: 10px !important;
            background: #D5E5FA !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            flex-shrink: 0 !important;
        }

        .off-card-banner-text {
            display: flex !important;
            flex-direction: column !important;
        }

        .off-card-kicker {
            font-size: 10.5px !important;
            font-weight: 800 !important;
            color: #475569 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
        }

        .off-card-title {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 15.5px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin: 2px 0 0 0 !important;
        }

        /* TOGGLE SWITCH BUTTON */
        .off-toggle-btn {
            background: transparent !important;
            border: none !important;
            padding: 0 !important;
            cursor: pointer !important;
        }

        .off-toggle-track {
            width: 44px !important;
            height: 24px !important;
            border-radius: 12px !important;
            background: #6E4125 !important;
            display: flex !important;
            align-items: center !important;
            padding: 2px !important;
            box-sizing: border-box !important;
            transition: background 0.2s !important;
        }

        .off-toggle-track.inactive {
            background: #CBD5E1 !important;
        }

        .off-toggle-thumb {
            width: 20px !important;
            height: 20px !important;
            border-radius: 50% !important;
            background: #ffffff !important;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2) !important;
            margin-left: auto !important;
            transition: margin 0.2s !important;
        }

        .off-toggle-track.inactive .off-toggle-thumb {
            margin-left: 0 !important;
        }

        /* CARD BODY 2-COLUMN GRID */
        .off-card-body {
            padding: 16px 20px !important;
            display: grid !important;
            grid-template-columns: 1fr 1fr !important;
            gap: 14px 20px !important;
            flex: 1 !important;
        }

        .off-field-item {
            display: flex !important;
            flex-direction: column !important;
        }

        .off-field-label {
            font-size: 10.5px !important;
            font-weight: 800 !important;
            color: #475569 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
            margin-bottom: 2px !important;
        }

        .off-field-value {
            font-size: 13.5px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
        }

        /* CARD FOOTER ACTIONS */
        .off-card-footer {
            padding: 12px 20px 16px !important;
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
        }

        .off-btn-edit {
            flex: 1 !important;
            height: 40px !important;
            border: 1.5px solid #CBD5E1 !important;
            border-radius: 12px !important;
            background: #F4F7FC !important;
            color: #475569 !important;
            font-size: 13px !important;
            font-weight: 700 !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 6px !important;
            text-decoration: none !important;
            transition: all 0.15s ease !important;
            cursor: pointer !important;
        }

        .off-btn-edit:hover {
            border-color: #855335 !important;
            color: #855335 !important;
            background: #ffffff !important;
        }

        .off-btn-delete {
            width: 40px !important;
            height: 40px !important;
            border: 1.5px solid #FECDD3 !important;
            border-radius: 12px !important;
            background: #FFF1F2 !important;
            color: #E11D48 !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            cursor: pointer !important;
            transition: all 0.15s ease !important;
            padding: 0 !important;
        }

        .off-btn-delete:hover {
            background: #FFE4E6 !important;
            border-color: #F43F5E !important;
        }

        /* MODAL OVERLAY & POPUP STYLES MATCHING IMAGE 2 */
        .inv-modal-overlay {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100vw !important;
            height: 100vh !important;
            background: rgba(15, 23, 42, 0.55) !important;
            backdrop-filter: blur(4px) !important;
            z-index: 99999 !important;
            display: flex;
            align-items: center !important;
            justify-content: center !important;
            padding: 20px !important;
            box-sizing: border-box !important;
        }

        .off-modal-card {
            background: #ffffff !important;
            border-radius: 24px !important;
            width: 100% !important;
            max-width: 440px !important;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25) !important;
            overflow: hidden !important;
            position: relative !important;
            animation: offModalFade 0.25s cubic-bezier(0.16, 1, 0.3, 1) !important;
        }

        @keyframes offModalFade {
            from { opacity: 0; transform: scale(0.95) translateY(10px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }

        .off-modal-header {
            background: #FAF2ED !important;
            padding: 20px 24px 16px !important;
            position: relative !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            border-bottom: 1px solid #F3E8E0 !important;
        }

        .off-modal-back-btn {
            position: absolute !important;
            left: 20px !important;
            top: 50% !important;
            transform: translateY(-50%) !important;
            background: transparent !important;
            border: none !important;
            cursor: pointer !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            padding: 4px !important;
        }

        .off-modal-title {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 20px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin: 0 !important;
        }

        .off-header-leaf-bg {
            position: absolute !important;
            right: 0 !important;
            top: 0 !important;
            pointer-events: none !important;
            opacity: 0.7 !important;
        }

        .off-modal-body-container {
            padding: 24px !important;
            max-height: calc(85vh - 90px) !important;
            overflow-y: auto !important;
        }

        .off-form-group {
            display: flex !important;
            flex-direction: column !important;
            gap: 6px !important;
            margin-bottom: 14px !important;
        }

        .off-form-label {
            font-size: 12.5px !important;
            font-weight: 700 !important;
            color: #0F172A !important;
        }

        .off-input-wrapper {
            position: relative !important;
            width: 100% !important;
        }

        .off-pencil-icon {
            position: absolute !important;
            left: 14px !important;
            top: 50% !important;
            transform: translateY(-50%) !important;
            pointer-events: none !important;
        }

        .off-input-field {
            width: 100% !important;
            height: 44px !important;
            border: 1.5px solid #E6D8CE !important;
            border-radius: 14px !important;
            padding: 0 14px !important;
            font-size: 14px !important;
            font-weight: 600 !important;
            color: #0F172A !important;
            background: #ffffff !important;
            box-sizing: border-box !important;
            outline: none !important;
        }

        .off-input-field.has-icon {
            padding-left: 42px !important;
        }

        .off-input-field:focus {
            border-color: #6E4125 !important;
        }

        .off-2col-row {
            display: grid !important;
            grid-template-columns: 1fr 1fr !important;
            gap: 12px !important;
        }

        .off-settings-box {
            border: 1.5px dashed #D6C3B5 !important;
            border-radius: 16px !important;
            padding: 16px !important;
            margin: 16px 0 20px !important;
            background: #FFFDFB !important;
            display: flex !important;
            flex-direction: column !important;
            gap: 14px !important;
        }

        .off-setting-row {
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            font-size: 13.5px !important;
            font-weight: 700 !important;
            color: #5C3A21 !important;
        }

        .off-setting-left {
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
        }

        /* TOGGLE SWITCH MATCHING IMAGE 2 */
        .off-toggle-switch {
            position: relative !important;
            display: inline-block !important;
            width: 44px !important;
            height: 24px !important;
        }

        .off-toggle-switch input {
            opacity: 0 !important;
            width: 0 !important;
            height: 0 !important;
        }

        .off-slider {
            position: absolute !important;
            cursor: pointer !important;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #E2D4C7 !important;
            transition: .3s !important;
            border-radius: 24px !important;
        }

        .off-slider:before {
            position: absolute !important;
            content: "" !important;
            height: 18px !important;
            width: 18px !important;
            left: 3px !important;
            bottom: 3px !important;
            background-color: white !important;
            transition: .3s !important;
            border-radius: 50% !important;
        }

        .off-toggle-switch input:checked + .off-slider {
            background-color: #6E4125 !important;
        }

        .off-toggle-switch input:checked + .off-slider:before {
            transform: translateX(20px) !important;
        }

        .off-btn-save-primary {
            width: 100% !important;
            height: 46px !important;
            background: #6E4125 !important;
            color: #ffffff !important;
            border-radius: 14px !important;
            border: none !important;
            font-size: 14px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
        }

        .off-btn-save-primary:hover {
            background: #56331C !important;
        }

        .off-btn-delete-outline {
            width: 100% !important;
            height: 46px !important;
            background: #ffffff !important;
            color: #DC2626 !important;
            border: 1.5px solid #FECDD3 !important;
            border-radius: 14px !important;
            font-size: 14px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            margin-top: 10px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
        }

        .off-btn-delete-outline:hover {
            background: #FFF1F2 !important;
            border-color: #F43F5E !important;
        }
            background: #F8FAFC !important;
        }

        .inv-modal-title-group {
            display: flex !important;
            align-items: center !important;
            gap: 12px !important;
        }

        .inv-modal-title {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 18px !important;
            font-weight: 800 !important;
            color: #0F172A !important;
            margin: 0 !important;
        }

        .inv-modal-close-btn {
            background: transparent !important;
            border: none !important;
            color: #64748B !important;
            font-size: 20px !important;
            cursor: pointer !important;
            padding: 4px 8px !important;
            border-radius: 8px !important;
            line-height: 1 !important;
        }

        .inv-modal-body {
            padding: 20px 24px !important;
            max-height: calc(85vh - 120px) !important;
            overflow-y: auto !important;
        }

        .inv-form-grid {
            display: grid !important;
            grid-template-columns: 1fr 1fr !important;
            gap: 16px !important;
        }

        @media (max-width: 540px) {
            .inv-form-grid {
                grid-template-columns: 1fr !important;
            }
        }

        .inv-form-group {
            display: flex !important;
            flex-direction: column !important;
            gap: 6px !important;
        }

        .inv-form-group.full {
            grid-column: 1 / -1 !important;
        }

        .inv-form-label {
            font-size: 12px !important;
            font-weight: 700 !important;
            color: #475569 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
        }

        .inv-modal-input {
            width: 100% !important;
            height: 42px !important;
            border: 1.5px solid #CBD5E1 !important;
            border-radius: 12px !important;
            padding: 0 14px !important;
            font-size: 14px !important;
            color: #0F172A !important;
            background: #FFFFFF !important;
            box-sizing: border-box !important;
            outline: none !important;
            transition: border-color 0.15s ease !important;
        }

        .inv-modal-input:focus {
            border-color: #6E4125 !important;
            box-shadow: 0 0 0 3px rgba(110, 65, 37, 0.1) !important;
        }

        .inv-modal-actions {
            padding: 16px 24px 20px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: flex-end !important;
            gap: 12px !important;
            background: #F8FAFC !important;
            border-top: 1px solid #F1F5F9 !important;
        }

        .inv-modal-btn-cancel {
            height: 42px !important;
            padding: 0 20px !important;
            border: 1.5px solid #CBD5E1 !important;
            border-radius: 12px !important;
            background: #ffffff !important;
            color: #475569 !important;
            font-size: 14px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
        }

        .inv-modal-btn-save {
            height: 42px !important;
            padding: 0 24px !important;
            border: none !important;
            border-radius: 12px !important;
            background: #6E4125 !important;
            color: #ffffff !important;
            font-size: 14px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
        }

        .inv-modal-btn-save:hover {
            background: #56331C !important;
        }

        /* FAB FLOATING BUTTON */
        .inv-fab-add-btn {
            position: fixed !important;
            bottom: 32px !important;
            right: 32px !important;
            width: 56px !important;
            height: 56px !important;
            border-radius: 28px !important;
            background: #6E4125 !important;
            box-shadow: 0 10px 25px rgba(110, 65, 37, 0.4) !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            cursor: pointer !important;
            z-index: 900 !important;
            transition: transform 0.2s, background 0.2s !important;
            text-decoration: none !important;
        }

        .inv-fab-add-btn:hover {
            transform: scale(1.08) !important;
            background: #56331C !important;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- PAGE TITLE -->
    <h1 class="off-page-title">Offers Management</h1>

    <asp:Panel ID="pnlStatus" runat="server" Visible="false" style="margin-bottom: 20px;">
        <asp:Literal ID="litStatus" runat="server" />
    </asp:Panel>

    <!-- 2-COLUMN OFFERS CARDS GRID (MATCHING IMAGE 2) -->
    <div class="off-cards-grid">
        <asp:Repeater ID="rptOffers" runat="server" OnItemCommand="rptOffers_ItemCommand">
            <ItemTemplate>
                <div class="off-card">
                    <!-- TOP BANNER WITH TITLE AND TOGGLE SWITCH -->
                    <div class="off-card-banner">
                        <div class="off-card-banner-left">
                            <div class="off-card-icon-box">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#4B6B94" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path>
                                    <line x1="7" y1="7" x2="7.01" y2="7"></line>
                                </svg>
                            </div>
                            <div class="off-card-banner-text">
                                <span class="off-card-kicker"><%# Server.HtmlEncode(Convert.ToString(Eval("Kicker"))) %></span>
                                <h3 class="off-card-title"><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></h3>
                            </div>
                        </div>

                        <!-- INTERACTIVE TOGGLE SWITCH -->
                        <asp:LinkButton runat="server" CommandName="ToggleActive" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" CssClass="off-toggle-btn" title="Toggle Status">
                            <div class='<%# (bool)Eval("IsActive") ? "off-toggle-track" : "off-toggle-track inactive" %>'>
                                <div class="off-toggle-thumb"></div>
                            </div>
                        </asp:LinkButton>
                    </div>

                    <!-- CARD BODY DETAILS GRID -->
                    <div class="off-card-body">
                        <div class="off-field-item">
                            <span class="off-field-label">Discount</span>
                            <span class="off-field-value"><%# Eval("DiscountLabel") %></span>
                        </div>
                        <div class="off-field-item">
                            <span class="off-field-label">Expiry Date</span>
                            <span class="off-field-value"><%# Eval("ExpiresOn", "{0:MMM d, yyyy}").ToUpper() %></span>
                        </div>
                        <div class="off-field-item">
                            <span class="off-field-label">Promo Code</span>
                            <span class="off-field-value"><%# Eval("Code") %></span>
                        </div>
                        <div class="off-field-item">
                            <span class="off-field-label">Min. Spend</span>
                            <span class="off-field-value">&#8377;<%# Eval("MinimumSpend", "{0:N0}") %></span>
                        </div>
                    </div>

                    <!-- FOOTER ACTIONS ROW (EDIT & DELETE) -->
                    <div class="off-card-footer">
                        <asp:LinkButton runat="server" CssClass="off-btn-edit" CommandName="EditOffer" CommandArgument='<%# Eval("Id") %>' CausesValidation="false">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 20h9"></path>
                                <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                            </svg>
                            <span>Edit</span>
                        </asp:LinkButton>

                        <asp:LinkButton runat="server" CssClass="off-btn-delete"
                            CausesValidation="false" title="Delete Offer"
                            OnClientClick='<%# "openConfirmDeleteOfferModal(" + Eval("Id") + "); return false;" %>'>
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <polyline points="3 6 5 6 21 6"></polyline>
                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            </svg>
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state" style="padding:40px; text-align:center; color:#64748B;">
        No offers configured yet.
    </asp:Panel>

    <!-- FLOATING (+) ACTION BUTTON FOR ADD OFFER -->
    <a href="javascript:void(0);" onclick="openAddOfferModal();" class="inv-fab-add-btn" title="Add New Offer">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
    </a>

    <!-- ADD / EDIT OFFER MODAL POPUP (STRICTLY MATCHING USER IMAGE 2) -->
    <asp:Panel ID="pnlOfferModal" runat="server" CssClass="inv-modal-overlay" style="display:none;">
        <div class="off-modal-card">
            
            <!-- WARM BEIGE HEADER WITH FLORAL OVERLAY AND BACK ARROW -->
            <div class="off-modal-header">
                <asp:LinkButton ID="btnCloseModal" runat="server" OnClick="btnCancelModal_Click" CausesValidation="false" CssClass="off-modal-back-btn" title="Back">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#0F172A" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </asp:LinkButton>
                <h2 class="off-modal-title"><asp:Label ID="lblModalTitle" runat="server" Text="Edit Offer" /></h2>
                
                <div class="off-header-leaf-bg">
                    <svg width="90" height="60" viewBox="0 0 90 60" fill="none">
                        <path d="M10 5 C 30 20, 50 10, 70 30 C 50 45, 25 30, 10 5 Z" fill="#E8D9CD" opacity="0.4" />
                        <path d="M25 25 C 45 40, 65 30, 85 50 C 65 65, 40 50, 25 25 Z" fill="#DFC9B9" opacity="0.3" />
                    </svg>
                </div>
            </div>

            <!-- MODAL FORM CONTENT -->
            <div class="off-modal-body-container">
                <asp:HiddenField ID="hfOfferId" runat="server" Value="0" />

                <asp:Panel ID="pnlModalError" runat="server" Visible="false" Style="margin-bottom: 16px; padding: 12px; background: #FEF2F2; border: 1px solid #FECDD3; border-radius: 12px; color: #991B1B; font-size: 13px;">
                    <asp:Literal ID="litModalError" runat="server" />
                </asp:Panel>

                <!-- OFFER NAME FIELD WITH PENCIL ICON -->
                <div class="off-form-group">
                    <label class="off-form-label">Offer Name</label>
                    <div class="off-input-wrapper">
                        <svg class="off-pencil-icon" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#6E4125" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 20h9"></path>
                            <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                        </svg>
                        <asp:TextBox ID="txtKicker" runat="server" CssClass="off-input-field has-icon" placeholder="e.g. WELCOME OFFER" />
                    </div>
                </div>

                <!-- OFFER TITLE FIELD WITH PENCIL ICON -->
                <div class="off-form-group">
                    <label class="off-form-label">Offer Title</label>
                    <div class="off-input-wrapper">
                        <svg class="off-pencil-icon" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#6E4125" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 20h9"></path>
                            <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                        </svg>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="off-input-field has-icon" placeholder="e.g. 15% OFF First Order" />
                    </div>
                </div>

                <!-- PROMO CODE FIELD -->
                <div class="off-form-group">
                    <label class="off-form-label">Promo Code</label>
                    <asp:TextBox ID="txtCode" runat="server" CssClass="off-input-field" placeholder="FREESHIP150" style="max-width: 200px !important;" />
                </div>

                <!-- DISCOUNT VALUE FIELD (VISIBLE WHEN PERCENTAGE OR FLAT) -->
                <asp:Panel ID="pnlValue" runat="server" CssClass="off-form-group">
                    <label class="off-form-label"><asp:Label ID="lblValueLabel" runat="server" Text="Discount" /></label>
                    <asp:TextBox ID="txtDiscountValue" runat="server" CssClass="off-input-field" placeholder="15%" />
                </asp:Panel>

                <!-- DISCOUNT TYPE DROPDOWN -->
                <div class="off-form-group">
                    <label class="off-form-label">Discount Type</label>
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="off-input-field" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                        <asp:ListItem Text="Percentage Off" Value="Percentage" />
                        <asp:ListItem Text="Flat Amount Off (₹)" Value="Flat" />
                        <asp:ListItem Text="Free Delivery" Value="FreeShipping" />
                    </asp:DropDownList>
                </div>

                <!-- EXPIRATION DATE WITH CALENDAR ICON -->
                <div class="off-form-group">
                    <label class="off-form-label">Expiration Date</label>
                    <div class="off-input-wrapper">
                        <svg class="off-pencil-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#6E4125" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                            <line x1="16" y1="2" x2="16" y2="6"></line>
                            <line x1="8" y1="2" x2="8" y2="6"></line>
                            <line x1="3" y1="10" x2="21" y2="10"></line>
                        </svg>
                        <asp:TextBox ID="txtExpiry" runat="server" CssClass="off-input-field has-icon" TextMode="Date" />
                    </div>
                </div>

                <!-- DASHED SETTINGS CONTAINER MATCHING IMAGE 2 -->
                <div class="off-settings-box">
                    
                    <!-- ACTIVE TOGGLE -->
                    <div class="off-setting-row">
                        <div class="off-setting-left">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#6E4125" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="6" width="20" height="12" rx="6"></rect>
                                <circle cx="8" cy="12" r="3"></circle>
                            </svg>
                            <span>Active</span>
                        </div>
                        <label class="off-toggle-switch">
                            <asp:CheckBox ID="chkActive" runat="server" Checked="true" />
                            <span class="off-slider"></span>
                        </label>
                    </div>

                    <!-- ONE-TIME USE ONLY TOGGLE -->
                    <div class="off-setting-row">
                        <div class="off-setting-left">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#6E4125" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                            </svg>
                            <span>One-time use only</span>
                        </div>
                        <label class="off-toggle-switch">
                            <asp:CheckBox ID="chkOneTime" runat="server" />
                            <span class="off-slider"></span>
                        </label>
                    </div>

                    <!-- MIN SPEND LIMIT -->
                    <div class="off-setting-row">
                        <div class="off-setting-left">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#6E4125" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="9" cy="21" r="1"></circle>
                                <circle cx="20" cy="21" r="1"></circle>
                                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                            </svg>
                            <span>Min. Spend Limit</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 4px;">
                            <span style="font-weight: 800; color: #6E4125;">&#8377;</span>
                            <asp:TextBox ID="txtMinSpend" runat="server" CssClass="off-input-field" style="width: 80px !important; height: 32px !important; padding: 0 8px !important; font-size: 13px !important; font-weight: 700 !important; text-align: right !important;" Text="0" />
                        </div>
                    </div>

                </div>

                <!-- FOOTER BUTTONS -->
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <asp:Button ID="btnSaveOfferModal" runat="server" Text="Update Changes" CssClass="off-btn-save-primary" OnClick="btnSaveOfferModal_Click" CausesValidation="false" />
                    
                    <asp:Button ID="btnDeleteOfferModal" runat="server" Text="Delete Offer" CssClass="off-btn-delete-outline" OnClick="btnDeleteOfferModal_Click" CausesValidation="false" OnClientClick="openConfirmDeleteOfferFromEditModal(); return false;" />
                </div>

            </div>
        </div>
    </asp:Panel>

    <!-- SUCCESS POPUP CONFIRMATION MODAL (STRICTLY MATCHING USER IMAGE 2 FOR SAVE/UPDATE) -->
    <asp:Panel ID="pnlSuccessModal" runat="server" CssClass="inv-modal-overlay" style="display:none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #2563EB; background: #ffffff; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
            <div style="width: 56px; height: 56px; background: #DBEAFE; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#2563EB" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
            </div>

            <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 8px;">
                <asp:Label ID="lblSuccessTitle" runat="server" Text="Offer Updated!" />
            </h2>
            <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px;">
                <asp:Label ID="lblSuccessSub" runat="server" Text="successfully Updated." />
            </p>

            <asp:Button ID="btnBackToOffers" runat="server" Text="&larr; Return to Offer" OnClick="btnBackToOffers_Click" CausesValidation="false" style="width:100%; height:46px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:14px; font-weight:700; cursor:pointer;" />
        </div>
    </asp:Panel>

    <!-- DELETE CONFIRMATION POPUP MODAL FOR OFFERS (STRICTLY MATCHING USER IMAGE 1) -->
    <asp:Panel ID="pnlConfirmDeleteOfferModal" runat="server" CssClass="inv-modal-overlay" style="display:none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #DC2626; background: #ffffff; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
            <asp:HiddenField ID="hfDeleteOfferId" runat="server" Value="0" />

            <div style="width: 56px; height: 56px; background: #FEE2E2; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#DC2626" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                    <line x1="10" y1="11" x2="10" y2="17"></line>
                    <line x1="14" y1="11" x2="14" y2="17"></line>
                </svg>
            </div>

            <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 10px;">Delete Offer</h2>
            <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px; line-height: 1.5;">
                Are you sure you want to delete<br />
                <strong>This Offer? This action<br />cannot be undone.</strong>
            </p>

            <div style="display: flex; flex-direction: column; gap: 10px;">
                <asp:Button ID="btnConfirmDeleteOffer" runat="server" Text="Delete Offer" OnClick="btnConfirmDeleteOffer_Click" CausesValidation="false" style="width:100%; height:46px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:14px; font-weight:700; cursor:pointer;" />
                <asp:Button ID="btnCancelDeleteOffer" runat="server" Text="Cancel" OnClick="btnCancelDeleteOffer_Click" OnClientClick="closeConfirmDeleteOfferModal(); return false;" CausesValidation="false" style="width:100%; height:46px; background:#ffffff; color:#334155; border:1.5px solid #CBD5E1; border-radius:14px; font-size:14px; font-weight:700; cursor:pointer;" />
            </div>
        </div>
    </asp:Panel>

    <!-- OFFER DELETED SUCCESS POPUP MODAL (STRICTLY MATCHING USER IMAGE 2) -->
    <asp:Panel ID="pnlSuccessDeleteOfferModal" runat="server" CssClass="inv-modal-overlay" style="display:none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #2563EB; background: #ffffff; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
            <div style="width: 56px; height: 56px; background: #DBEAFE; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#2563EB" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
            </div>

            <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 8px;">Offer Deleted!</h2>
            <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px;">Offer deleted successfully.</p>

            <asp:Button ID="btnReturnToOffersAfterDelete" runat="server" Text="&larr; Return to Inventory Management" OnClick="btnReturnToOffersAfterDelete_Click" OnClientClick="closeSuccessDeleteOfferModal(); return false;" CausesValidation="false" style="width:100%; height:46px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:14px; font-weight:700; cursor:pointer;" />
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function openAddOfferModal() {
            var modal = document.getElementById('<%= pnlOfferModal.ClientID %>');
            if (modal) {
                document.getElementById('<%= hfOfferId.ClientID %>').value = '0';
                document.getElementById('<%= lblModalTitle.ClientID %>').innerText = 'Add Offer';
                document.getElementById('<%= txtKicker.ClientID %>').value = '';
                document.getElementById('<%= txtTitle.ClientID %>').value = '';
                document.getElementById('<%= txtCode.ClientID %>').value = '';
                document.getElementById('<%= txtDiscountValue.ClientID %>').value = '';
                document.getElementById('<%= txtMinSpend.ClientID %>').value = '0';
                var btnSave = document.getElementById('<%= btnSaveOfferModal.ClientID %>');
                if (btnSave) btnSave.value = 'Add Offer';
                var btnDel = document.getElementById('<%= btnDeleteOfferModal.ClientID %>');
                if (btnDel) btnDel.style.display = 'none';
                modal.style.display = 'flex';
            }
        }

        function closeOfferModal() {
            var modal = document.getElementById('<%= pnlOfferModal.ClientID %>');
            if (modal) modal.style.display = 'none';
        }

        function closeSuccessModal() {
            var modal = document.getElementById('<%= pnlSuccessModal.ClientID %>');
            if (modal) modal.style.display = 'none';
        }

        function openConfirmDeleteOfferModal(id) {
            var hf = document.getElementById('<%= hfDeleteOfferId.ClientID %>');
            if (hf) hf.value = id;

            var offModal = document.getElementById('<%= pnlOfferModal.ClientID %>');
            if (offModal) offModal.style.display = 'none';

            var delModal = document.getElementById('<%= pnlConfirmDeleteOfferModal.ClientID %>');
            if (delModal) delModal.style.display = 'flex';
        }

        function openConfirmDeleteOfferFromEditModal() {
            var hf = document.getElementById('<%= hfOfferId.ClientID %>');
            var id = hf ? hf.value : '0';
            openConfirmDeleteOfferModal(id);
        }

        function closeConfirmDeleteOfferModal() {
            var delModal = document.getElementById('<%= pnlConfirmDeleteOfferModal.ClientID %>');
            if (delModal) delModal.style.display = 'none';
        }

        function closeSuccessDeleteOfferModal() {
            var succModal = document.getElementById('<%= pnlSuccessDeleteOfferModal.ClientID %>');
            if (succModal) succModal.style.display = 'none';
        }
    </script>

</asp:Content>


