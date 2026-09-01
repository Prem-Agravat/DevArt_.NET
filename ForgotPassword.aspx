<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="DevArt.ForgotPassword" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Forgot Password</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnSubmit">

            <div class="auth-logo">
                <img src="Images/devart-logo.png" alt="DevArt" />
                <span>Dev Art</span>
            </div>

            <h1 class="auth-title">Forgot Password</h1>
            <p class="auth-lead">Enter your registered email and we will send a 4-digit verification code.</p>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Literal ID="litMessage" runat="server" />
            </asp:Panel>

            <asp:ValidationSummary ID="vsForgot" runat="server"
                ValidationGroup="Forgot" CssClass="validation-summary"
                HeaderText="We could not send the code:" DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full">
                    <label>Email<span class="req">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input"
                        TextMode="Email" placeholder="Enter your registered email" />
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
                    <%-- The address has to belong to a real account, so this is a server check. --%>
                    <asp:CustomValidator ID="cvEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="Forgot"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvEmail_ServerValidate"
                        ErrorMessage="No DevArt account is registered with that email."
                        Text="No account is registered with that email." />
                </div>
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Submit"
                CssClass="newsletter-btn auth-submit"
                ValidationGroup="Forgot" OnClick="btnSubmit_Click" />

            <p class="auth-foot">Don&#39;t have an account? <a href="Register.aspx">Sign Up</a></p>
        </asp:Panel>
    </main>

</asp:Content>
