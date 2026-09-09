<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs"
    Inherits="DevArt.Login" %>

    <asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Login</asp:Content>

    <asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
        <script type="text/javascript">
            function togglePasswordVisibility(inputId) {
                var input = document.getElementById(inputId);
                if (!input) return;
                input.type = input.type === "password" ? "text" : "password";
            }
        </script>
    </asp:Content>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <main class="auth-shell">
            <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnLogin">

                <div class="auth-card-logo">
                    <img src="Images/devart-logo.png" alt="DevArt" />
                </div>

                <h1 class="auth-title-serif">Welcome to DevArt</h1>
                <p class="auth-subtitle-lead">Discover beautiful handcrafted items</p>

                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <asp:Literal ID="litMessage" runat="server" />
                </asp:Panel>

                <asp:ValidationSummary ID="vsSignIn" runat="server" ValidationGroup="SignIn"
                    CssClass="validation-summary" HeaderText="Please correct the following before signing in:"
                    DisplayMode="BulletList" />

                <div class="form-grid">
                    <div class="form-field full">
                        <label class="auth-label">Email</label>
                        <div class="input-icon-group">
                            <span class="icon-left">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                    <polyline points="22,6 12,13 2,6"></polyline>
                                </svg>
                            </span>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email"
                                placeholder="Enter your email" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationGroup="SignIn" CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Email address is required." Text="Email address is required." />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationGroup="SignIn" CssClass="field-error" Display="Dynamic"
                            ValidationExpression="^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,10}$"
                            ErrorMessage="Enter a valid email address, e.g. name@devart.in."
                            Text="Enter a valid email address." />
                    </div>

                    <div class="form-field full">
                        <label class="auth-label">Password</label>
                        <div class="input-icon-group">
                            <span class="icon-left">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                </svg>
                            </span>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input has-right-icon" TextMode="Password"
                                placeholder="Enter your password" />
                            <button type="button" class="icon-right" onclick="togglePasswordVisibility('<%= txtPassword.ClientID %>')" aria-label="Toggle password visibility">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                    <circle cx="12" cy="12" r="3"></circle>
                                </svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ValidationGroup="SignIn" CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Password is required." Text="Password is required." />
                        <asp:CustomValidator ID="cvCredentials" runat="server" ValidationGroup="SignIn"
                            CssClass="field-error" Display="Dynamic" OnServerValidate="cvCredentials_ServerValidate"
                            ErrorMessage="Email and password do not match any DevArt account."
                            Text="Email and password do not match any DevArt account." />
                    </div>
                </div>

                <div class="auth-row" style="margin-top: 14px; margin-bottom: 20px;">
                    <asp:CheckBox ID="chkRemember" runat="server" Text="Remember me" />
                    <a href="ForgotPassword.aspx" class="auth-link-brown">Forgot password?</a>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="auth-submit-btn"
                    ValidationGroup="SignIn" OnClick="btnLogin_Click" />

                <p class="auth-foot" style="margin-top:22px; font-weight: 500;">
                    Don't have an account? <a href="Register.aspx" class="auth-link-brown" style="font-weight:700;">Sign up</a>
                </p>

                <p class="admin-link-center" style="margin-top: 24px; text-align: center;">
                    <a href="Admin/Login.aspx" class="auth-link-brown" style="font-size: 13px; font-weight: 700;">Admin Panel</a>
                </p>
            </asp:Panel>
        </main>

    </asp:Content>