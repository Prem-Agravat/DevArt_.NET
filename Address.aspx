<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Address.aspx.cs" Inherits="DevArt.AddressPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Add New Address</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="addr-page-wrapper">
        <div class="addr-card-container">
            
            <!-- Top Logo Badge Header -->
            <div class="addr-header-banner">
                <div class="addr-logo-badge">
                    <img src="Images/devart-logo.png" alt="DevArt Logo" />
                </div>
                <div class="addr-title-row">
                    <asp:HyperLink ID="lnkBack" runat="server" CssClass="addr-back-btn" title="Back">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#222222" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10" stroke="#222222" stroke-width="1.8" fill="rgba(255,255,255,0.4)"/>
                            <polyline points="13 8 9 12 13 16" stroke="#222222" stroke-width="2"/>
                        </svg>
                    </asp:HyperLink>
                    <h1 class="addr-page-title">Add New Address</h1>
                </div>
            </div>

            <!-- Form Card -->
            <asp:Panel ID="pnlForm" runat="server" CssClass="addr-form-card" DefaultButton="btnSave">

                <asp:ValidationSummary ID="vsAddress" runat="server"
                    ValidationGroup="Address" CssClass="validation-summary"
                    HeaderText="The address could not be saved:" DisplayMode="BulletList" />

                <!-- CONTACT DETAILS -->
                <div class="addr-section">
                    <h2 class="addr-section-title">CONTACT DETAILS</h2>

                    <div class="addr-field-group">
                        <div class="addr-input-with-icon">
                            <span class="addr-field-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#6B3E26" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </span>
                            <asp:TextBox ID="txtName" runat="server" CssClass="addr-input" placeholder="Full Name" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server"
                            ControlToValidate="txtName" ValidationGroup="Address"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Full name is required." Text="Full name is required." />
                        <asp:RegularExpressionValidator ID="revName" runat="server"
                            ControlToValidate="txtName" ValidationGroup="Address"
                            CssClass="field-error" Display="Dynamic"
                            ValidationExpression="^[A-Za-z][A-Za-z\.\s]{2,49}$"
                            ErrorMessage="Name must be 3-50 letters." Text="Name must be 3-50 letters." />
                    </div>

                    <div class="addr-field-group">
                        <div class="addr-input-with-icon">
                            <span class="addr-field-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#6B3E26" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                                </svg>
                            </span>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="addr-input" MaxLength="10" placeholder="Phone Number" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                            ControlToValidate="txtPhone" ValidationGroup="Address"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Phone number is required." Text="Phone number is required." />
                        <asp:RegularExpressionValidator ID="revPhone" runat="server"
                            ControlToValidate="txtPhone" ValidationGroup="Address"
                            CssClass="field-error" Display="Dynamic"
                            ValidationExpression="^[6-9]\d{9}$"
                            ErrorMessage="Phone number must be 10 digits starting with 6-9." Text="Must be 10 digits starting with 6-9." />
                    </div>
                </div>

                <!-- ADDRESS DETAILS -->
                <div class="addr-section">
                    <h2 class="addr-section-title">ADDRESS DETAILS</h2>

                    <div class="addr-field-group">
                        <div class="addr-input-with-icon">
                            <span class="addr-field-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#6B3E26" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                    <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                </svg>
                            </span>
                            <asp:TextBox ID="txtLine1" runat="server" CssClass="addr-input" MaxLength="120"
                                placeholder="Flat/House No., Building, Apartment" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvLine1" runat="server"
                            ControlToValidate="txtLine1" ValidationGroup="Address"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="The building or flat line is required." Text="This line is required." />
                        <asp:CustomValidator ID="cvLine1" runat="server"
                            ControlToValidate="txtLine1" ValidationGroup="Address"
                            CssClass="field-error" Display="Dynamic"
                            ClientValidationFunction="validateAddressLine"
                            OnServerValidate="cvLine1_ServerValidate"
                            ErrorMessage="Give at least 6 characters." Text="Too short to deliver to." />
                    </div>

                    <div class="addr-field-group">
                        <div class="addr-input-with-icon">
                            <span class="addr-field-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#6B3E26" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                    <circle cx="12" cy="10" r="3"></circle>
                                </svg>
                            </span>
                            <asp:TextBox ID="txtLine2" runat="server" CssClass="addr-input" MaxLength="120"
                                placeholder="Area, Colony, Street, Sector, Landmark (Optional)" />
                        </div>
                    </div>

                    <div class="addr-grid-two">
                        <div class="addr-field-group">
                            <asp:TextBox ID="txtPincode" runat="server" CssClass="addr-input no-left-icon" MaxLength="6" placeholder="Pincode" />
                            <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                                ControlToValidate="txtPincode" ValidationGroup="Address"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Pincode is required." Text="Pincode is required." />
                            <asp:RegularExpressionValidator ID="revPincode" runat="server"
                                ControlToValidate="txtPincode" ValidationGroup="Address"
                                CssClass="field-error" Display="Dynamic"
                                ValidationExpression="^[1-9][0-9]{5}$"
                                ErrorMessage="Pincode must be 6 digits." Text="Pincode must be 6 digits." />
                        </div>

                        <div class="addr-field-group">
                            <asp:TextBox ID="txtCity" runat="server" CssClass="addr-input no-left-icon" placeholder="Town/City" />
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                                ControlToValidate="txtCity" ValidationGroup="Address"
                                CssClass="field-error" Display="Dynamic"
                                ErrorMessage="Town/City is required." Text="Town/City is required." />
                            <asp:RegularExpressionValidator ID="revCity" runat="server"
                                ControlToValidate="txtCity" ValidationGroup="Address"
                                CssClass="field-error" Display="Dynamic"
                                ValidationExpression="^[A-Za-z][A-Za-z\s\.\-]{1,39}$"
                                ErrorMessage="City must be 2-40 letters." Text="City must be 2-40 letters." />
                        </div>
                    </div>

                    <div class="addr-field-group">
                        <div class="addr-select-wrapper">
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="addr-select">
                                <asp:ListItem Text="Select State" Value="" />
                                <asp:ListItem Text="Gujarat" Value="Gujarat" />
                                <asp:ListItem Text="Maharashtra" Value="Maharashtra" />
                                <asp:ListItem Text="Rajasthan" Value="Rajasthan" />
                                <asp:ListItem Text="Madhya Pradesh" Value="Madhya Pradesh" />
                                <asp:ListItem Text="Karnataka" Value="Karnataka" />
                                <asp:ListItem Text="Delhi" Value="Delhi" />
                            </asp:DropDownList>
                            <span class="addr-select-arrow">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#444444" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="6 9 12 15 18 9"></polyline>
                                </svg>
                            </span>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvState" runat="server"
                            ControlToValidate="ddlState" InitialValue="" ValidationGroup="Address"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Please select a state." Text="Please select a state." />
                    </div>
                </div>

                <!-- SAVE AS -->
                <div class="addr-section">
                    <h2 class="addr-section-title">SAVE AS</h2>

                    <div class="addr-saveas-row">
                        <div class="addr-saveas-pill selected" onclick="selectSaveAs('Home', this)">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#6B3E26" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                <polyline points="9 22 9 12 15 12 15 22"></polyline>
                            </svg>
                            <span>Home</span>
                        </div>
                        <div class="addr-saveas-pill" onclick="selectSaveAs('Office', this)">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#6B3E26" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                            </svg>
                            <span>Office</span>
                        </div>
                        <div class="addr-saveas-pill" onclick="selectSaveAs('Other', this)">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#6B3E26" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="1"></circle>
                                <circle cx="19" cy="12" r="1"></circle>
                                <circle cx="5" cy="12" r="1"></circle>
                            </svg>
                            <span>Other</span>
                        </div>

                        <div style="display:none;">
                            <asp:RadioButtonList ID="rblLabel" runat="server">
                                <asp:ListItem Text="Home" Value="Home" Selected="True" />
                                <asp:ListItem Text="Office" Value="Office" />
                                <asp:ListItem Text="Other" Value="Other" />
                            </asp:RadioButtonList>
                        </div>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvLabel" runat="server"
                        ControlToValidate="rblLabel" InitialValue="" ValidationGroup="Address"
                        CssClass="field-error" Display="Dynamic"
                        ErrorMessage="Choose whether this is Home, Office or Other." Text="Choose a label." />
                </div>

                <div class="addr-field-group" style="margin-top:10px;">
                    <div class="addr-checkbox-row">
                        <asp:CheckBox ID="chkDefault" runat="server" Text="Make this my default delivery address" />
                    </div>
                </div>

                <div class="addr-btn-wrapper">
                    <button type="button" id="btnSaveSubmit" class="addr-submit-btn" onclick="triggerSave(event);">
                        <span>Save Address</span>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
                            <polyline points="17 21 17 13 7 13 7 21"></polyline>
                            <polyline points="7 3 7 8 15 8"></polyline>
                        </svg>
                    </button>
                    <asp:Button ID="btnSave" runat="server" Text="Save Address" Style="display:none;"
                        ValidationGroup="Address" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="addr-cancel-btn"
                        CausesValidation="false" OnClick="btnCancel_Click" />
                </div>

            </asp:Panel>
        </div>
    </main>

    <script type="text/javascript">
        function validateAddressLine(sender, args) {
            args.IsValid = (args.Value || "").trim().length >= 6;
        }

        function selectSaveAs(val, el) {
            var pills = document.querySelectorAll('.addr-saveas-pill');
            pills.forEach(function (p) { p.classList.remove('selected'); });
            el.classList.add('selected');

            var radioList = document.querySelectorAll('#<%= rblLabel.ClientID %> input[type="radio"]');
            radioList.forEach(function (r) {
                if (r.value === val) r.checked = true;
            });
        }

        function triggerSave(e) {
            e.preventDefault();
            document.getElementById('<%= btnSave.ClientID %>').click();
        }
    </script>

</asp:Content>
