<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="DevArt.Profile" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Profile</asp:Content>

<asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        // Same strength rule as registration; the server re-checks it in C#.
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

    <main class="page-shell">
        <h1 class="page-title">Profile</h1>
        <p class="page-subtitle">Manage your details, orders and wishlist.</p>

        <%-- Shown when there is no user in Session. --%>
        <asp:Panel ID="pnlGuest" runat="server" CssClass="panel empty-state">
            <h3>You are not signed in</h3>
            <p>Please <a href="Login.aspx" style="color:#5069a6;">log in</a>
               or <a href="Register.aspx" style="color:#5069a6;">create an account</a>
               to view your profile and settings.</p>
        </asp:Panel>

        <asp:Panel ID="pnlProfile" runat="server" Visible="false" CssClass="layout-split">

            <div>
                <div class="side-panel">
                    <h4>Account</h4>
                    <div class="side-nav">
                        <a href="Profile.aspx" class="active">Profile</a>
                        <a href="MyOrders.aspx">My Orders</a>
                        <a href="Wishlist.aspx">Wishlist</a>
                        <a href="#password">Change Password</a>
                        <a href="Contact.aspx">Help &amp; Support</a>
                        <asp:LinkButton ID="btnSignOut" runat="server" CssClass="danger"
                            CausesValidation="false" OnClick="btnSignOut_Click" Text="Logout" />
                    </div>
                </div>

                <div class="side-panel">
                    <h4>Your DevArt</h4>
                    <p style="margin:0;font-size:12.5px;line-height:1.9;color:#5a5a5a;">
                        <strong><asp:Literal ID="litOrderCount" runat="server" /></strong> orders placed<br />
                        <strong><asp:Literal ID="litPending" runat="server" /></strong> pending shipments<br />
                        <strong><asp:Literal ID="litWishCount" runat="server" /></strong> wishlist items
                    </p>
                </div>
            </div>

            <div>
                <asp:Panel ID="pnlStatus" runat="server" Visible="false">
                    <asp:Literal ID="litStatus" runat="server" />
                </asp:Panel>

                <div class="panel">
                    <h3>Personal Information</h3>
                    <p class="panel-hint">Signed in as <asp:Literal ID="litWho" runat="server" />. Update your profile details and shipping preferences.</p>

                    <%-- Validation group 1: the profile fields. --%>
                    <asp:ValidationSummary ID="vsProfile" runat="server"
                        ValidationGroup="Profile" CssClass="validation-summary"
                        HeaderText="Your profile could not be saved:" DisplayMode="BulletList" />

                    <div class="form-grid">
                        <div class="form-field">
                            <label>Full Name<span class="req">*</span></label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-input" />
                            <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                ControlToValidate="txtName" ValidationGroup="Profile"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Full name is required."
                                Text="Full name is required." />
                            <asp:RegularExpressionValidator ID="revName" runat="server"
                                ControlToValidate="txtName" ValidationGroup="Profile"
                                CssClass="field-error" Display="Dynamic"
                                ValidationExpression="^[A-Za-z][A-Za-z\.\s]{2,49}$"
                                ErrorMessage="Name must be 3-50 letters (no digits or symbols)."
                                Text="Name must be 3-50 letters." />
                        </div>

                        <div class="form-field">
                            <label>Email Address</label>
                            <%-- Email is the account key, so it is displayed read-only. --%>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" ReadOnly="true" />
                        </div>

                        <div class="form-field">
                            <label>Phone Number<span class="req">*</span></label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-input" MaxLength="10" />
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                                ControlToValidate="txtPhone" ValidationGroup="Profile"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Mobile number is required."
                                Text="Mobile number is required." />
                            <asp:RegularExpressionValidator ID="revPhone" runat="server"
                                ControlToValidate="txtPhone" ValidationGroup="Profile"
                                CssClass="field-error" Display="Dynamic"
                                ValidationExpression="^[6-9]\d{9}$"
                                ErrorMessage="Mobile number must be 10 digits starting with 6-9."
                                Text="Must be 10 digits starting with 6-9." />
                        </div>

                        <div class="form-field">
                            <label>Date of Birth<span class="req">*</span></label>
                            <asp:TextBox ID="txtDob" runat="server" CssClass="form-input" TextMode="Date" />
                            <asp:RequiredFieldValidator ID="rfvDob" runat="server"
                                ControlToValidate="txtDob" ValidationGroup="Profile"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Date of birth is required."
                                Text="Date of birth is required." />
                            <%-- DataTypeCheck rejects anything that is not a date at all. --%>
                            <asp:CompareValidator ID="cmpDobType" runat="server"
                                ControlToValidate="txtDob" ValidationGroup="Profile"
                                Operator="DataTypeCheck" Type="Date"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Date of birth must be a valid date."
                                Text="Enter a valid date." />
                            <%-- Min/Max are assigned in Page_Load so the 18-100 window stays current. --%>
                            <asp:RangeValidator ID="rngDob" runat="server"
                                ControlToValidate="txtDob" ValidationGroup="Profile" Type="Date"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Date of birth must place you between 18 and 100 years old."
                                Text="You must be at least 18 years old." />
                        </div>

                        <div class="form-field">
                            <label>City<span class="req">*</span></label>
                            <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-input">
                                <asp:ListItem Text="-- Select your city --" Value="" />
                                <asp:ListItem Text="Rajkot" Value="Rajkot" />
                                <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                                <asp:ListItem Text="Surat" Value="Surat" />
                                <asp:ListItem Text="Vadodara" Value="Vadodara" />
                                <asp:ListItem Text="Mumbai" Value="Mumbai" />
                            </asp:DropDownList>
                            <%-- InitialValue makes the placeholder item count as "nothing selected". --%>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                                ControlToValidate="ddlCity" InitialValue="" ValidationGroup="Profile"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Please select a city."
                                Text="Please select a city." />
                        </div>

                        <div class="form-field">
                            <label>Zip Code<span class="req">*</span></label>
                            <asp:TextBox ID="txtPincode" runat="server" CssClass="form-input" MaxLength="6" />
                            <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                                ControlToValidate="txtPincode" ValidationGroup="Profile"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Pincode is required."
                                Text="Pincode is required." />
                            <asp:RegularExpressionValidator ID="revPincode" runat="server"
                                ControlToValidate="txtPincode" ValidationGroup="Profile"
                                CssClass="field-error" Display="Dynamic"
                                ValidationExpression="^[1-9][0-9]{5}$"
                                ErrorMessage="Pincode must be 6 digits and cannot start with 0."
                                Text="Pincode must be 6 digits." />
                        </div>

                        <div class="form-field full">
                            <div class="form-check">
                                <asp:CheckBox ID="chkNewsletter" runat="server" Text="Keep me on the DevArt newsletter" />
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="newsletter-btn"
                            ValidationGroup="Profile" OnClick="btnSave_Click" />
                        <a href="Address.aspx" class="btn-outline">Add New Address</a>
                    </div>
                </div>

                <div class="panel">
                    <h3>Primary Shipping Address</h3>
                    <p class="panel-hint">Where your orders arrive by default.</p>
                    <div class="address-card">
                        <asp:Literal ID="litAddress" runat="server" />
                    </div>
                </div>

                <div class="panel">
                    <h3>Recent Orders</h3>
                    <p class="panel-hint"><a href="MyOrders.aspx" style="color:#5069a6;">View all history</a></p>

                    <asp:Repeater ID="rptRecent" runat="server">
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

                    <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" CssClass="empty-state">
                        No orders yet.
                    </asp:Panel>
                </div>

                <div class="panel" id="password">
                    <h3>Change Password</h3>
                    <p class="panel-hint">Uses a separate validation group, so saving the profile above ignores these fields.</p>

                    <%-- Validation group 2: the password change. Submitting one group
                         never triggers the validators belonging to the other. --%>
                    <asp:ValidationSummary ID="vsPassword" runat="server"
                        ValidationGroup="Password" CssClass="validation-summary"
                        HeaderText="Your password could not be changed:" DisplayMode="BulletList" />

                    <div class="form-grid">
                        <div class="form-field">
                            <label>Current Password<span class="req">*</span></label>
                            <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-input" TextMode="Password" />
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

                        <div class="form-field">
                            <label>New Password<span class="req">*</span></label>
                            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-input" TextMode="Password" />
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
                                ErrorMessage="New password needs 8-20 characters with an uppercase letter, a lowercase letter, a digit and a special character."
                                Text="Use 8-20 chars with A-Z, a-z, 0-9 and a symbol." />
                        </div>

                        <div class="form-field">
                            <label>Confirm New Password<span class="req">*</span></label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-input" TextMode="Password" />
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
                    </div>

                    <div class="form-actions">
                        <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="newsletter-btn"
                            ValidationGroup="Password" OnClick="btnChangePassword_Click" />
                    </div>
                </div>
            </div>
        </asp:Panel>
    </main>

</asp:Content>
