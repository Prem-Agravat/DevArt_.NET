<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Address.aspx.cs" Inherits="DevArt.AddressPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Add New Address</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <p class="breadcrumb"><asp:HyperLink ID="lnkBack" runat="server" Text="Back" /></p>
        <h1 class="page-title">Add New Address</h1>
        <p class="page-subtitle">Every field below is checked in the browser and re-checked on the server before the address is saved.</p>

        <div class="panel" style="max-width: 720px;">

            <asp:ValidationSummary ID="vsAddress" runat="server"
                ValidationGroup="Address" CssClass="validation-summary"
                HeaderText="The address could not be saved:" DisplayMode="BulletList" />

            <h3>Contact Details</h3>
            <p class="panel-hint">Who should the courier ask for?</p>

            <div class="form-grid">
                <div class="form-field">
                    <label>Full Name<span class="req">*</span></label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Full name" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server"
                        ControlToValidate="txtName" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Full name is required."
                        Text="Full name is required." />
                    <asp:RegularExpressionValidator ID="revName" runat="server"
                        ControlToValidate="txtName" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[A-Za-z][A-Za-z\.\s]{2,49}$"
                        ErrorMessage="Name must be 3-50 letters (no digits or symbols)."
                        Text="Name must be 3-50 letters." />
                </div>

                <div class="form-field">
                    <label>Phone Number<span class="req">*</span></label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-input" MaxLength="10" placeholder="9876543210" />
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                        ControlToValidate="txtPhone" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Phone number is required."
                        Text="Phone number is required." />
                    <asp:RegularExpressionValidator ID="revPhone" runat="server"
                        ControlToValidate="txtPhone" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[6-9]\d{9}$"
                        ErrorMessage="Phone number must be 10 digits starting with 6-9."
                        Text="Must be 10 digits starting with 6-9." />
                </div>
            </div>

            <h3 style="margin-top:26px;">Address Details</h3>
            <p class="panel-hint">Where should we deliver?</p>

            <div class="form-grid">
                <div class="form-field full">
                    <label>Flat / House No., Building, Apartment<span class="req">*</span></label>
                    <asp:TextBox ID="txtLine1" runat="server" CssClass="form-input" MaxLength="120"
                        placeholder="102, Craftmen&#39;s Plaza" />
                    <asp:RequiredFieldValidator ID="rfvLine1" runat="server"
                        ControlToValidate="txtLine1" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="The building or flat line is required."
                        Text="This line is required." />
                    <%-- A courier cannot work with two characters, so a minimum length is enforced. --%>
                    <asp:CustomValidator ID="cvLine1" runat="server"
                        ControlToValidate="txtLine1" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ClientValidationFunction="validateAddressLine"
                        OnServerValidate="cvLine1_ServerValidate"
                        ErrorMessage="Give at least 6 characters for the building or flat line."
                        Text="Too short to deliver to." />
                </div>

                <div class="form-field full">
                    <label>Area, Colony, Street, Sector, Landmark (Optional)</label>
                    <asp:TextBox ID="txtLine2" runat="server" CssClass="form-input" MaxLength="120"
                        placeholder="Kalavad Road, near Crystal Mall" />
                </div>

                <div class="form-field">
                    <label>Pincode<span class="req">*</span></label>
                    <asp:TextBox ID="txtPincode" runat="server" CssClass="form-input" MaxLength="6" placeholder="360004" />
                    <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                        ControlToValidate="txtPincode" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Pincode is required."
                        Text="Pincode is required." />
                    <asp:RegularExpressionValidator ID="revPincode" runat="server"
                        ControlToValidate="txtPincode" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[1-9][0-9]{5}$"
                        ErrorMessage="Pincode must be 6 digits and cannot start with 0."
                        Text="Pincode must be 6 digits." />
                </div>

                <div class="form-field">
                    <label>Town / City<span class="req">*</span></label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-input" placeholder="Rajkot" />
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                        ControlToValidate="txtCity" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Town or city is required."
                        Text="Town or city is required." />
                    <asp:RegularExpressionValidator ID="revCity" runat="server"
                        ControlToValidate="txtCity" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ValidationExpression="^[A-Za-z][A-Za-z\s\.\-]{1,39}$"
                        ErrorMessage="City must be 2-40 letters."
                        Text="City must be 2-40 letters." />
                </div>

                <div class="form-field">
                    <label>State<span class="req">*</span></label>
                    <asp:DropDownList ID="ddlState" runat="server" CssClass="form-input">
                        <asp:ListItem Text="Select State" Value="" />
                        <asp:ListItem Text="Gujarat" Value="Gujarat" />
                        <asp:ListItem Text="Maharashtra" Value="Maharashtra" />
                        <asp:ListItem Text="Rajasthan" Value="Rajasthan" />
                        <asp:ListItem Text="Madhya Pradesh" Value="Madhya Pradesh" />
                        <asp:ListItem Text="Karnataka" Value="Karnataka" />
                        <asp:ListItem Text="Delhi" Value="Delhi" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvState" runat="server"
                        ControlToValidate="ddlState" InitialValue="" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Please select a state."
                        Text="Please select a state." />
                </div>

                <div class="form-field">
                    <label>Save As<span class="req">*</span></label>
                    <asp:RadioButtonList ID="rblLabel" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                        <asp:ListItem Text="Home" Value="Home" />
                        <asp:ListItem Text="Office" Value="Office" />
                        <asp:ListItem Text="Other" Value="Other" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="rfvLabel" runat="server"
                        ControlToValidate="rblLabel" InitialValue="" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Choose whether this is Home, Office or Other."
                        Text="Choose a label." />
                </div>

                <div class="form-field full">
                    <div class="form-check">
                        <asp:CheckBox ID="chkDefault" runat="server" Text="Make this my default delivery address" />
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <asp:Button ID="btnSave" runat="server" Text="Save Address" CssClass="newsletter-btn"
                    ValidationGroup="Address" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="link-button"
                    CausesValidation="false" OnClick="btnCancel_Click" />
            </div>
        </div>
    </main>

    <script type="text/javascript">
        // Client-side half of cvLine1; Address.aspx.cs runs the same rule in C#.
        function validateAddressLine(sender, args) {
            args.IsValid = (args.Value || "").trim().length >= 6;
        }
    </script>

</asp:Content>
