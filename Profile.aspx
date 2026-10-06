<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="DevArt.Profile" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Profile</asp:Content>

<asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* FIXED POPUP OVERLAY & MODAL STYLES FOR PROFILE */
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
            max-width: 380px !important;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25) !important;
            overflow: hidden !important;
            position: relative !important;
            animation: profModalFade 0.25s cubic-bezier(0.16, 1, 0.3, 1) !important;
        }

        @keyframes profModalFade {
            from { opacity: 0; transform: scale(0.95) translateY(10px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }
    </style>
    <script type="text/javascript">
        function validatePasswordStrength(sender, args) {
            var value = args.Value || "";
            args.IsValid =
                value.length >= 8 && value.length <= 20 &&
                !/\s/.test(value) &&
                /[A-Z]/.test(value) &&
                /[a-z]/.test(value) &&
                /[0-9]/.test(value) &&
                /[!@#$%^&*()_\-+=\[\]{};:,.?]/.test(value);
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="prof-img2-wrapper">
        <!-- CENTERED PAGE TITLE -->
        <h1 class="prof-img2-title">Profile</h1>

        <%-- Shown when there is no user in Session. --%>
        <asp:Panel ID="pnlGuest" runat="server" CssClass="prof-empty-card">
            <h3 class="empty-title">You are not signed in</h3>
            <p class="empty-sub">Please <a href="Login.aspx" style="color:#855335;font-weight:600;">log in</a>
               or <a href="Register.aspx" style="color:#855335;font-weight:600;">create an account</a>
               to view your profile and settings.</p>
        </asp:Panel>

        <asp:Panel ID="pnlProfile" runat="server" Visible="false">
            <div class="prof-img2-grid">

                <!-- LEFT COLUMN: Dashed Account Card -->
                <div class="prof-img2-sidebar">
                    <div class="prof-img2-dashed-box">
                        <h2 class="prof-img2-nav-heading">Account</h2>
                        <div class="prof-img2-nav-divider"></div>

                        <div class="prof-img2-menu">
                            <a href="Profile.aspx" class="prof-img2-item active">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                                <span>Profile</span>
                            </a>

                            <a href="MyOrders.aspx" class="prof-img2-item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                    <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                </svg>
                                <span>My Orders</span>
                            </a>

                            <a href="Wishlist.aspx" class="prof-img2-item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                                </svg>
                                <span>Wishlist</span>
                            </a>

                            <a href="#password" class="prof-img2-item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                </svg>
                                <span>Change Password</span>
                            </a>

                            <div class="prof-img2-nav-divider"></div>

                            <a href="Contact.aspx" class="prof-img2-item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                                    <line x1="12" y1="17" x2="12.01" y2="17"></line>
                                </svg>
                                <span>Help &amp; Support</span>
                            </a>

                            <asp:LinkButton ID="btnSignOut" runat="server" CssClass="prof-img2-item logout"
                                CausesValidation="false" OnClick="btnSignOut_Click">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#cc0000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                    <polyline points="16 17 21 12 16 7"></polyline>
                                    <line x1="21" y1="12" x2="9" y2="12"></line>
                                </svg>
                                <span>Logout</span>
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- RIGHT COLUMN: Hero Card, 3 Stat Cards, Recent Orders, Edit Form -->
                <div class="prof-img2-main">

                    <!-- Hidden compatibility literals for backend sidebar counters -->
                    <div style="display:none;">
                        <asp:Literal ID="litOrderCount" runat="server" />
                        <asp:Literal ID="litPending" runat="server" />
                        <asp:Literal ID="litWishCount" runat="server" />
                    </div>

                    <asp:Panel ID="pnlStatus" runat="server" Visible="false" style="margin-bottom: 20px;">
                        <asp:Literal ID="litStatus" runat="server" />
                    </asp:Panel>

                    <!-- USER HERO CARD -->
                    <div class="prof-img2-hero-card">
                        <div class="prof-img2-hero-left">
                            <div class="prof-img2-avatar">
                                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </div>
                            <div class="prof-img2-hero-info">
                                <h2 class="prof-img2-user-name"><asp:Literal ID="litUserName" runat="server" /></h2>
                                <div class="prof-img2-user-email"><asp:Literal ID="litUserEmail" runat="server" /></div>
                                <span class="prof-img2-joined-badge"><asp:Literal ID="litUserJoined" runat="server" /></span>
                            </div>
                        </div>
                        <a href="#editProfileForm" class="prof-img2-edit-btn">Edit Profile</a>
                    </div>

                    <!-- 3 STAT CARDS GRID -->
                    <div class="prof-img2-stats-grid">
                        <div class="prof-img2-stat-card">
                            <div class="num"><asp:Literal ID="litStatArtworks" runat="server" /></div>
                            <div class="label">Artworks Collected</div>
                        </div>
                        <div class="prof-img2-stat-card">
                            <div class="num"><asp:Literal ID="litStatPending" runat="server" /></div>
                            <div class="label">Pending Shipments</div>
                        </div>
                        <div class="prof-img2-stat-card">
                            <div class="num"><asp:Literal ID="litStatWishlist" runat="server" /></div>
                            <div class="label">Wishlist Items</div>
                        </div>
                    </div>

                    <!-- RECENT ORDERS SECTION -->
                    <div class="prof-img2-recent-section">
                        <div class="prof-img2-recent-header">
                            <h2 class="prof-img2-recent-title">Recent Orders</h2>
                            <a href="MyOrders.aspx" class="prof-img2-history-link">View All History</a>
                        </div>

                        <div class="prof-orders-list">
                            <asp:Repeater ID="rptRecent" runat="server">
                                <ItemTemplate>
                                    <div class="prof-img2-order-card <%# Eval("StatusClass") %>">
                                        <img src="<%# FormatImageUrl(Eval("Image")) %>" alt="<%# Server.HtmlEncode(Convert.ToString(Eval("Summary"))) %>" class="prof-img2-order-thumb" onerror="this.src='Images/category_cushion.jpg';" />
                                        <div class="prof-img2-order-details">
                                            <h3 class="prof-img2-order-name"><%# Server.HtmlEncode(Convert.ToString(Eval("Summary"))) %></h3>
                                            <div class="prof-img2-order-meta">Order #<%# Eval("OrderNumber") %> &bull; Placed <%# Eval("PlacedOn", "{0:MMM d, yyyy}") %></div>
                                            <div class="prof-img2-badge-row">
                                                <span class="prof-img2-pill <%# Eval("StatusClass") %>"><%# Eval("Status") %></span>
                                                <a href="MyOrders.aspx" class="prof-img2-order-link">
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                                                    Details
                                                </a>
                                            </div>
                                        </div>
                                        <div class="prof-img2-order-price">&#8377;<%# Eval("Total", "{0:N0}") %></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" CssClass="prof-empty-card" style="margin:0;padding:24px;">
                                No orders yet.
                            </asp:Panel>
                        </div>
                    </div>

                    <!-- PERSONAL INFORMATION & PRIMARY SHIPPING ADDRESS FORM CARD (MATCHES IMAGE 2) -->
                    <div class="prof-img2-form-card" id="editProfileForm" style="margin-top: 32px;">
                        <h2 class="prof-img2-form-title">Personal Information</h2>
                        <p class="prof-img2-form-sub">Update your profile details and shipping preferences.</p>

                        <asp:ValidationSummary ID="vsProfile" runat="server"
                            ValidationGroup="Profile" CssClass="validation-summary"
                            HeaderText="Your profile could not be saved:" DisplayMode="BulletList" />

                        <!-- SECTION 1: PERSONAL INFORMATION -->
                        <div class="prof-img2-form-grid">
                            <div class="form-field">
                                <label class="prof-img2-brown-label">FULL NAME</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="prof-img2-input-white" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                    ControlToValidate="txtName" ValidationGroup="Profile"
                                    CssClass="field-error" Display="Dynamic"
                                    ErrorMessage="Full name is required."
                                    Text="Full name is required." />
                            </div>

                            <div class="form-field">
                                <label class="prof-img2-brown-label">EMAIL ADDRESS</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="prof-img2-input-white" ReadOnly="true" />
                            </div>

                            <div class="form-field full">
                                <label class="prof-img2-brown-label">PHONE NUMBER</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="prof-img2-input-white" MaxLength="15" />
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                                    ControlToValidate="txtPhone" ValidationGroup="Profile"
                                    CssClass="field-error" Display="Dynamic"
                                    ErrorMessage="Mobile number is required."
                                    Text="Mobile number is required." />
                            </div>

                            <!-- Hidden compatibility elements for backend controls -->
                            <div style="display:none;">
                                <asp:TextBox ID="txtDob" runat="server" Text="1995-01-01" />
                                <asp:CheckBox ID="chkNewsletter" runat="server" Checked="true" />
                                <asp:Literal ID="litWho" runat="server" />
                            </div>
                        </div>

                        <!-- DIVIDER LINE -->
                        <div class="prof-img2-divider"></div>

                        <!-- SECTION 2: PRIMARY SHIPPING ADDRESS -->
                        <div class="prof-img2-addr-header">
                            <h2 class="prof-img2-form-title" style="margin:0;">Primary Shipping Address</h2>
                            <a href="#" onclick="if(navigator.geolocation){navigator.geolocation.getCurrentPosition(function(p){alert('Location updated!');});}return false;" class="prof-img2-loc-btn">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:4px;">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                    <circle cx="12" cy="10" r="3"></circle>
                                </svg>
                                Use Current Location
                            </a>
                        </div>

                        <div class="prof-img2-form-grid" style="margin-top:16px;">
                            <div class="form-field full">
                                <label class="prof-img2-brown-label">STREET ADDRESS</label>
                                <asp:TextBox ID="txtStreetAddress" runat="server" CssClass="prof-img2-input-white" placeholder="102, Craftmen's Plaza, Kalavad Road" />
                            </div>

                            <div class="form-field">
                                <label class="prof-img2-brown-label">CITY</label>
                                <asp:DropDownList ID="ddlCity" runat="server" CssClass="prof-img2-input-white">
                                    <asp:ListItem Text="Rajkot" Value="Rajkot" Selected="True" />
                                    <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                                    <asp:ListItem Text="Surat" Value="Surat" />
                                    <asp:ListItem Text="Vadodara" Value="Vadodara" />
                                    <asp:ListItem Text="Mumbai" Value="Mumbai" />
                                </asp:DropDownList>
                            </div>

                            <div class="form-field">
                                <label class="prof-img2-brown-label">STATE</label>
                                <asp:TextBox ID="txtState" runat="server" CssClass="prof-img2-input-white" Text="Gujarat" />
                            </div>

                            <div class="form-field">
                                <label class="prof-img2-brown-label">ZIP CODE</label>
                                <asp:TextBox ID="txtPincode" runat="server" CssClass="prof-img2-input-white" MaxLength="6" placeholder="360004" />
                                <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                                    ControlToValidate="txtPincode" ValidationGroup="Profile"
                                    CssClass="field-error" Display="Dynamic"
                                    ErrorMessage="Pincode is required."
                                    Text="Pincode is required." />
                            </div>
                        </div>

                        <div style="margin-top:20px;">
                            <a href="#password" class="prof-img2-change-pw-btn">Change Password</a>
                        </div>

                        <!-- ACTION BUTTONS ROW -->
                        <div class="prof-img2-actions-row">
                            <a href="Profile.aspx" class="prof-img2-cancel-btn">Cancel</a>
                            <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="prof-img2-save-pill-btn"
                                ValidationGroup="Profile" OnClick="btnSave_Click" />
                        </div>
                    </div>

                    <!-- Hidden address literal container for backend -->
                    <div style="display:none;">
                        <asp:Literal ID="litAddress" runat="server" />
                    </div>

                    <!-- CHANGE PASSWORD CARD -->
                    <div class="prof-img2-form-card" id="password" style="margin-top: 24px;">
                        <h2 class="prof-img2-form-title">Change Password</h2>
                        <p class="prof-img2-form-sub">Update your password to keep your account secure.</p>

                        <asp:ValidationSummary ID="vsPassword" runat="server"
                            ValidationGroup="Password" CssClass="validation-summary"
                            HeaderText="Your password could not be changed:" DisplayMode="BulletList" />

                        <div class="prof-pw-form-container">
                            <!-- CURRENT PASSWORD -->
                            <div class="prof-pw-field">
                                <label class="prof-pw-label">Current Password</label>
                                <div class="prof-pw-input-wrapper">
                                    <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="prof-pw-pill-input" TextMode="Password" placeholder="Enter current password" />
                                    <button type="button" class="pw-eye-btn" onclick="togglePwVis('<%= txtCurrentPassword.ClientID %>', this)" title="Toggle Password Visibility">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#333" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>
                                    </button>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvCurrent" runat="server"
                                    ControlToValidate="txtCurrentPassword" ValidationGroup="Password"
                                    CssClass="field-error" Display="Dynamic"
                                    ErrorMessage="Current password is required."
                                    Text="Current password is required." />
                                <asp:CustomValidator ID="cvCurrent" runat="server"
                                    ControlToValidate="txtCurrentPassword" ValidationGroup="Password"
                                    CssClass="field-error" Display="Dynamic"
                                    OnServerValidate="cvCurrent_ServerValidate"
                                    ErrorMessage="Current password is not correct."
                                    Text="Current password is not correct." />
                            </div>

                            <div class="prof-pw-field-divider"></div>

                            <!-- NEW PASSWORD -->
                            <div class="prof-pw-field">
                                <label class="prof-pw-label">New Password</label>
                                <div class="prof-pw-input-wrapper">
                                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="prof-pw-pill-input" TextMode="Password" placeholder="Enter new password" />
                                    <button type="button" class="pw-eye-btn" onclick="togglePwVis('<%= txtNewPassword.ClientID %>', this)" title="Toggle Password Visibility">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#333" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>
                                    </button>
                                </div>
                                <div class="prof-pw-help-text">Must be at least 8 characters long.</div>
                                <asp:RequiredFieldValidator ID="rfvNew" runat="server"
                                    ControlToValidate="txtNewPassword" ValidationGroup="Password"
                                    CssClass="field-error" Display="Dynamic"
                                    ErrorMessage="New password is required."
                                    Text="New password is required." />
                                <asp:CustomValidator ID="cvNewStrength" runat="server"
                                    ControlToValidate="txtNewPassword" ValidationGroup="Password"
                                    CssClass="field-error" Display="Dynamic"
                                    ClientValidationFunction="validatePasswordStrength"
                                    OnServerValidate="cvNewStrength_ServerValidate"
                                    ErrorMessage="New password needs 8-20 characters with uppercase, lowercase, digit and symbol."
                                    Text="Use 8-20 chars with A-Z, a-z, 0-9 and a symbol." />
                            </div>

                            <!-- CONFIRM NEW PASSWORD -->
                            <div class="prof-pw-field" style="margin-top: 18px;">
                                <label class="prof-pw-label">Confirm New Password</label>
                                <div class="prof-pw-input-wrapper">
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="prof-pw-pill-input" TextMode="Password" placeholder="Confirm new password" />
                                    <button type="button" class="pw-eye-btn" onclick="togglePwVis('<%= txtConfirmPassword.ClientID %>', this)" title="Toggle Password Visibility">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#333" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>
                                    </button>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvConfirm" runat="server"
                                    ControlToValidate="txtConfirmPassword" ValidationGroup="Password"
                                    CssClass="field-error" Display="Dynamic"
                                    ErrorMessage="Please confirm the new password."
                                    Text="Please confirm the new password." />
                                <asp:CompareValidator ID="cmpNew" runat="server"
                                    ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword"
                                    Operator="Equal" Type="String" ValidationGroup="Password"
                                    CssClass="field-error" Display="Dynamic"
                                    ErrorMessage="New password and confirmation do not match."
                                    Text="Passwords do not match." />
                            </div>

                            <!-- ACTIONS ROW -->
                            <div class="prof-pw-actions-row">
                                <button type="button" class="prof-pw-cancel-btn" onclick="window.location.hash='';">Cancel</button>
                                <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="prof-pw-submit-btn"
                                    ValidationGroup="Password" OnClick="btnChangePassword_Click" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </asp:Panel>

    <!-- UPDATE PASSWORD SUCCESS POPUP MODAL (STRICTLY MATCHING USER IMAGE 2) -->
    <div id="pnlPasswordSuccessModal" runat="server" class="inv-modal-overlay" style="display: none;">
        <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #2563EB; background: #ffffff; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
            <div style="width: 56px; height: 56px; background: #DBEAFE; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#2563EB" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
            </div>

            <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 8px;">Update Password</h2>
            <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px;">successfully Updated.</p>

            <asp:Button ID="btnBackToProfile" runat="server" Text="&larr; Return to Profile" OnClick="btnBackToProfile_Click" OnClientClick="closePasswordSuccessModal(); return false;" CausesValidation="false" style="width:100%; height:46px; background:#6E4125; color:#ffffff; border-radius:14px; border:none; font-size:14px; font-weight:700; cursor:pointer;" />
        </div>
    </div>

    <script type="text/javascript">
        function togglePwVis(inputId, btn) {
            var input = document.getElementById(inputId);
            if (!input) return;
            if (input.type === 'password') {
                input.type = 'text';
                btn.innerHTML = '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#333" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>';
            } else {
                input.type = 'password';
                btn.innerHTML = '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#333" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>';
            }
        }

        function closePasswordSuccessModal() {
            var modal = document.getElementById('<%= pnlPasswordSuccessModal.ClientID %>');
            if (modal) modal.style.display = 'none';
        }
    </script>
    </main>

</asp:Content>
