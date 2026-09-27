<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="DevArt.ForgotPassword" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Forgot Password</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="forgot-page-wrapper">
        <div class="forgot-card-container">
            
            <!-- Top Tapestry Header Area -->
            <div class="forgot-header-banner">
                <a href="Login.aspx" class="forgot-back-btn" title="Back to Login" aria-label="Back">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#222222" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10" stroke="#222222" stroke-width="1.8" fill="rgba(255,255,255,0.4)"/>
                        <polyline points="13 8 9 12 13 16" stroke="#222222" stroke-width="2"/>
                    </svg>
                </a>
            </div>

            <!-- Overlapping Circular Logo Badge -->
            <div class="forgot-logo-wrapper">
                <div class="forgot-logo-badge">
                    <img src="Images/devart-logo.png" alt="DevArt Logo" />
                </div>
            </div>

            <!-- Translucent Bottom Form Card -->
            <asp:Panel ID="pnlCard" runat="server" CssClass="forgot-form-card" DefaultButton="btnSubmit">
                
                <h1 class="forgot-title">Forgot Password</h1>

                <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="forgot-alert-panel">
                    <asp:Literal ID="litMessage" runat="server" />
                </asp:Panel>

                <asp:ValidationSummary ID="vsForgot" runat="server"
                    ValidationGroup="Forgot" CssClass="validation-summary"
                    HeaderText="Please check the following:" DisplayMode="BulletList" />

                <div class="forgot-field-group">
                    <label for="<%= txtEmail.ClientID %>" class="forgot-input-label">Enter Your Registered email</label>
                    <div class="forgot-input-with-icon">
                        <span class="forgot-field-icon">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#333333" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                        </span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="forgot-input"
                            TextMode="Email" placeholder="Email" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="Forgot"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Email address is required."
                        Text="Email address is required." />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="Forgot"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,10}$"
                        ErrorMessage="Enter a valid email address."
                        Text="Enter a valid email address." />
                    <asp:CustomValidator ID="cvEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="Forgot"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvEmail_ServerValidate"
                        ErrorMessage="No DevArt account is registered with that email."
                        Text="No account is registered with that email." />
                </div>

                <div class="forgot-otp-msg">
                    OTP SEND.Please Check Your Email
                </div>

                <div class="forgot-btn-wrapper">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit"
                        CssClass="forgot-submit-btn"
                        ValidationGroup="Forgot" OnClick="btnSubmit_Click" />
                </div>

                <p class="forgot-footer">
                    Don't have an account? <a href="Register.aspx" class="forgot-signup-link">Sign Up</a>
                </p>

            </asp:Panel>
        </div>
    </main>

</asp:Content>
