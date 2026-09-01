<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DevArt.Login" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Login</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnLogin">

            <div class="auth-logo">
                <img src="Images/devart-logo.png" alt="DevArt" />
                <span>Dev Art</span>
            </div>

            <h1 class="auth-title">Welcome to DevArt</h1>
            <p class="auth-lead">Sign in to track orders, save favourites and check out faster.</p>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Literal ID="litMessage" runat="server" />
            </asp:Panel>

            <asp:ValidationSummary ID="vsSignIn" runat="server"
                ValidationGroup="SignIn"
                CssClass="validation-summary"
                HeaderText="Please correct the following before signing in:"
                DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full">
                    <label>Email<span class="req">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input"
                        TextMode="Email" placeholder="Enter your email" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="SignIn"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Email address is required."
                        Text="Email address is required." />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="SignIn"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,10}$"
                        ErrorMessage="Enter a valid email address, e.g. name@devart.in."
                        Text="Enter a valid email address." />
                </div>

                <div class="form-field full">
                    <label>Password<span class="req">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input"
                        TextMode="Password" placeholder="Enter your password" />
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword" ValidationGroup="SignIn"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Password is required."
                        Text="Password is required." />
                    <%-- Server-only rule: the credentials themselves are never checked in the browser. --%>
                    <asp:CustomValidator ID="cvCredentials" runat="server"
                        ValidationGroup="SignIn" CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvCredentials_ServerValidate"
                        ErrorMessage="Email and password do not match any DevArt account."
                        Text="Email and password do not match any DevArt account." />
                </div>
            </div>

            <div class="auth-row">
                <asp:CheckBox ID="chkRemember" runat="server" Text="Remember me" />
                <a href="ForgotPassword.aspx">Forgot password?</a>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login"
                CssClass="newsletter-btn auth-submit"
                ValidationGroup="SignIn" OnClick="btnLogin_Click" />

            <p class="auth-foot">Don&#39;t have an account? <a href="Register.aspx">Sign up</a></p>

            <p class="admin-link">Store staff? <a href="Admin/Login.aspx">Admin Panel</a></p>
        </asp:Panel>
    </main>

</asp:Content>
