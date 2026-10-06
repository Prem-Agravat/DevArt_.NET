<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="DevArt.Admin.Inventory" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Inventory</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .prod-modal-overlay {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100vw !important;
            height: 100vh !important;
            background: rgba(18, 14, 12, 0.55) !important;
            backdrop-filter: blur(4px) !important;
            z-index: 999999 !important;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            box-sizing: border-box;
            overflow-y: auto;
        }

        .prod-modal-container {
            background: #ffffff !important;
            width: 100% !important;
            max-width: 440px !important;
            border-radius: 24px !important;
            box-shadow: 0 24px 64px rgba(0, 0, 0, 0.25) !important;
            overflow: hidden !important;
            margin: auto !important;
            position: relative !important;
            font-family: 'DM Sans', sans-serif !important;
            border: 1px solid rgba(255, 255, 255, 0.6) !important;
        }

        .prod-modal-banner {
            background: linear-gradient(135deg, #FBF4EE 0%, #F4EBE3 100%) !important;
            padding: 16px 20px !important;
            text-align: center !important;
            position: relative !important;
            border-bottom: 1px solid #EFE5DC !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            min-height: 54px !important;
        }

        .prod-modal-floral-bg {
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            pointer-events: none !important;
            opacity: 0.65 !important;
        }

        .prod-modal-title {
            font-family: 'Playfair Display', Georgia, serif !important;
            font-size: 19px !important;
            font-weight: 700 !important;
            color: #2D1E18 !important;
            margin: 0 !important;
            line-height: 1.2 !important;
        }

        .prod-modal-close-btn {
            position: absolute !important;
            right: 16px !important;
            top: 50% !important;
            transform: translateY(-50%) !important;
            background: #EFE4DC !important;
            border: none !important;
            width: 32px !important;
            height: 32px !important;
            border-radius: 50% !important;
            color: #5C4033 !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            cursor: pointer !important;
            text-decoration: none !important;
        }

        .prod-modal-body {
            padding: 18px 22px 22px !important;
            display: flex !important;
            flex-direction: column !important;
            gap: 12px !important;
            max-height: calc(88vh - 60px) !important;
            overflow-y: auto !important;
        }

        .prod-photo-grid {
            display: grid !important;
            grid-template-columns: 1fr 66px !important;
            gap: 12px !important;
            margin-bottom: 2px !important;
        }

        .prod-photo-section {
            display: flex !important;
            flex-direction: column !important;
            gap: 12px !important;
            margin-bottom: 14px !important;
        }

        .prod-photo-main {
            border: 1.5px dashed #CBD5E1 !important;
            border-radius: 16px !important;
            background: #FAF7F4 !important;
            padding: 12px !important;
            text-align: center !important;
            cursor: pointer !important;
            position: relative !important;
            min-height: 160px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            overflow: hidden !important;
        }

        .prod-photo-update-badge {
            position: absolute !important;
            bottom: 10px !important;
            left: 50% !important;
            transform: translateX(-50%) !important;
            background: #6E4125 !important;
            color: #ffffff !important;
            font-size: 11px !important;
            font-weight: 700 !important;
            padding: 5px 14px !important;
            border-radius: 20px !important;
            display: flex !important;
            align-items: center !important;
            gap: 6px !important;
            box-shadow: 0 4px 10px rgba(110, 65, 37, 0.3) !important;
        }

        .prod-photo-thumbs-row {
            display: grid !important;
            grid-template-columns: repeat(3, 1fr) !important;
            gap: 12px !important;
        }

        .prod-thumb-box {
            height: 60px !important;
            border: 1.5px dashed #CBD5E1 !important;
            border-radius: 12px !important;
            background: #ffffff !important;
            overflow: hidden !important;
            cursor: pointer !important;
            transition: all 0.15s ease !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }

        .prod-thumb-box.active {
            border: 2px solid #6E4125 !important;
            box-shadow: 0 0 0 2px rgba(110, 65, 37, 0.18) !important;
        }

        .prod-thumb-img {
            width: 100% !important;
            height: 100% !important;
            object-fit: cover !important;
        }

        .prod-field-group {
            display: flex !important;
            flex-direction: column !important;
            width: 100% !important;
        }

        .prod-field-label {
            font-size: 12.5px !important;
            font-weight: 700 !important;
            color: #2D1E18 !important;
            margin-bottom: 5px !important;
            display: block !important;
        }

        .prod-input-icon-wrapper {
            position: relative !important;
            width: 100% !important;
        }

        .prod-input-pencil-icon {
            position: absolute !important;
            left: 14px !important;
            top: 50% !important;
            transform: translateY(-50%) !important;
            stroke: #7C5235 !important;
            pointer-events: none !important;
        }

        .prod-modal-input {
            width: 100% !important;
            height: 42px !important;
            border: 1.5px solid #E5DCD5 !important;
            border-radius: 12px !important;
            padding: 0 14px !important;
            font-size: 13.5px !important;
            color: #2D1E18 !important;
            background: #ffffff !important;
            box-sizing: border-box !important;
            font-family: inherit !important;
        }

        .prod-modal-input.prod-has-icon {
            padding-left: 38px !important;
        }

        .prod-form-row {
            display: grid !important;
            grid-template-columns: 1fr 1fr !important;
            gap: 12px !important;
        }

        .prod-modal-select {
            width: 100% !important;
            height: 42px !important;
            border: 1.5px solid #E5DCD5 !important;
            border-radius: 12px !important;
            padding: 0 14px !important;
            font-size: 13px !important;
            color: #2D1E18 !important;
            background: #ffffff url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%237C5235' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") no-repeat right 14px center !important;
            -webkit-appearance: none !important;
            appearance: none !important;
            box-sizing: border-box !important;
        }

        .prod-modal-textarea {
            width: 100% !important;
            border: 1.5px solid #E5DCD5 !important;
            border-radius: 12px !important;
            padding: 10px 14px !important;
            font-size: 13.5px !important;
            color: #2D1E18 !important;
            background: #ffffff !important;
            box-sizing: border-box !important;
            resize: vertical !important;
        }

        .prod-stock-control {
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
        }

        .prod-stock-btn {
            width: 40px !important;
            height: 40px !important;
            border-radius: 10px !important;
            background: #EFE8E2 !important;
            border: none !important;
            font-size: 18px !important;
            font-weight: bold !important;
            color: #4A3427 !important;
            cursor: pointer !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            flex-shrink: 0 !important;
        }

        .prod-modal-stock-input {
            flex: 1 !important;
            text-align: center !important;
            font-weight: 700 !important;
            font-size: 15px !important;
            height: 40px !important;
            border: 1.5px solid #E5DCD5 !important;
            border-radius: 12px !important;
            color: #2D1E18 !important;
        }

        .prod-checkbox-label {
            display: flex !important;
            align-items: center !important;
            gap: 8px !important;
            font-size: 13px !important;
            font-weight: 600 !important;
            color: #2D1E18 !important;
            cursor: pointer !important;
        }

        .prod-modal-footer {
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            gap: 10px !important;
            margin-top: 18px !important;
            padding-top: 14px !important;
            border-top: 1px solid #F1F5F9 !important;
        }

        .prod-modal-btn-delete {
            height: 42px !important;
            padding: 0 16px !important;
            border: 1.5px solid #FECDD3 !important;
            border-radius: 12px !important;
            background: #ffffff !important;
            color: #E11D48 !important;
            font-size: 13px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            transition: all 0.15s ease !important;
            display: inline-flex !important;
            align-items: center !important;
            gap: 6px !important;
        }

        .prod-modal-btn-delete:hover {
            background: #FFF1F2 !important;
            border-color: #F43F5E !important;
        }

        .prod-modal-btn-cancel {
            height: 42px !important;
            padding: 0 18px !important;
            border: 1.5px solid #CBD5E1 !important;
            border-radius: 12px !important;
            background: #ffffff !important;
            color: #475569 !important;
            font-size: 13px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
        }

        .prod-modal-btn-save {
            height: 42px !important;
            padding: 0 22px !important;
            border: none !important;
            border-radius: 12px !important;
            background: #6E4125 !important;
            color: #ffffff !important;
            font-size: 13.5px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            display: inline-flex !important;
            align-items: center !important;
            gap: 8px !important;
            box-shadow: 0 4px 14px rgba(110, 65, 37, 0.25) !important;
            margin-left: auto !important;
        }

        .prod-modal-btn-save:hover {
            background: #56331C !important;
        }

        /* SUCCESS POPUP MODAL STYLES (MATCHING IMAGE 2) */
        .prod-success-container {
            background: #ffffff !important;
            width: 100% !important;
            max-width: 310px !important;
            border-radius: 24px !important;
            box-shadow: 0 24px 64px rgba(0, 0, 0, 0.25) !important;
            overflow: hidden !important;
            margin: auto !important;
            position: relative !important;
            font-family: 'DM Sans', sans-serif !important;
            text-align: center !important;
        }

        .prod-success-top-bar {
            height: 4px !important;
            background: #855335 !important;
            width: 100% !important;
        }

        .prod-success-body {
            padding: 28px 22px 24px !important;
            display: flex !important;
            flex-direction: column !important;
            align-items: center !important;
        }

        .prod-success-icon-circle {
            width: 60px !important;
            height: 60px !important;
            border-radius: 50% !important;
            background: #D8EAFF !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            margin-bottom: 16px !important;
        }

        .prod-success-check-badge {
            width: 30px !important;
            height: 30px !important;
            border-radius: 50% !important;
            background: #855335 !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }

        .prod-success-title {
            font-family: 'DM Sans', sans-serif !important;
            font-size: 20px !important;
            font-weight: 800 !important;
            color: #1E1511 !important;
            margin: 0 0 6px 0 !important;
        }

        .prod-success-sub {
            font-size: 13.5px !important;
            color: #4A3A31 !important;
            margin: 0 0 24px 0 !important;
            font-weight: 500 !important;
        }

        .prod-success-btn {
            width: 100% !important;
            height: 44px !important;
            border-radius: 20px !important;
            background: #855335 !important;
            color: #ffffff !important;
            border: none !important;
            font-size: 14px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            box-shadow: 0 4px 14px rgba(133, 83, 53, 0.3) !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            text-decoration: none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- PAGE TITLE -->
    <h1 class="inv-page-title">Inventory Management</h1>

    <asp:Panel ID="pnlStatus" runat="server" Visible="false" style="margin-bottom: 20px;">
        <asp:Literal ID="litStatus" runat="server" />
    </asp:Panel>

    <!-- CATEGORY CHIPS ROW -->
    <div class="inv-chips-row">
        <asp:Repeater ID="rptChips" runat="server">
            <ItemTemplate>
                <a class='inv-chip <%# Eval("Css") %>'
                   href='<%# "Inventory.aspx?category=" + Server.UrlEncode(Convert.ToString(Eval("Value"))) %>'>
                    <%# Server.HtmlEncode(Convert.ToString(Eval("Text"))) %>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- PRODUCT CARDS GRID -->
    <div class="inv-cards-grid">
        <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
            <ItemTemplate>
                <div class="inv-product-card">
                    <div class="inv-card-left">
                        <img src='<%# FormatImageUrl(Eval("Image")) %>' alt="Product" class="inv-card-thumb" />
                        <div class="inv-card-details">
                            <h4 class="inv-card-title"><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></h4>
                            <p class="inv-card-sub"><%# Server.HtmlEncode(Convert.ToString(Eval("Material"))) %></p>
                            <div class="inv-card-price">&#8377;<%# Eval("Price", "{0:N0}") %></div>
                        </div>
                    </div>
                    <div class="inv-card-actions">
                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false"
                            OnClientClick='<%# "openConfirmDeleteModal(" + Eval("Id") + "); return false;" %>' CssClass="inv-trash-btn" title="Delete Product">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#888888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditProduct" CommandArgument='<%# Eval("Id") %>'
                            CausesValidation="false" CssClass="inv-edit-circle-btn" title="Edit Product">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="prof-empty-card" style="text-align:center;padding:40px;margin-top:30px;">
        <h3>No products in this category yet.</h3>
    </asp:Panel>

    <!-- FLOATING (+) ACTION BUTTON -->
    <a href="javascript:void(0);" onclick="openAddModal();" class="inv-fab-add-btn" title="Add New Product">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
    </a>
    <asp:LinkButton ID="btnAddProductFab" runat="server" OnClick="btnAddProductFab_Click" CausesValidation="false" Style="display:none;" />


    <!-- ADD / EDIT PRODUCT MODAL POPUP -->
    <div id="pnlProductModal" runat="server" class="prod-modal-overlay" style="display: none;">
        <div class="prod-modal-container">
            
            <!-- HEADER DECORATIVE BANNER WITH FLORAL PATTERN -->
            <div class="prod-modal-banner">
                <svg class="prod-modal-floral-bg" width="120" height="90" viewBox="0 0 120 90" fill="none">
                    <path d="M15 10 C 30 25, 45 10, 60 30 C 40 45, 20 30, 15 10 Z" fill="#E8D9CD" opacity="0.4" />
                    <path d="M5 40 C 25 35, 35 55, 55 45 C 35 65, 15 55, 5 40 Z" fill="#DFC9B9" opacity="0.35" />
                    <circle cx="20" cy="20" r="14" fill="#EAE0D6" opacity="0.5" />
                    <circle cx="45" cy="15" r="8" fill="#E2D4C7" opacity="0.4" />
                </svg>

                <h2 id="lblModalTitle" runat="server" class="prod-modal-title">Add New Product</h2>
                <asp:LinkButton ID="btnCloseModalX" runat="server" CausesValidation="false" OnClick="btnCancelModal_Click" OnClientClick="closeModal(); return false;" CssClass="prod-modal-close-btn" title="Close">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                </asp:LinkButton>
            </div>

            <!-- MODAL FORM CONTENT -->
            <div class="prod-modal-body">
                <asp:HiddenField ID="hfProductId" runat="server" Value="0" />
                <asp:HiddenField ID="hfSelectedImage" runat="server" Value="category_torans.jpg" />

                <asp:ValidationSummary ID="vsProduct" runat="server"
                    ValidationGroup="ProductModal" CssClass="validation-summary"
                    HeaderText="Please check the following items:" DisplayMode="BulletList" />

                <!-- PHOTO UPLOAD / SELECTION SECTION (MATCHING IMAGE 2) -->
                <div class="prod-photo-section">
                    <!-- MAIN BIG PHOTO BOX -->
                    <div class="prod-photo-main" onclick="triggerImagePicker();">
                        <div id="imgPreviewBox" class="prod-photo-preview-wrap">
                            <div class="prod-camera-circle">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#684A35" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path>
                                    <circle cx="12" cy="13" r="4"></circle>
                                </svg>
                            </div>
                            <span class="prod-photo-prompt">Tap to upload product photo</span>
                        </div>
                    </div>

                    <!-- 3 THUMBNAILS HORIZONTAL ROW BELOW MAIN PHOTO -->
                    <div class="prod-photo-thumbs-row">
                        <div class="prod-thumb-box active" onclick="selectPresetImage('category_torans.jpg', this)" title="Torans">
                            <img src="../Images/category_torans.jpg" alt="Torans" class="prod-thumb-img" />
                        </div>
                        <div class="prod-thumb-box" onclick="selectPresetImage('product_velvet_pillow.jpg', this)" title="Velvet Pillow">
                            <img src="../Images/product_velvet_pillow.jpg" alt="Velvet Pillow" class="prod-thumb-img" />
                        </div>
                        <div class="prod-thumb-box" onclick="selectPresetImage('product_ceramic_vase.jpg', this)" title="Ceramic Vase">
                            <img src="../Images/product_ceramic_vase.jpg" alt="Ceramic Vase" class="prod-thumb-img" />
                        </div>
                    </div>
                </div>

                <!-- PRODUCT NAME FIELD WITH PENCIL ICON -->
                <div class="prod-field-group">
                    <label class="prod-field-label">Product Name<span class="req">*</span></label>
                    <div class="prod-input-icon-wrapper">
                        <svg class="prod-input-pencil-icon" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#7C5235" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 20h9"></path>
                            <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                        </svg>
                        <asp:TextBox ID="txtName" runat="server" CssClass="prod-modal-input prod-has-icon"
                            MaxLength="80" placeholder="e.g. Handcrafted Ceramic Vase" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server"
                        ControlToValidate="txtName" ValidationGroup="ProductModal"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Product name is required."
                        Text="Product name is required." />
                    <asp:CustomValidator ID="cvName" runat="server"
                        ControlToValidate="txtName" ValidationGroup="ProductModal"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvName_ServerValidate"
                        ErrorMessage="Another product already uses that name."
                        Text="That name is already taken." />
                </div>

                <!-- CATEGORY & PRICE (2 COLUMN GRID) -->
                <div class="prod-form-row">
                    <div class="prod-field-group">
                        <label class="prod-field-label">Category<span class="req">*</span></label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="prod-modal-select">
                            <asp:ListItem Text="-- Select a category --" Value="" />
                            <asp:ListItem Text="Torans" Value="Torans" />
                            <asp:ListItem Text="Cushion Covers" Value="Cushion Covers" />
                            <asp:ListItem Text="Sofa &amp; Table Covers" Value="Sofa &amp; Table Covers" />
                            <asp:ListItem Text="Bedsheet" Value="Bedsheet" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server"
                            ControlToValidate="ddlCategory" InitialValue="" ValidationGroup="ProductModal"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Please choose a category."
                            Text="Please choose a category." />
                    </div>

                    <div class="prod-field-group">
                        <label class="prod-field-label">Price (&#8377;)<span class="req">*</span></label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="prod-modal-input" placeholder="0.00" />
                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server"
                            ControlToValidate="txtPrice" ValidationGroup="ProductModal"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Price is required."
                            Text="Price is required." />
                        <asp:RangeValidator ID="rngPrice" runat="server"
                            ControlToValidate="txtPrice" ValidationGroup="ProductModal"
                            Type="Currency" MinimumValue="1" MaximumValue="100000"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Price must be a number between 1 and 100000."
                            Text="Price must be 1-100000." />
                    </div>
                </div>

                <!-- STOCK QUANTITY WITH (-) AND (+) BUTTONS -->
                <div class="prod-field-group">
                    <label class="prod-field-label">Stock Quantity<span class="req">*</span></label>
                    <div class="prod-stock-control">
                        <button type="button" class="prod-stock-btn" onclick="adjustStock(-1);">-</button>
                        <asp:TextBox ID="txtStock" runat="server" CssClass="prod-modal-stock-input" Text="1" MaxLength="4" ClientIDMode="Static" />
                        <button type="button" class="prod-stock-btn" onclick="adjustStock(1);">+</button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvStock" runat="server"
                        ControlToValidate="txtStock" ValidationGroup="ProductModal"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Stock quantity is required."
                        Text="Stock quantity is required." />
                    <asp:RangeValidator ID="rngStock" runat="server"
                        ControlToValidate="txtStock" ValidationGroup="ProductModal"
                        Type="Integer" MinimumValue="0" MaximumValue="9999"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Stock must be 0 to 9999."
                        Text="Stock must be 0-9999." />
                </div>

                <!-- DESCRIPTION -->
                <div class="prod-field-group">
                    <label class="prod-field-label">Description<span class="req">*</span></label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="prod-modal-textarea"
                        TextMode="MultiLine" Rows="3" placeholder="Tell the story behind this piece..." />
                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server"
                        ControlToValidate="txtDescription" ValidationGroup="ProductModal"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Description is required."
                        Text="Description is required." />
                    <asp:CustomValidator ID="cvDescription" runat="server"
                        ControlToValidate="txtDescription" ValidationGroup="ProductModal"
                        CssClass="field-error" Display="Dynamic"
                        ClientValidationFunction="validateDescription"
                        OnServerValidate="cvDescription_ServerValidate"
                        ErrorMessage="Description needs at least 10 words (under 600 chars)."
                        Text="Write at least 10 words." />
                </div>

                <!-- FLAG AS NEW COLLECTION -->
                <div class="prod-field-group">
                    <label class="prod-checkbox-label">
                        <asp:CheckBox ID="chkNew" runat="server" />
                        <span>Flag as New Collection</span>
                    </label>
                </div>

                <!-- MODAL FOOTER BUTTONS MATCHING IMAGE 2 -->
                <div class="prod-modal-footer">
                    <asp:Button ID="btnDeleteModal" runat="server" Text="Delete Product" CssClass="prod-modal-btn-delete"
                        Visible="false" CausesValidation="false" OnClick="btnDeleteModal_Click"
                        OnClientClick="openConfirmDeleteFromEditModal(); return false;" />

                    <asp:Button ID="btnCancelModal" runat="server" Text="Cancel" CssClass="prod-modal-btn-cancel"
                        CausesValidation="false" OnClick="btnCancelModal_Click" OnClientClick="closeModal(); return false;" />

                    <button type="submit" id="btnSaveModal" runat="server" onserverclick="btnSaveModal_Click"
                        class="prod-modal-btn-save" validationgroup="ProductModal">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <polyline points="20 6 9 17 4 12"></polyline>
                        </svg>
                        <span id="btnSaveModalText" runat="server">Update Changes</span>
                    </button>
                </div>

            </div>
        </div>
    </div>


    <!-- SUCCESS CONFIRMATION POPUP MODAL (STRICTLY MATCHING USER IMAGE 2 FOR SAVE/UPDATE) -->
    <div id="pnlSuccessModal" runat="server" class="prod-modal-overlay" style="display: none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #2563EB; background: #ffffff; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
            <div style="width: 56px; height: 56px; background: #DBEAFE; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#2563EB" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
            </div>

            <h2 id="lblSuccessTitle" runat="server" style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 8px;">Product Updated!</h2>
            <p id="lblSuccessSub" runat="server" style="font-size: 13.5px; color: #64748B; margin: 0 0 24px;">successfully Updated.</p>

            <asp:Button ID="btnBackToInventory" runat="server" Text="&larr; Return to Inventory" OnClick="btnBackToInventory_Click" OnClientClick="closeSuccessModal(); return false;" CausesValidation="false" style="width:100%; height:46px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:14px; font-weight:700; cursor:pointer;" />
        </div>
    </div>

    <!-- DELETE CONFIRMATION POPUP MODAL (STRICTLY MATCHING USER IMAGE 1) -->
    <div id="pnlConfirmDeleteModal" runat="server" class="prod-modal-overlay" style="display: none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #DC2626; background: #ffffff; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
            <asp:HiddenField ID="hfDeleteProductId" runat="server" Value="0" />

            <div style="width: 56px; height: 56px; background: #FEE2E2; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#DC2626" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                    <line x1="10" y1="11" x2="10" y2="17"></line>
                    <line x1="14" y1="11" x2="14" y2="17"></line>
                </svg>
            </div>

            <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 10px;">Delete Product</h2>
            <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px; line-height: 1.5;">
                Are you sure you want to delete<br />
                <strong>This Product? This action<br />cannot be undone.</strong>
            </p>

            <div style="display: flex; flex-direction: column; gap: 10px;">
                <asp:Button ID="btnConfirmDelete" runat="server" Text="Delete Product" OnClick="btnConfirmDelete_Click" CausesValidation="false" style="width:100%; height:46px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:14px; font-weight:700; cursor:pointer;" />
                <asp:Button ID="btnCancelDelete" runat="server" Text="Cancel" OnClick="btnCancelDelete_Click" OnClientClick="closeConfirmDeleteModal(); return false;" CausesValidation="false" style="width:100%; height:46px; background:#ffffff; color:#475569; border:1.5px solid #CBD5E1; border-radius:14px; font-size:14px; font-weight:700; cursor:pointer;" />
            </div>
        </div>
    </div>

    <!-- PRODUCT DELETED SUCCESS POPUP MODAL (STRICTLY MATCHING USER IMAGE 2) -->
    <div id="pnlSuccessDeleteModal" runat="server" class="prod-modal-overlay" style="display: none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #3B82F6; background: #ffffff; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
            <div style="width: 56px; height: 56px; background: #DBEAFE; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#2563EB" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
            </div>

            <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 10px;">Product Deleted!</h2>
            <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px;">successfully Delete.</p>

            <asp:Button ID="btnReturnToInventory" runat="server" Text="&larr; Return to Inventory" OnClick="btnReturnToInventory_Click" OnClientClick="closeSuccessDeleteModal(); return false;" CausesValidation="false" style="width:100%; height:46px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:14px; font-weight:700; cursor:pointer;" />
        </div>
    </div>


    <script type="text/javascript">
        function openAddModal() {
            var modal = document.getElementById('<%= pnlProductModal.ClientID %>');
            if (modal) modal.style.display = 'flex';

            var succ = document.getElementById('<%= pnlSuccessModal.ClientID %>');
            if (succ) succ.style.display = 'none';

            var hfId = document.getElementById('<%= hfProductId.ClientID %>');
            if (hfId) hfId.value = '0';

            var title = document.getElementById('<%= lblModalTitle.ClientID %>');
            if (title) title.innerText = 'Add New Product';

            var btnTxt = document.getElementById('<%= btnSaveModalText.ClientID %>');
            if (btnTxt) btnTxt.innerText = 'Save Product';

            var txtN = document.getElementById('<%= txtName.ClientID %>');
            if (txtN) txtN.value = '';

            var txtD = document.getElementById('<%= txtDescription.ClientID %>');
            if (txtD) txtD.value = '';

            var txtP = document.getElementById('<%= txtPrice.ClientID %>');
            if (txtP) txtP.value = '0.00';

            var txtS = document.getElementById('txtStock');
            if (txtS) txtS.value = '1';

            var ddlC = document.getElementById('<%= ddlCategory.ClientID %>');
            if (ddlC) ddlC.selectedIndex = 0;

            var chk = document.getElementById('<%= chkNew.ClientID %>');
            if (chk) chk.checked = false;

            updateImagePreview('category_torans.jpg');
        }

        function closeModal() {
            var modal = document.getElementById('<%= pnlProductModal.ClientID %>');
            if (modal) modal.style.display = 'none';
        }

        function closeSuccessModal() {
            var modal = document.getElementById('<%= pnlSuccessModal.ClientID %>');
            if (modal) modal.style.display = 'none';
        }

        function openConfirmDeleteModal(id) {
            var hf = document.getElementById('<%= hfDeleteProductId.ClientID %>');
            if (hf) hf.value = id;

            var prodModal = document.getElementById('<%= pnlProductModal.ClientID %>');
            if (prodModal) prodModal.style.display = 'none';

            var delModal = document.getElementById('<%= pnlConfirmDeleteModal.ClientID %>');
            if (delModal) delModal.style.display = 'flex';
        }

        function openConfirmDeleteFromEditModal() {
            var hf = document.getElementById('<%= hfProductId.ClientID %>');
            var id = hf ? hf.value : '0';
            openConfirmDeleteModal(id);
        }

        function closeConfirmDeleteModal() {
            var delModal = document.getElementById('<%= pnlConfirmDeleteModal.ClientID %>');
            if (delModal) delModal.style.display = 'none';
        }

        function closeSuccessDeleteModal() {
            var succModal = document.getElementById('<%= pnlSuccessDeleteModal.ClientID %>');
            if (succModal) succModal.style.display = 'none';
        }

        function adjustStock(delta) {
            var el = document.getElementById('txtStock');
            if (!el) return;
            var val = parseInt(el.value || '0', 10);
            if (isNaN(val)) val = 0;
            val += delta;
            if (val < 0) val = 0;
            if (val > 9999) val = 9999;
            el.value = val;
        }

        function selectPresetImage(imgName, thumbEl) {
            var hf = document.getElementById('<%= hfSelectedImage.ClientID %>');
            if (hf) hf.value = imgName;

            var thumbs = document.querySelectorAll('.prod-thumb-box');
            thumbs.forEach(function (t) { t.classList.remove('active'); });
            if (thumbEl) thumbEl.classList.add('active');

            updateImagePreview(imgName);
        }

        function triggerImagePicker() {
            // Preset images are selected directly via thumbnail clicks
        }

        function updateImagePreview(imgName) {
            var box = document.getElementById('imgPreviewBox');
            if (!box) return;
            if (imgName) {
                var url = '../Images/' + imgName;
                box.innerHTML = '<img src="' + url + '" style="max-height: 140px; width: auto; max-width: 100%; border-radius: 12px; object-fit: contain;" alt="Preview" />' +
                    '<div class="prod-photo-update-badge"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path><circle cx="12" cy="13" r="4"></circle></svg> Update Image</div>';
            }
        }

        function validateDescription(sender, args) {
            var text = (args.Value || "").trim();
            var words = text.length === 0 ? 0 : text.split(/\s+/).length;
            args.IsValid = words >= 10 && text.length <= 600;
        }

        document.addEventListener('DOMContentLoaded', function() {
            var hf = document.getElementById('<%= hfSelectedImage.ClientID %>');
            if (hf && hf.value) {
                updateImagePreview(hf.value);
            }
        });
    </script>

</asp:Content>


