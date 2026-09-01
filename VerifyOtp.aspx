<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VerifyOtp.aspx.cs" Inherits="DevArt.VerifyOtp" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Verify OTP</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnVerify">

            <div class="auth-logo">
                <img src="Images/devart-logo.png" alt="DevArt" />
                <span>Dev Art</span>
            </div>

            <h1 class="auth-title">Verify OTP</h1>
            <p class="auth-lead">
                Please enter the 4-digit code sent to
                <strong><asp:Literal ID="litEmail" runat="server" /></strong>.
            </p>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Literal ID="litMessage" runat="server" />
            </asp:Panel>

            <asp:ValidationSummary ID="vsOtp" runat="server"
                ValidationGroup="Otp" CssClass="validation-summary"
                HeaderText="The code could not be verified:" DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full" style="align-items: center;">
                    <asp:TextBox ID="txtOtp" runat="server" CssClass="form-input"
                        MaxLength="4" placeholder="1234"
                        style="width: 160px; text-align: center; font-size: 20px; letter-spacing: 8px;" />
                    <asp:RequiredFieldValidator ID="rfvOtp" runat="server"
                        ControlToValidate="txtOtp" ValidationGroup="Otp"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Enter the 4-digit code from your email."
                        Text="Enter the 4-digit code." />
                    <asp:RegularExpressionValidator ID="revOtp" runat="server"
                        ControlToValidate="txtOtp" ValidationGroup="Otp"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^\d{4}$"
                        ErrorMessage="The code must be exactly 4 digits."
                        Text="The code must be exactly 4 digits." />
                    <%-- Matching the issued code, and its 10-minute expiry, are server rules. --%>
                    <asp:CustomValidator ID="cvOtp" runat="server"
                        ControlToValidate="txtOtp" ValidationGroup="Otp"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvOtp_ServerValidate"
                        ErrorMessage="That code is incorrect or has expired. Request a new one."
                        Text="Incorrect or expired code." />
                </div>
            </div>

            <asp:Button ID="btnVerify" runat="server" Text="Verify"
                CssClass="newsletter-btn auth-submit"
                ValidationGroup="Otp" OnClick="btnVerify_Click" />

            <p class="auth-foot">
                Didn&#39;t receive the code?
                <asp:LinkButton ID="btnResend" runat="server" CausesValidation="false" OnClick="btnResend_Click">Resend</asp:LinkButton>
            </p>
        </asp:Panel>
    </main>

</asp:Content>
