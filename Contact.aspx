<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="DevArt.Contact" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Help &amp; Support</asp:Content>

<asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function validateMessageLength(sender, args) {
            var text = (args.Value || "").trim();
            var words = text.length === 0 ? 0 : text.split(/\s+/).length;
            args.IsValid = words >= 1 && text.length <= 500;
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="contact-page-wrapper">
        <h1 class="contact-page-title">Help &amp; Support</h1>

        <div class="contact-container">

            <!-- LEFT COLUMN: Get in Touch -->
            <div class="contact-left-col">
                <h2 class="contact-col-title">Get in Touch</h2>

                <div class="contact-card">
                    <span class="contact-card-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#8C5535" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                            <polyline points="22,6 12,13 2,6"></polyline>
                        </svg>
                    </span>
                    <span class="contact-card-label">Email Us</span>
                    <h3 class="contact-card-value">hello@devart.shop</h3>
                </div>

                <div class="contact-card">
                    <span class="contact-card-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#8C5535" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                        </svg>
                    </span>
                    <span class="contact-card-label">Call Our Studio</span>
                    <h3 class="contact-card-value">+91 98765 43210</h3>
                </div>

                <a href="https://wa.me/919876543210" target="_blank" class="whatsapp-btn">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"></path>
                    </svg>
                    <span>Chat on WhatsApp</span>
                </a>

                <div class="contact-studio-section">
                    <h2 class="contact-col-title" style="margin-top: 28px;">Visit Our Studio</h2>
                    <p class="contact-studio-sub">Kalavad Road, Rajkot - 360004</p>

                    <div class="contact-map-card">
                        <img src="Images/community_workspace.jpg" alt="DevArt Studio Map" class="contact-map-img" />
                        <div class="contact-map-pill">
                            Open 10 AM - 7 PM
                        </div>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN: Send us a message (Dashed Card) -->
            <div class="contact-right-col">
                <asp:Panel ID="pnlFormCard" runat="server" CssClass="contact-form-card" DefaultButton="btnSend">
                    <h2 class="contact-form-title">Send us a message</h2>

                    <asp:Panel ID="pnlResult" runat="server" Visible="false" CssClass="form-alert success" style="margin-bottom: 16px;">
                        <asp:Literal ID="litResult" runat="server" />
                    </asp:Panel>

                    <asp:ValidationSummary ID="vsContact" runat="server"
                        ValidationGroup="Contact"
                        CssClass="validation-summary"
                        HeaderText="Your enquiry could not be sent:"
                        DisplayMode="BulletList" />

                    <div class="contact-form-grid">
                        <div class="contact-field-group">
                            <label class="contact-field-label">FULL NAME</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="contact-input" placeholder="Enter your name" />
                            <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                ControlToValidate="txtName" ValidationGroup="Contact"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Your name is required." Text="Your name is required." />
                        </div>

                        <div class="contact-field-group">
                            <label class="contact-field-label">EMAIL ADDRESS</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="contact-input" TextMode="Email" placeholder="example@email.com" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                ControlToValidate="txtEmail" ValidationGroup="Contact"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Email address is required." Text="Email address is required." />
                        </div>

                        <div class="contact-field-group full">
                            <label class="contact-field-label">SUBJECT</label>
                            <div class="contact-select-wrapper">
                                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="contact-select">
                                    <asp:ListItem Text="General Inquiry" Value="General Inquiry" />
                                    <asp:ListItem Text="Order status" Value="Order status" />
                                    <asp:ListItem Text="Product / fabric enquiry" Value="Product enquiry" />
                                    <asp:ListItem Text="Bulk or interior project" Value="Bulk order" />
                                    <asp:ListItem Text="Returns and refunds" Value="Returns" />
                                    <asp:ListItem Text="Something else" Value="Other" />
                                </asp:DropDownList>
                                <span class="contact-select-arrow">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#444444" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <polyline points="6 9 12 15 18 9"></polyline>
                                    </svg>
                                </span>
                            </div>
                        </div>

                        <div class="contact-field-group full">
                            <label class="contact-field-label">YOUR MESSAGE</label>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="contact-textarea"
                                TextMode="MultiLine" Rows="5" placeholder="How can we help you today?" />
                            <asp:RequiredFieldValidator ID="rfvMessage" runat="server"
                                ControlToValidate="txtMessage" ValidationGroup="Contact"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Please write your message." Text="Please write your message." />
                        </div>

                        <!-- Hidden / Defaulted secondary fields to maintain 100% backend compatibility -->
                        <div style="display:none;">
                            <asp:TextBox ID="txtPhone" runat="server" Text="9876543210" />
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ValidationGroup="Contact" />
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ValidationGroup="Contact" ValidationExpression="^[6-9]\d{9}$" />

                            <asp:TextBox ID="txtRating" runat="server" Text="5" />
                            <asp:RequiredFieldValidator ID="rfvRating" runat="server" ControlToValidate="txtRating" ValidationGroup="Contact" />
                            <asp:RangeValidator ID="rngRating" runat="server" ControlToValidate="txtRating" ValidationGroup="Contact" Type="Integer" MinimumValue="1" MaximumValue="5" />

                            <asp:TextBox ID="txtCallDate" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvCallDate" runat="server" ControlToValidate="txtCallDate" ValidationGroup="Contact" />
                            <asp:CompareValidator ID="cmpCallDate" runat="server" ControlToValidate="txtCallDate" ValidationGroup="Contact" Operator="GreaterThanEqual" Type="Date" />

                            <asp:CheckBox ID="chkCopy" runat="server" />
                            <asp:CustomValidator ID="cvMessage" runat="server" ControlToValidate="txtMessage" ValidationGroup="Contact" ClientValidationFunction="validateMessageLength" OnServerValidate="cvMessage_ServerValidate" />
                            <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" CausesValidation="false" />
                        </div>
                    </div>

                    <div class="contact-btn-wrapper">
                        <button type="button" class="contact-submit-btn" onclick="triggerContactSubmit(event);">
                            <span>Send Message</span>
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="22" y1="2" x2="11" y2="13"></line>
                                <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
                            </svg>
                        </button>
                        <asp:Button ID="btnSend" runat="server" Text="Send Message" Style="display:none;"
                            ValidationGroup="Contact" OnClick="btnSend_Click" />
                    </div>

                </asp:Panel>
            </div>

        </div>

        <asp:Panel ID="pnlEnquiries" runat="server" Visible="false" CssClass="panel" style="max-width: 900px; margin: 30px auto 0;">
            <h3>Enquiries received this session</h3>
            <table class="data-table">
                <thead>
                    <tr><th>#</th><th>Name</th><th>Subject</th><th>Rating</th><th>Call-back</th></tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptEnquiries" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Id") %></td>
                                <td><%# Server.HtmlEncode(Convert.ToString(Eval("FullName"))) %></td>
                                <td><%# Server.HtmlEncode(Convert.ToString(Eval("Subject"))) %></td>
                                <td><%# Eval("Rating") %>/5</td>
                                <td><%# Eval("PreferredCallDate", "{0:dd MMM yyyy}") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </asp:Panel>
    </main>

    <script type="text/javascript">
        function triggerContactSubmit(e) {
            e.preventDefault();
            document.getElementById('<%= btnSend.ClientID %>').click();
        }
    </script>

</asp:Content>
