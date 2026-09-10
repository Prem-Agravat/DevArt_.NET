<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OfferEdit.aspx.cs" Inherits="DevArt.Admin.OfferEdit" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Offer</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-head">
        <h1><asp:Literal ID="litHeading" runat="server" /></h1>
        <a href="Offers.aspx" class="btn-outline">Back to Offers</a>
    </div>

    <div class="admin-card" style="max-width: 720px;">

        <asp:ValidationSummary ID="vsOffer" runat="server"
            ValidationGroup="Offer" CssClass="validation-summary"
            HeaderText="The offer could not be saved:" DisplayMode="BulletList" />

        <div class="form-grid">
            <div class="form-field">
                <label>Offer Name<span class="req">*</span></label>
                <asp:TextBox ID="txtKicker" runat="server" CssClass="form-input"
                    MaxLength="30" placeholder="WELCOME OFFER" />
                <asp:RequiredFieldValidator ID="rfvKicker" runat="server"
                    ControlToValidate="txtKicker" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Offer name is required."
                    Text="Offer name is required." />
            </div>

            <div class="form-field">
                <label>Offer Title<span class="req">*</span></label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-input"
                    MaxLength="60" placeholder="15% OFF First Order" />
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server"
                    ControlToValidate="txtTitle" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Offer title is required."
                    Text="Offer title is required." />
            </div>

            <div class="form-field">
                <label>Promo Code<span class="req">*</span></label>
                <asp:TextBox ID="txtCode" runat="server" CssClass="form-input"
                    MaxLength="12" placeholder="NEWARTISAN15" />
                <asp:RequiredFieldValidator ID="rfvCode" runat="server"
                    ControlToValidate="txtCode" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Promo code is required."
                    Text="Promo code is required." />
                <asp:RegularExpressionValidator ID="revCode" runat="server"
                    ControlToValidate="txtCode" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ValidationExpression="^[A-Za-z0-9]{5,12}$"
                    ErrorMessage="A promo code is 5-12 letters or digits, with no spaces."
                    Text="5-12 letters or digits, no spaces." />
                <%-- Two offers may not share a code, which only the server can know. --%>
                <asp:CustomValidator ID="cvCode" runat="server"
                    ControlToValidate="txtCode" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    OnServerValidate="cvCode_ServerValidate"
                    ErrorMessage="Another offer already uses that promo code."
                    Text="That code is already in use." />
            </div>

            <div class="form-field">
                <label>Discount Type<span class="req">*</span></label>
                <asp:DropDownList ID="ddlType" runat="server" CssClass="form-input"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                    <asp:ListItem Text="-- Select a type --" Value="" />
                    <asp:ListItem Text="Percentage off" Value="Percentage" />
                    <asp:ListItem Text="Flat rupee amount off" Value="Flat" />
                    <asp:ListItem Text="Free delivery" Value="FreeShipping" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvType" runat="server"
                    ControlToValidate="ddlType" InitialValue="" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Please choose a discount type."
                    Text="Please choose a discount type." />
            </div>

            <asp:Panel ID="pnlPercentage" runat="server" Visible="false" CssClass="form-field">
                <label>Discount Percentage<span class="req">*</span></label>
                <asp:TextBox ID="txtPercentage" runat="server" CssClass="form-input" MaxLength="2" placeholder="15" />
                <asp:RequiredFieldValidator ID="rfvPercentage" runat="server" Enabled="false"
                    ControlToValidate="txtPercentage" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Discount percentage is required."
                    Text="Discount percentage is required." />
                <asp:RangeValidator ID="rngPercentage" runat="server" Enabled="false"
                    ControlToValidate="txtPercentage" ValidationGroup="Offer"
                    Type="Integer" MinimumValue="1" MaximumValue="90"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Percentage must be a whole number from 1 to 90."
                    Text="Percentage must be 1-90." />
            </asp:Panel>

            <asp:Panel ID="pnlFlat" runat="server" Visible="false" CssClass="form-field">
                <label>Discount Amount (&#8377;)<span class="req">*</span></label>
                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-input" placeholder="200" />
                <asp:RequiredFieldValidator ID="rfvAmount" runat="server" Enabled="false"
                    ControlToValidate="txtAmount" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Discount amount is required."
                    Text="Discount amount is required." />
                <asp:RangeValidator ID="rngAmount" runat="server" Enabled="false"
                    ControlToValidate="txtAmount" ValidationGroup="Offer"
                    Type="Currency" MinimumValue="1" MaximumValue="5000"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Discount amount must be between 1 and 5000."
                    Text="Amount must be 1-5000." />
            </asp:Panel>

            <div class="form-field">
                <label>Min. Spend Limit (&#8377;)<span class="req">*</span></label>
                <asp:TextBox ID="txtMinSpend" runat="server" CssClass="form-input" Text="0" />
                <asp:RequiredFieldValidator ID="rfvMinSpend" runat="server"
                    ControlToValidate="txtMinSpend" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Minimum spend is required (use 0 for none)."
                    Text="Minimum spend is required." />
                <asp:RangeValidator ID="rngMinSpend" runat="server"
                    ControlToValidate="txtMinSpend" ValidationGroup="Offer"
                    Type="Currency" MinimumValue="0" MaximumValue="100000"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Minimum spend must be a number between 0 and 100000."
                    Text="Must be between 0 and 100000." />
                <%-- A flat discount larger than the minimum spend would give stock away. --%>
                <asp:CustomValidator ID="cvMinSpend" runat="server"
                    ValidationGroup="Offer" CssClass="field-error" Display="Dynamic"
                    OnServerValidate="cvMinSpend_ServerValidate"
                    ErrorMessage="A flat discount cannot be larger than its minimum spend."
                    Text="Flat discount exceeds the minimum spend." />
            </div>

            <div class="form-field">
                <label>Expiration Date<span class="req">*</span></label>
                <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-input" TextMode="Date" />
                <asp:RequiredFieldValidator ID="rfvExpiry" runat="server"
                    ControlToValidate="txtExpiry" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Expiration date is required."
                    Text="Expiration date is required." />
                <%-- ValueToCompare is set in Page_Load to tomorrow. --%>
                <asp:CompareValidator ID="cmpExpiry" runat="server"
                    ControlToValidate="txtExpiry" ValidationGroup="Offer"
                    Operator="GreaterThan" Type="Date"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="An offer must expire in the future."
                    Text="Expiry must be in the future." />
            </div>

            <div class="form-field full">
                <label>Description<span class="req">*</span></label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-input"
                    TextMode="MultiLine" Rows="3" placeholder="Who is this offer for?" />
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server"
                    ControlToValidate="txtDescription" ValidationGroup="Offer"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Description is required."
                    Text="Description is required." />
            </div>

            <div class="form-field full">
                <div class="form-check">
                    <asp:CheckBox ID="chkActive" runat="server" Checked="true" Text="Active" />
                </div>
            </div>
        </div>

        <div class="form-actions">
            <asp:Button ID="btnSave" runat="server" Text="Add Offer" CssClass="newsletter-btn"
                ValidationGroup="Offer" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="link-button"
                CausesValidation="false" OnClick="btnCancel_Click" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete Offer" CssClass="danger-btn"
                Visible="false" CausesValidation="false" OnClick="btnDelete_Click"
                OnClientClick="return confirm('Delete this offer? This action cannot be undone.');" />
        </div>
    </div>

</asp:Content>
