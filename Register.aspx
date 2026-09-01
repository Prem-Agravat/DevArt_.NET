<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="DevArt.Register" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Create an Account</asp:Content>

<asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        // Client-side half of cvPasswordStrength. The identical rule is enforced
        // server-side by DevArt.Models.ValidationRules.IsStrongPassword.
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

        // Client-side half of cvTerms - a CheckBox carries no value to validate,
        // so the rendered checkbox element is inspected directly.
        function validateTermsAccepted(sender, args) {
            var box = document.getElementById(sender.getAttribute("data-terms"));
            args.IsValid = box != null && box.checked;
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card wide" DefaultButton="btnRegister">

            <div class="auth-logo">
                <img src="Images/devart-logo.png" alt="DevArt" />
                <span>Dev Art</span>
            </div>

            <h1 class="auth-title">Create an Account</h1>
            <p class="auth-lead">Join our community of artisans and collectors.</p>

            <asp:ValidationSummary ID="vsRegister" runat="server"
                ValidationGroup="Register"
                CssClass="validation-summary"
                HeaderText="Please fix these details to create your account:"
                DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full">
                    <label>Full Name<span class="req">*</span></label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Enter your full name" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server"
                        ControlToValidate="txtName" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Full name is required."
                        Text="Full name is required." />
                    <asp:RegularExpressionValidator ID="revName" runat="server"
                        ControlToValidate="txtName" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[A-Za-z][A-Za-z\.\s]{2,49}$"
                        ErrorMessage="Name must be 3-50 letters (no digits or symbols)."
                        Text="Name must be 3-50 letters." />
                </div>

                <div class="form-field full">
                    <label>Email Address<span class="req">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input"
                        TextMode="Email" placeholder="you@example.com" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Email address is required."
                        Text="Email address is required." />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,10}$"
                        ErrorMessage="Enter a valid email address."
                        Text="Enter a valid email address." />
                    <%-- Duplicate check runs against the in-memory user collection. --%>
                    <asp:CustomValidator ID="cvEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvEmail_ServerValidate"
                        ErrorMessage="An account with this email already exists."
                        Text="This email is already registered." />
                </div>

                <div class="form-field">
                    <label>Password<span class="req">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input"
                        TextMode="Password" placeholder="8-20 characters" />
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Password is required."
                        Text="Password is required." />
                    <%-- Runs on the client (JS) and again on the server (C#). --%>
                    <asp:CustomValidator ID="cvPasswordStrength" runat="server"
                        ControlToValidate="txtPassword" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ClientValidationFunction="validatePasswordStrength"
                        OnServerValidate="cvPasswordStrength_ServerValidate"
                        ErrorMessage="Password needs 8-20 characters with an uppercase letter, a lowercase letter, a digit and a special character."
                        Text="Use 8-20 chars with A-Z, a-z, 0-9 and a symbol." />
                </div>

                <div class="form-field">
                    <label>Confirm Password<span class="req">*</span></label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-input"
                        TextMode="Password" placeholder="Re-type password" />
                    <asp:RequiredFieldValidator ID="rfvConfirm" runat="server"
                        ControlToValidate="txtConfirmPassword" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Please confirm your password."
                        Text="Please confirm your password." />
                    <asp:CompareValidator ID="cmpPassword" runat="server"
                        ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"
                        Operator="Equal" Type="String" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Password and Confirm Password do not match."
                        Text="Passwords do not match." />
                </div>

                <div class="form-field full">
                    <div class="form-check">
                        <asp:CheckBox ID="chkTerms" runat="server" Text="I agree to the Terms &amp; Conditions" />
                    </div>
                    <%-- A CheckBox cannot be a ControlToValidate target, so the rule lives
                         in a CustomValidator with ValidateEmptyText enabled. --%>
                    <asp:CustomValidator ID="cvTerms" runat="server"
                        ValidationGroup="Register" ValidateEmptyText="true"
                        CssClass="field-error" Display="Dynamic"
                        ClientValidationFunction="validateTermsAccepted"
                        OnServerValidate="cvTerms_ServerValidate"
                        ErrorMessage="You must accept the Terms &amp; Conditions to create an account."
                        Text="You must accept the terms." />
                </div>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Register"
                CssClass="newsletter-btn auth-submit"
                ValidationGroup="Register" OnClick="btnRegister_Click" />

            <p class="auth-foot">Already have an account? <a href="Login.aspx">Login</a></p>
        </asp:Panel>
    </main>

</asp:Content>
