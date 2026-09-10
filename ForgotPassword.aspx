<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="DevArt.ForgotPassword" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Forgot Password</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnSubmit">

            <div class="auth-card-logo">
                <img src="<%= ResolveUrl("~/Images/devart-logo.png") %>" alt="DevArt" />
            </div>

            <h1 class="auth-title-serif">Forgot Password</h1>
            <p class="auth-subtitle-lead">Enter your registered email and we will send a 4-digit verification code.</p>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Literal ID="litMessage" runat="server" />
            </asp:Panel>

            <asp:ValidationSummary ID="vsForgot" runat="server"
                ValidationGroup="Forgot" CssClass="validation-summary"
                HeaderText="We could not send the code:" DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full">
                    <label class="auth-label">Email Address</label>
                    <div class="input-icon-group">
                        <span class="icon-left">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                <polyline points="22,6 12,13 2,6"></polyline>
                            </svg>
                        </span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input"
                            TextMode="Email" placeholder="Enter your registered email" />
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
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Send Recovery Code"
                CssClass="auth-submit-btn"
                ValidationGroup="Forgot" OnClick="btnSubmit_Click" />

            <p class="auth-foot" style="margin-top:22px; font-weight: 500;">
                Remember your password? <a href="Login.aspx" class="auth-link-brown" style="font-weight:700;">Login</a>
            </p>
        </asp:Panel>
    </main>

</asp:Content>
