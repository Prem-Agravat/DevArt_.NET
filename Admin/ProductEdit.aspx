<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ProductEdit.aspx.cs" Inherits="DevArt.Admin.ProductEdit" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Product</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-head">
        <h1><asp:Literal ID="litHeading" runat="server" /></h1>
        <a href="Inventory.aspx" class="btn-outline">Back to Inventory</a>
    </div>

    <div class="admin-card" style="max-width: 760px;">

        <asp:ValidationSummary ID="vsProduct" runat="server"
            ValidationGroup="Product" CssClass="validation-summary"
            HeaderText="The product could not be saved:" DisplayMode="BulletList" />

        <div class="form-grid">
            <div class="form-field full">
                <label>Product Name<span class="req">*</span></label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-input"
                    MaxLength="80" placeholder="e.g. Handcrafted Ceramic Vase" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server"
                    ControlToValidate="txtName" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Product name is required."
                    Text="Product name is required." />
                <%-- Two products may not share a name, which only the server can check. --%>
                <asp:CustomValidator ID="cvName" runat="server"
                    ControlToValidate="txtName" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    OnServerValidate="cvName_ServerValidate"
                    ErrorMessage="Another product already uses that name."
                    Text="That name is already taken." />
            </div>

            <div class="form-field">
                <label>Category<span class="req">*</span></label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-input">
                    <asp:ListItem Text="-- Select a category --" Value="" />
                    <asp:ListItem Text="Torans" Value="Torans" />
                    <asp:ListItem Text="Cushion Covers" Value="Cushion Covers" />
                    <asp:ListItem Text="Sofa &amp; Table Covers" Value="Sofa &amp; Table Covers" />
                    <asp:ListItem Text="Bedsheet" Value="Bedsheet" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategory" runat="server"
                    ControlToValidate="ddlCategory" InitialValue="" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Please choose a category."
                    Text="Please choose a category." />
            </div>

            <div class="form-field">
                <label>Price (&#8377;)<span class="req">*</span></label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-input" placeholder="0.00" />
                <asp:RequiredFieldValidator ID="rfvPrice" runat="server"
                    ControlToValidate="txtPrice" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Price is required."
                    Text="Price is required." />
                <%-- A Currency range rejects text and keeps the price sane. --%>
                <asp:RangeValidator ID="rngPrice" runat="server"
                    ControlToValidate="txtPrice" ValidationGroup="Product"
                    Type="Currency" MinimumValue="1" MaximumValue="100000"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Price must be a number between 1 and 100000."
                    Text="Price must be between 1 and 100000." />
            </div>

            <div class="form-field">
                <label>Stock Quantity<span class="req">*</span></label>
                <asp:TextBox ID="txtStock" runat="server" CssClass="form-input" Text="1" MaxLength="4" />
                <asp:RequiredFieldValidator ID="rfvStock" runat="server"
                    ControlToValidate="txtStock" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Stock quantity is required."
                    Text="Stock quantity is required." />
                <asp:RangeValidator ID="rngStock" runat="server"
                    ControlToValidate="txtStock" ValidationGroup="Product"
                    Type="Integer" MinimumValue="0" MaximumValue="9999"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Stock must be a whole number from 0 to 9999."
                    Text="Stock must be 0-9999." />
            </div>

            <div class="form-field">
                <label>Product Image<span class="req">*</span></label>
                <asp:DropDownList ID="ddlImage" runat="server" CssClass="form-input">
                    <asp:ListItem Text="-- Select an image --" Value="" />
                    <asp:ListItem Text="Torans" Value="category_torans.jpg" />
                    <asp:ListItem Text="Cushion" Value="category_cushion.jpg" />
                    <asp:ListItem Text="Sofa cover" Value="category_sofacover.jpg" />
                    <asp:ListItem Text="Bedsheet" Value="category_bedsheet.jpg" />
                    <asp:ListItem Text="Velvet pillow" Value="product_velvet_pillow.jpg" />
                    <asp:ListItem Text="Cushion set" Value="product_cushion_set.jpg" />
                    <asp:ListItem Text="Ceramic vase" Value="product_ceramic_vase.jpg" />
                    <asp:ListItem Text="Nesting tables" Value="product_nesting_tables.jpg" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvImage" runat="server"
                    ControlToValidate="ddlImage" InitialValue="" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Please choose a product photo."
                    Text="Please choose a product photo." />
            </div>

            <div class="form-field full">
                <label>Material / Sub-title<span class="req">*</span></label>
                <asp:TextBox ID="txtMaterial" runat="server" CssClass="form-input"
                    MaxLength="80" placeholder="Handwoven cotton" />
                <asp:RequiredFieldValidator ID="rfvMaterial" runat="server"
                    ControlToValidate="txtMaterial" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Material is required."
                    Text="Material is required." />
            </div>

            <div class="form-field full">
                <label>Description<span class="req">*</span></label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-input"
                    TextMode="MultiLine" Rows="4" placeholder="Tell the story behind this piece..." />
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server"
                    ControlToValidate="txtDescription" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    ErrorMessage="Description is required."
                    Text="Description is required." />
                <%-- Shoppers need more than a line; enforced on both sides. --%>
                <asp:CustomValidator ID="cvDescription" runat="server"
                    ControlToValidate="txtDescription" ValidationGroup="Product"
                    CssClass="field-error" Display="Dynamic"
                    ClientValidationFunction="validateDescription"
                    OnServerValidate="cvDescription_ServerValidate"
                    ErrorMessage="The description needs at least 10 words and must stay under 600 characters."
                    Text="Write at least 10 words." />
            </div>

            <div class="form-field full">
                <div class="form-check">
                    <asp:CheckBox ID="chkNew" runat="server" Text="Flag as New Collection" />
                </div>
            </div>
        </div>

        <div class="form-actions">
            <asp:Button ID="btnSave" runat="server" Text="Save Product" CssClass="newsletter-btn"
                ValidationGroup="Product" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="link-button"
                CausesValidation="false" OnClick="btnCancel_Click" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete Product" CssClass="danger-btn"
                Visible="false" CausesValidation="false" OnClick="btnDelete_Click"
                OnClientClick="return confirm('Delete this product? This action cannot be undone.');" />
        </div>
    </div>

    <script type="text/javascript">
        // Client-side half of cvDescription; the C# handler applies the same rule.
        function validateDescription(sender, args) {
            var text = (args.Value || "").trim();
            var words = text.length === 0 ? 0 : text.split(/\s+/).length;
            args.IsValid = words >= 10 && text.length <= 600;
        }
    </script>

</asp:Content>
