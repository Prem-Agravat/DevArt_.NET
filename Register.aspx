<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="DevArt.Register" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Create an Account</asp:Content>

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

        function validateTermsAccepted(sender, args) {
            var box = document.getElementById(sender.getAttribute("data-terms"));
            args.IsValid = box != null && box.checked;
        }

        function togglePassword(inputId, btn) {
            var input = document.getElementById(inputId);
            if (!input) return;
            if (input.type === "password") {
                input.type = "text";
            } else {
                input.type = "password";
            }
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnRegister">

            <div class="auth-card-logo">
                <img src="Images/devart-logo.png" alt="DevArt" />
            </div>

            <h1 class="auth-title-serif">Create an Account</h1>
            <p class="auth-lead" style="margin-bottom:20px;">Join our community of artisans and collectors.</p>

            <asp:ValidationSummary ID="vsRegister" runat="server"
                ValidationGroup="Register"
                CssClass="validation-summary"
                HeaderText="Please fix these details to create your account:"
                DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full">
                    <label class="auth-label">Full Name</label>
                    <div class="input-icon-group">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-input no-left-icon" placeholder="Enter your full name" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server"
                        ControlToValidate="txtName" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Full name is required."
                        Text="Full name is required." />
                    <asp:RegularExpressionValidator ID="revName" runat="server"
                        ControlToValidate="txtName" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[A-Za-z][A-Za-z\.\s]{2,49}$"
                        ErrorMessage="Name must be 3-50 letters."
                        Text="Name must be 3-50 letters." />
                </div>

                <div class="form-field full">
                    <label class="auth-label">Email Address</label>
                    <div class="input-icon-group">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input no-left-icon"
                            TextMode="Email" placeholder="you@example.com" />
                    </div>
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
                    <asp:CustomValidator ID="cvEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvEmail_ServerValidate"
                        ErrorMessage="An account with this email already exists."
                        Text="This email is already registered." />
                </div>

                <div class="form-field full">
                    <label class="auth-label">Password</label>
                    <div class="input-icon-group">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input no-left-icon has-right-icon"
                            TextMode="Password" placeholder="••••••••" />
                        <button type="button" class="icon-right" onclick="togglePassword('<%= txtPassword.ClientID %>', this)">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Password is required."
                        Text="Password is required." />
                    <asp:CustomValidator ID="cvPasswordStrength" runat="server"
                        ControlToValidate="txtPassword" ValidationGroup="Register"
                        CssClass="field-error" Display="Dynamic"
                        ClientValidationFunction="validatePasswordStrength"
                        OnServerValidate="cvPasswordStrength_ServerValidate"
                        ErrorMessage="Password needs 8-20 characters with A-Z, a-z, 0-9 and symbol."
                        Text="Use 8-20 chars with A-Z, a-z, 0-9 and symbol." />
                </div>

                <div class="form-field full">
                    <label class="auth-label">Confirm Password</label>
                    <div class="input-icon-group">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-input no-left-icon has-right-icon"
                            TextMode="Password" placeholder="••••••••" />
                        <button type="button" class="icon-right" onclick="togglePassword('<%= txtConfirmPassword.ClientID %>', this)">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                        </button>
                    </div>
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

                <div class="form-field full" style="margin-top:4px; margin-bottom:12px;">
                    <div class="form-check">
                        <asp:CheckBox ID="chkTerms" runat="server" Text="I agree to the " />
                        <a href="#" class="auth-link-brown" style="font-weight:600; font-size:12px; margin-left:-4px;">Terms &amp; Conditions</a>
                    </div>
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
                CssClass="auth-submit-btn"
                ValidationGroup="Register" OnClick="btnRegister_Click" />

            <p class="auth-foot" style="margin-top:22px; font-weight: 500;">
                Already have an account? <a href="Login.aspx" class="auth-link-brown" style="font-weight:700;">Login</a>
            </p>
        </asp:Panel>
    </main>

</asp:Content>
