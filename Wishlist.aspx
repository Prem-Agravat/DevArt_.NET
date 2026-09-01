<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="DevArt.Wishlist" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Wishlist</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <h1 class="page-title">Wishlist</h1>
        <p class="page-subtitle">Pieces you have saved for later. They stay here for this session.</p>

        <asp:Panel ID="pnlStatus" runat="server" Visible="false">
            <asp:Literal ID="litStatus" runat="server" />
        </asp:Panel>

        <div class="layout-split">
            <div class="side-panel">
                <h4>Account</h4>
                <div class="side-nav">
                    <a href="Profile.aspx">Profile</a>
                    <a href="MyOrders.aspx">My Orders</a>
                    <a href="Wishlist.aspx" class="active">Wishlist</a>
                    <a href="Profile.aspx#password">Change Password</a>
                    <a href="Contact.aspx">Help &amp; Support</a>
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="danger"
                        CausesValidation="false" OnClick="btnLogout_Click" Text="Logout" />
                </div>
            </div>

            <div>
                <div class="filter-bar">
                    <span>Your Shopping Wishlist (<strong><asp:Literal ID="litCount" runat="server" /></strong> items)</span>
                    <a href="Collection.aspx" class="btn-outline btn-small">Continue Exploring</a>
                </div>

                <div class="product-grid">
                    <asp:Repeater ID="rptWishlist" runat="server" OnItemCommand="rptWishlist_ItemCommand">
                        <ItemTemplate>
                            <div class="product-card">
                                <div class="thumb">
                                    <img src='<%# "Images/" + Eval("Image") %>' alt='<%# Eval("Name") %>' />
                                    <span class="flag"><%# Eval("Badge") %></span>
                                </div>
                                <div class="body">
                                    <span class="kicker"><%# Server.HtmlEncode(Convert.ToString(Eval("Category"))) %></span>
                                    <a class="name" href='<%# "ProductDetail.aspx?id=" + Eval("Id") %>'><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></a>
                                    <span class="price">&#8377;<%# Eval("Price", "{0:N2}") %></span>
                                    <div class="card-actions">
                                        <asp:Button runat="server" CssClass="newsletter-btn btn-small"
                                            CommandName="AddToCart" CommandArgument='<%# Eval("Id") %>'
                                            Text="Add to Cart" CausesValidation="false"
                                            Enabled='<%# (bool)Eval("InStock") %>' />
                                        <asp:Button runat="server" CssClass="link-button"
                                            CommandName="Remove" CommandArgument='<%# Eval("Id") %>'
                                            Text="Remove" CausesValidation="false" />
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
                    Your wishlist is empty. Tap <strong>Wishlist</strong> on any piece in
                    <a href="Collection.aspx" style="color:#5069a6;">Our Collection</a> to save it here.
                </asp:Panel>
            </div>
        </div>
    </main>

</asp:Content>
