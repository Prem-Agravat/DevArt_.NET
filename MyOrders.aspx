<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="DevArt.MyOrders" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - My Orders</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="item-detail-wrapper" style="padding-bottom: 60px;">

        <!-- CENTERED HERO TITLE -->
        <h1 class="myorders-hero-title">My Orders</h1>

        <asp:Panel ID="pnlGuest" runat="server" Visible="false" CssClass="prof-empty-card" style="text-align:center;padding:40px;margin:30px auto;max-width:500px;">
            <h3>Please sign in to see your order history.</h3>
            <p><a href="Login.aspx?returnUrl=MyOrders.aspx" style="color:#855335;font-weight:600;">Sign in to your account</a></p>
        </asp:Panel>

        <asp:Panel ID="pnlOrders" runat="server">
            <div class="prof-img2-grid">

                <!-- LEFT COLUMN: Dashed Account Card -->
                <div class="prof-img2-sidebar">
                    <div class="prof-img2-dashed-box">
                        <h2 class="prof-img2-nav-heading">Account</h2>
                        <div class="prof-img2-nav-divider"></div>

                        <div class="prof-img2-menu">
                            <a href="Profile.aspx" class="prof-img2-item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                                <span>Profile</span>
                            </a>

                            <a href="MyOrders.aspx" class="prof-img2-item active">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                    <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                </svg>
                                <span>My Orders</span>
                            </a>

                            <a href="Wishlist.aspx" class="prof-img2-item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                                </svg>
                                <span>Wishlist</span>
                            </a>

                            <a href="Profile.aspx#password" class="prof-img2-item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                </svg>
                                <span>Change Password</span>
                            </a>

                            <div class="prof-img2-nav-divider"></div>

                            <a href="Contact.aspx" class="prof-img2-item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#555555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                                    <line x1="12" y1="17" x2="12.01" y2="17"></line>
                                </svg>
                                <span>Help &amp; Support</span>
                            </a>

                            <asp:LinkButton ID="btnLogout" runat="server" CssClass="prof-img2-item logout"
                                CausesValidation="false" OnClick="btnLogout_Click">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#cc0000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                    <polyline points="16 17 21 12 16 7"></polyline>
                                    <line x1="21" y1="12" x2="9" y2="12"></line>
                                </svg>
                                <span>Logout</span>
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- MAIN CONTENT AREA -->
                <div class="prof-img2-main-content">
                    <div class="myorders-header-row">
                        <div>
                            <h2 class="myorders-section-title">Order History</h2>
                            <p class="myorders-section-sub">Review your past artisanal purchases and track current shipments.</p>
                        </div>
                        <div class="myorders-filter-box">
                            <span class="filter-label">Show:</span>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="myorders-filter-select"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Text="All orders" Value="" />
                                <asp:ListItem Text="Pending" Value="Pending" />
                                <asp:ListItem Text="In Transit" Value="In Transit" />
                                <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                                <asp:ListItem Text="Delivered" Value="Delivered" />
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="myorders-list">
                        <asp:Repeater ID="rptOrders" runat="server">
                            <ItemTemplate>
                                <div class="myorders-card">
                                    <div class="myorders-card-left">
                                        <img src='<%# FormatImageUrl(Eval("ProductImage")) %>' alt="Product" class="myorders-thumb" />
                                        <div class="myorders-card-info">
                                            <h4 class="myorders-card-name"><%# Server.HtmlEncode(Convert.ToString(Eval("Summary"))) %></h4>
                                            <p class="myorders-card-meta">Order #<%# Eval("OrderNumber") %> &bull; Placed <%# Eval("PlacedOn", "{0:MMM d, yyyy}") %></p>
                                            <div class="myorders-badges-row">
                                                <span class='myorders-status-pill <%# Convert.ToString(Eval("StatusClass")).ToLower() %>'><%# Eval("Status") %></span>
                                                <a href="#" onclick="alert('Tracking order #<%# Eval("OrderNumber") %>: Package is on the way!'); return false;" class="myorders-track-pill">
                                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="3" width="15" height="13"></rect><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon><circle cx="5.5" cy="18.5" r="2.5"></circle><circle cx="18.5" cy="18.5" r="2.5"></circle></svg>
                                                    <span>Track</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="myorders-card-price">
                                        &#8377;<%# Eval("Total", "{0:N0}") %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="prof-empty-card" style="text-align:center;padding:40px;margin-top:20px;">
                            <h3>No orders in this view yet.</h3>
                            <p><a href="Collection.aspx" style="color:#855335;font-weight:600;">Start with our collection</a></p>
                        </asp:Panel>
                    </div>
                </div>

            </div>
        </asp:Panel>
    </main>

</asp:Content>
