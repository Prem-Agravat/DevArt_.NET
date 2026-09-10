<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="DevArt.ResetPassword" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Change Password</asp:Content>

<asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
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

        function togglePasswordVisibility(inputId) {
            var input = document.getElementById(inputId);
            if (!input) return;
            input.type = input.type === "password" ? "text" : "password";
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnUpdate">

            <div class="auth-card-logo">
                <img src="<%= ResolveUrl("~/Images/devart-logo.png") %>" alt="DevArt" />
            </div>

            <h1 class="auth-title-serif">Change Password</h1>
            <p class="auth-subtitle-lead">Please enter your new password below</p>

            <asp:ValidationSummary ID="vsReset" runat="server"
                ValidationGroup="Reset" CssClass="validation-summary"
                HeaderText="Your password could not be updated:" DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full">
                    <label class="auth-label">New Password</label>
                    <div class="input-icon-group">
                        <span class="icon-left">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                            </svg>
                        </span>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-input has-right-icon"
                            TextMode="Password" placeholder="Enter new password" />
                        <button type="button" class="icon-right" onclick="togglePasswordVisibility('<%= txtNewPassword.ClientID %>')" aria-label="Toggle password visibility">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvNew" runat="server"
                        ControlToValidate="txtNewPassword" ValidationGroup="Reset"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="New password is required."
                        Text="New password is required." />
                    <asp:CustomValidator ID="cvStrength" runat="server"
                        ControlToValidate="txtNewPassword" ValidationGroup="Reset"
                        CssClass="field-error" Display="Dynamic"
                        ClientValidationFunction="validatePasswordStrength"
                        OnServerValidate="cvStrength_ServerValidate"
                        ErrorMessage="Password needs 8-20 characters with an uppercase letter, a lowercase letter, a digit and a special character."
                        Text="Use 8-20 chars with A-Z, a-z, 0-9 and a symbol." />
                    <asp:CustomValidator ID="cvNotReused" runat="server"
                        ControlToValidate="txtNewPassword" ValidationGroup="Reset"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvNotReused_ServerValidate"
                        ErrorMessage="Choose a password you have not used on this account before."
                        Text="This is your current password." />
                </div>

                <div class="form-field full">
                    <label class="auth-label">Confirm Password</label>
                    <div class="input-icon-group">
                        <span class="icon-left">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                            </svg>
                        </span>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-input has-right-icon"
                            TextMode="Password" placeholder="Confirm new password" />
                        <button type="button" class="icon-right" onclick="togglePasswordVisibility('<%= txtConfirmPassword.ClientID %>')" aria-label="Toggle password visibility">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvConfirm" runat="server"
                        ControlToValidate="txtConfirmPassword" ValidationGroup="Reset"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Please confirm the new password."
                        Text="Please confirm the new password." />
                    <asp:CompareValidator ID="cmpPassword" runat="server"
                        ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword"
                        Operator="Equal" Type="String" ValidationGroup="Reset"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="New password and confirmation do not match."
                        Text="Passwords do not match." />
                </div>
            </div>

            <asp:Button ID="btnUpdate" runat="server" Text="Update Password"
                CssClass="auth-submit-btn"
                ValidationGroup="Reset" OnClick="btnUpdate_Click" />

            <p class="auth-foot" style="margin-top:22px; font-weight: 500;">
                <a href="Login.aspx" class="auth-link-brown" style="font-weight:700;">&larr; Back to Login</a>
            </p>
        </asp:Panel>
    </main>

</asp:Content>
