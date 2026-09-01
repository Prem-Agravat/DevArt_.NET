<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="DevArt.Contact" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Help &amp; Support</asp:Content>

<asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        // Client-side half of cvMessage; Contact.aspx.cs runs the same rule server-side.
        function validateMessageLength(sender, args) {
            var text = (args.Value || "").trim();
            var words = text.length === 0 ? 0 : text.split(/\s+/).length;
            args.IsValid = words >= 10 && text.length <= 500;
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <h1 class="page-title">Help &amp; Support</h1>
        <p class="page-subtitle">Questions about an order, a fabric or a bulk enquiry? Write to us and our studio replies within one working day.</p>

        <div class="layout-split" style="grid-template-columns: 300px minmax(0, 1fr);">

            <div class="contact-methods">
                <div class="contact-method">
                    <h4>Email Us</h4>
                    <p>hello@devart.shop</p>
                </div>
                <div class="contact-method">
                    <h4>Call Our Studio</h4>
                    <p>+91 98765 43210</p>
                </div>
                <div class="contact-method">
                    <h4>Chat on WhatsApp</h4>
                    <p>Mon to Sat, 10 AM - 7 PM</p>
                </div>
                <div class="contact-method">
                    <h4>Visit Our Studio</h4>
                    <p>Kalavad Road, Rajkot - 360004<br />Open 10 AM - 7 PM</p>
                </div>
            </div>

            <div class="panel">
                <h3>Send us a message</h3>
                <p class="panel-hint">Fields marked <span class="req">*</span> are mandatory. Every rule below is enforced in the browser and again on the server.</p>

                <asp:Panel ID="pnlResult" runat="server" Visible="false">
                    <asp:Literal ID="litResult" runat="server" />
                </asp:Panel>

                <asp:ValidationSummary ID="vsContact" runat="server"
                    ValidationGroup="Contact"
                    CssClass="validation-summary"
                    HeaderText="Your enquiry could not be sent:"
                    DisplayMode="BulletList"
                    ShowSummary="true" />

                <div class="form-grid">
                    <div class="form-field">
                        <label>Full Name<span class="req">*</span></label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Enter your name" />
                        <asp:RequiredFieldValidator ID="rfvName" runat="server"
                            ControlToValidate="txtName" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Your name is required."
                            Text="Your name is required." />
                        <asp:RegularExpressionValidator ID="revName" runat="server"
                            ControlToValidate="txtName" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ValidationExpression="^[A-Za-z][A-Za-z\.\s]{2,49}$"
                            ErrorMessage="Name must be 3-50 letters (no digits or symbols)."
                            Text="Name must be 3-50 letters." />
                    </div>

                    <div class="form-field">
                        <label>Email Address<span class="req">*</span></label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input"
                            TextMode="Email" placeholder="example@email.com" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Email address is required."
                            Text="Email address is required." />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ValidationExpression="^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,10}$"
                            ErrorMessage="Enter a valid email address."
                            Text="Enter a valid email address." />
                    </div>

                    <div class="form-field">
                        <label>Mobile Number<span class="req">*</span></label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-input"
                            MaxLength="10" placeholder="9876543210" />
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                            ControlToValidate="txtPhone" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Mobile number is required."
                            Text="Mobile number is required." />
                        <asp:RegularExpressionValidator ID="revPhone" runat="server"
                            ControlToValidate="txtPhone" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ValidationExpression="^[6-9]\d{9}$"
                            ErrorMessage="Mobile number must be 10 digits starting with 6-9."
                            Text="Must be 10 digits starting with 6-9." />
                    </div>

                    <div class="form-field">
                        <label>Subject<span class="req">*</span></label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-input">
                            <asp:ListItem Text="General Inquiry" Value="" />
                            <asp:ListItem Text="Order status" Value="Order status" />
                            <asp:ListItem Text="Product / fabric enquiry" Value="Product enquiry" />
                            <asp:ListItem Text="Bulk or interior project" Value="Bulk order" />
                            <asp:ListItem Text="Returns and refunds" Value="Returns" />
                            <asp:ListItem Text="Something else" Value="Other" />
                        </asp:DropDownList>
                        <%-- InitialValue makes the "General Inquiry" placeholder count as unselected. --%>
                        <asp:RequiredFieldValidator ID="rfvSubject" runat="server"
                            ControlToValidate="ddlSubject" InitialValue="" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Please choose a subject."
                            Text="Please choose a subject." />
                    </div>

                    <div class="form-field">
                        <label>Rate your last experience (1-5)<span class="req">*</span></label>
                        <asp:TextBox ID="txtRating" runat="server" CssClass="form-input" MaxLength="1" placeholder="5" />
                        <asp:RequiredFieldValidator ID="rfvRating" runat="server"
                            ControlToValidate="txtRating" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="A rating between 1 and 5 is required."
                            Text="Rating is required." />
                        <%-- RangeValidator with an Integer type also rejects non-numeric input. --%>
                        <asp:RangeValidator ID="rngRating" runat="server"
                            ControlToValidate="txtRating" ValidationGroup="Contact"
                            Type="Integer" MinimumValue="1" MaximumValue="5"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Rating must be a whole number from 1 to 5."
                            Text="Rating must be 1-5." />
                    </div>

                    <div class="form-field">
                        <label>Preferred call-back date<span class="req">*</span></label>
                        <asp:TextBox ID="txtCallDate" runat="server" CssClass="form-input" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvCallDate" runat="server"
                            ControlToValidate="txtCallDate" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Pick a call-back date."
                            Text="Pick a call-back date." />
                        <%-- ValueToCompare is set in Page_Load to today's date. --%>
                        <asp:CompareValidator ID="cmpCallDate" runat="server"
                            ControlToValidate="txtCallDate" ValidationGroup="Contact"
                            Operator="GreaterThanEqual" Type="Date"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="The call-back date cannot be in the past."
                            Text="Date cannot be in the past." />
                    </div>

                    <div class="form-field full">
                        <label>Your Message<span class="req">*</span></label>
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="form-input"
                            TextMode="MultiLine" Rows="5" placeholder="How can we help you today?" />
                        <asp:RequiredFieldValidator ID="rfvMessage" runat="server"
                            ControlToValidate="txtMessage" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Please write your message."
                            Text="Please write your message." />
                        <%-- A word-count rule no built-in validator covers, so a CustomValidator
                             carries it on both the client and the server. --%>
                        <asp:CustomValidator ID="cvMessage" runat="server"
                            ControlToValidate="txtMessage" ValidationGroup="Contact"
                            CssClass="field-error" Display="Dynamic"
                            ClientValidationFunction="validateMessageLength"
                            OnServerValidate="cvMessage_ServerValidate"
                            ErrorMessage="The message must contain at least 10 words (and stay under 500 characters)."
                            Text="Write at least 10 words." />
                    </div>

                    <div class="form-field full">
                        <div class="form-check">
                            <asp:CheckBox ID="chkCopy" runat="server" Text="Email me a copy of this enquiry" />
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="newsletter-btn"
                        ValidationGroup="Contact" OnClick="btnSend_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Clear form" CssClass="link-button"
                        CausesValidation="false" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlEnquiries" runat="server" Visible="false" CssClass="panel" style="margin-top: 26px;">
            <h3>Enquiries received this session</h3>
            <p class="panel-hint">Read back from the in-memory List&lt;Enquiry&gt; collection.</p>
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

</asp:Content>
