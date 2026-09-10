<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VerifyOtp.aspx.cs" Inherits="DevArt.VerifyOtp" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Verify OTP</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="auth-shell">
        <asp:Panel ID="pnlCard" runat="server" CssClass="auth-card" DefaultButton="btnVerify">

            <div class="auth-card-logo">
                <img src="<%= ResolveUrl("~/Images/devart-logo.png") %>" alt="DevArt" />
            </div>

            <h1 class="auth-title-serif">Verify OTP</h1>
            <p class="auth-subtitle-lead">
                Please enter the 4-digit code sent to<br />
                <strong style="color: #1a1a1a;"><asp:Literal ID="litEmail" runat="server" /></strong>
            </p>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Literal ID="litMessage" runat="server" />
            </asp:Panel>

            <asp:ValidationSummary ID="vsOtp" runat="server"
                ValidationGroup="Otp" CssClass="validation-summary"
                HeaderText="The code could not be verified:" DisplayMode="BulletList" />

            <div class="form-grid">
                <div class="form-field full" style="display: flex; flex-direction: column; align-items: center;">
                    <asp:TextBox ID="txtOtp" runat="server" CssClass="form-input"
                        MaxLength="4" placeholder="1234"
                        style="width: 180px; text-align: center; font-size: 20px; letter-spacing: 8px; border: 1.5px solid #222; border-radius: 12px; height: 46px;" />
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
                    <asp:CustomValidator ID="cvOtp" runat="server"
                        ControlToValidate="txtOtp" ValidationGroup="Otp"
                        CssClass="field-error" Display="Dynamic"
                        OnServerValidate="cvOtp_ServerValidate"
                        ErrorMessage="That code is incorrect or has expired. Request a new one."
                        Text="Incorrect or expired code." />
                </div>
            </div>

            <asp:Button ID="btnVerify" runat="server" Text="Verify"
                CssClass="auth-submit-btn"
                ValidationGroup="Otp" OnClick="btnVerify_Click" />

            <p class="auth-foot" style="margin-top:22px; font-weight: 500;">
                Didn&#39;t receive the code?
                <asp:LinkButton ID="btnResend" runat="server" CssClass="auth-link-brown" style="font-weight:700;" CausesValidation="false" OnClick="btnResend_Click">Resend code</asp:LinkButton><br />
                <a href="Login.aspx" class="auth-link-brown" style="display:inline-block; margin-top:8px;">&larr; Back to Login</a>
            </p>
        </asp:Panel>
    </main>

</asp:Content>
