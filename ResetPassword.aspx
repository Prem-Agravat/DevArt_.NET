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
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnUpdate">

            <div class="auth-logo">
                <img src="Images/devart-logo.png" alt="DevArt" />
                <span>Dev Art</span>
            </div>

            <h1 class="auth-title">Change Password</h1>
            <p class="auth-lead">Please enter your new password below.</p>

            <asp:ValidationSummary ID="vsReset" runat="server"
                ValidationGroup="Reset" CssClass="validation-summary"
                HeaderText="Your password could not be updated:" DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full">
                    <label>New Password<span class="req">*</span></label>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-input"
                        TextMode="Password" placeholder="Enter new password" />
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
                    <%-- The new password must differ from the one on the account. --%>
                    <asp:CustomValidator ID="cvNotReused" runat="server"
                        ControlToValidate="txtNewPassword" ValidationGroup="Reset"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvNotReused_ServerValidate"
                        ErrorMessage="Choose a password you have not used on this account before."
                        Text="This is your current password." />
                </div>

                <div class="form-field full">
                    <label>Confirm Password<span class="req">*</span></label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-input"
                        TextMode="Password" placeholder="Confirm new password" />
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
                CssClass="newsletter-btn auth-submit"
                ValidationGroup="Reset" OnClick="btnUpdate_Click" />
        </asp:Panel>
    </main>

</asp:Content>
