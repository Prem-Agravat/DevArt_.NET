<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DevArt.Admin.AdminLogin" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Admin Panel</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnLogin">

            <div class="auth-logo">
                <img src="../Images/devart-logo.png" alt="DevArt" />
                <span>Dev Art Admin</span>
            </div>

            <h1 class="auth-title">Admin Panel</h1>
            <p class="auth-lead">Store staff only. Sign in to manage inventory, orders, offers and customers.</p>

            <asp:ValidationSummary ID="vsAdmin" runat="server"
                ValidationGroup="AdminLogin" CssClass="validation-summary"
                HeaderText="Sign-in failed:" DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full">
                    <label>Work Email<span class="req">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input"
                        TextMode="Email" placeholder="admin@devart.com" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="AdminLogin"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Work email is required."
                        Text="Work email is required." />
                    <%-- Staff accounts are on the devart.com domain, so the pattern is narrower
                         than the storefront one. --%>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail" ValidationGroup="AdminLogin"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[A-Za-z0-9._%+\-]+@devart\.com$"
                        ErrorMessage="Use your @devart.com work address."
                        Text="Use your @devart.com work address." />
                </div>

                <div class="form-field full">
                    <label>Password<span class="req">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input"
                        TextMode="Password" placeholder="Enter your password" />
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword" ValidationGroup="AdminLogin"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Password is required."
                        Text="Password is required." />
                    <asp:CustomValidator ID="cvCredentials" runat="server"
                        ValidationGroup="AdminLogin" CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvCredentials_ServerValidate"
                        ErrorMessage="Those staff credentials were not recognised."
                        Text="Those staff credentials were not recognised." />
                </div>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Enter Admin Panel"
                CssClass="newsletter-btn auth-submit"
                ValidationGroup="AdminLogin" OnClick="btnLogin_Click" />

            <p class="admin-link">Shopping instead? <a href="../Login.aspx">Customer login</a></p>
        </asp:Panel>
    </main>

</asp:Content>
