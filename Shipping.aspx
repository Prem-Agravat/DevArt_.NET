<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shipping.aspx.cs" Inherits="DevArt.Shipping" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Shipping Information</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="ship-page-wrapper">
        <h1 class="ship-page-title">Shipping Information</h1>

        <div class="ship-container">

            <!-- LEFT COLUMN: Dashed Container -->
            <div class="ship-left-col">
                <div class="ship-dashed-card">

                    <!-- Navigation Links & Breadcrumbs -->
                    <div class="ship-nav-row">
                        <a href="Cart.aspx" class="ship-return-cart-link">&lt; Return to Cart</a>
                        <div class="ship-steps">
                            <span class="ship-step">Cart</span>
                            <span class="ship-step-sep">&gt;</span>
                            <span class="ship-step active">Shipping</span>
                            <span class="ship-step-sep">&gt;</span>
                            <span class="ship-step">Payment</span>
                        </div>
                    </div>

                    <!-- Header inside card -->
                    <div class="ship-header-row">
                        <h2 class="ship-section-heading">Shipping Address</h2>
                        <a href="Address.aspx?returnUrl=Shipping.aspx" class="ship-edit-address-link">Edit Address</a>
                    </div>

                    <asp:ValidationSummary ID="vsShip" runat="server"
                        ValidationGroup="Ship" CssClass="validation-summary"
                        HeaderText="We cannot continue yet:" DisplayMode="BulletList" />

                    <!-- Address List Repeater -->
                    <asp:Repeater ID="rptAddresses" runat="server">
                        <ItemTemplate>
                            <div class="ship-address-card <%# Convert.ToInt32(Eval("Id")) == SelectedAddressId ? "selected" : "" %>"
                                 onclick="selectAddressCard(this, <%# Eval("Id") %>)">
                                <div class="ship-address-icon-box">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#D97757" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7z"></path>
                                        <circle cx="12" cy="9" r="2.5"></circle>
                                    </svg>
                                </div>
                                <div class="ship-address-info">
                                    <div class="ship-address-name"><%# Server.HtmlEncode(Convert.ToString(Eval("FullName"))) %></div>
                                    <div class="ship-address-text"><%# Server.HtmlEncode(Convert.ToString(Eval("Line1"))) %><%# string.IsNullOrEmpty(Convert.ToString(Eval("Line2"))) ? "" : ", " + Server.HtmlEncode(Convert.ToString(Eval("Line2"))) %></div>
                                    <div class="ship-address-text"><%# Server.HtmlEncode(Convert.ToString(Eval("City"))) %>, <%# Server.HtmlEncode(Convert.ToString(Eval("State"))) %> <%# Server.HtmlEncode(Convert.ToString(Eval("Pincode"))) %></div>
                                    <div class="ship-address-text">India</div>
                                    <div class="ship-address-phone">+91 <%# Server.HtmlEncode(Convert.ToString(Eval("Phone"))) %></div>
                                </div>
                                <div class="ship-address-radio">
                                    <input type="radio" name="addressChoice" value="<%# Eval("Id") %>" <%# Convert.ToInt32(Eval("Id")) == SelectedAddressId ? "checked='checked'" : "" %> />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <!-- Add New Address Card -->
                    <a href="Address.aspx?returnUrl=Shipping.aspx" class="ship-add-address-card">
                        <div class="ship-address-icon-box">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#D97757" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7z"></path>
                                <circle cx="12" cy="9" r="2.5"></circle>
                            </svg>
                        </div>
                        <span class="ship-add-address-title">Add New Address</span>
                    </a>

                    <!-- Hidden Fields & Fallback Controls -->
                    <asp:HiddenField ID="hfSelectedAddressId" runat="server" />
                    <div style="display:none;">
                        <asp:RadioButtonList ID="rblAddresses" runat="server" DataTextField="Display" DataValueField="Id" />
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                            ControlToValidate="rblAddresses" InitialValue="" ValidationGroup="Ship"
                            CssClass="field-error" Display="Dynamic"
                            ErrorMessage="Choose a delivery address to continue."
                            Text="Choose a delivery address." />
                    </div>

                    <!-- Footer Actions -->
                    <div class="ship-actions-row">
                        <a href="Cart.aspx" class="ship-footer-return">&lt; Return to Information</a>
                        <asp:Button ID="btnContinue" runat="server" Text="Continue to Payment"
                            CssClass="ship-continue-btn" ValidationGroup="Ship" OnClick="btnContinue_Click" />
                    </div>

                </div>
            </div>

            <!-- RIGHT COLUMN: Order Summary Card -->
            <div class="ship-right-col">
                <div class="ship-summary-card">
                    <h2 class="ship-summary-title">Order Summary</h2>

                    <div class="ship-summary-items">
                        <asp:Repeater ID="rptLines" runat="server">
                            <ItemTemplate>
                                <div class="ship-item-row">
                                    <img src="<%# FormatImageUrl(Eval("Image")) %>" alt="<%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %>" class="ship-item-thumb" onerror="this.src='Images/category_cushion.jpg';" />
                                    <div class="ship-item-details">
                                        <div class="ship-item-name"><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></div>
                                        <div class="ship-item-meta"><%# string.IsNullOrEmpty(Convert.ToString(Eval("Variant"))) ? "Standard" : Server.HtmlEncode(Convert.ToString(Eval("Variant"))) %></div>
                                    </div>
                                    <div class="ship-item-price">&#8377;<%# Eval("Amount", "{0:N0}") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="ship-summary-divider"></div>

                    <div class="ship-summary-line">
                        <span class="label">Subtotal</span>
                        <span class="value">&#8377;<asp:Literal ID="litSubTotal" runat="server" /></span>
                    </div>

                    <asp:Panel ID="pnlDiscount" runat="server" Visible="false" CssClass="ship-summary-line discount">
                        <span class="label">Discount</span>
                        <span class="value">-&#8377;<asp:Literal ID="litDiscount" runat="server" /></span>
                    </asp:Panel>

                    <div class="ship-summary-line">
                        <span class="label">Shipping</span>
                        <span class="value muted"><asp:Literal ID="litShipping" runat="server" /></span>
                    </div>

                    <div class="ship-summary-divider"></div>

                    <div class="ship-summary-line total">
                        <span class="label">Total</span>
                        <span class="value">&#8377;<asp:Literal ID="litTotal" runat="server" /></span>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <script type="text/javascript">
        function selectAddressCard(cardEl, id) {
            var cards = document.querySelectorAll('.ship-address-card');
            cards.forEach(function (c) {
                c.classList.remove('selected');
                var r = c.querySelector('input[type="radio"]');
                if (r) r.checked = false;
            });

            cardEl.classList.add('selected');
            var radio = cardEl.querySelector('input[type="radio"]');
            if (radio) radio.checked = true;

            var hf = document.getElementById('<%= hfSelectedAddressId.ClientID %>');
            if (hf) hf.value = id;

            var rbl = document.getElementById('<%= rblAddresses.ClientID %>');
            if (rbl) {
                var radios = rbl.getElementsByTagName('input');
                for (var i = 0; i < radios.length; i++) {
                    if (radios[i].value == id) {
                        radios[i].checked = true;
                    }
                }
            }
        }
    </script>

</asp:Content>
