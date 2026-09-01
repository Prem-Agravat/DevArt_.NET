<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Collection.aspx.cs" Inherits="DevArt.Collection" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Our Collection</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <h1 class="page-title">Our Collection</h1>
        <p class="page-subtitle">Artisanal pieces designed for peaceful living, hand-made in Rajkot households.</p>

        <asp:Panel ID="pnlStatus" runat="server" Visible="false">
            <asp:Literal ID="litStatus" runat="server" />
        </asp:Panel>

        <div class="layout-split">

            <div>
                <div class="side-panel">
                    <h4>Categories</h4>
                    <div class="side-nav">
                        <asp:Repeater ID="rptFilters" runat="server">
                            <ItemTemplate>
                                <a href='<%# "Collection.aspx?category=" + Server.UrlEncode(Convert.ToString(Eval("Value"))) %>'
                                   class='<%# Eval("Css") %>'><%# Server.HtmlEncode(Convert.ToString(Eval("Text"))) %></a>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div class="side-panel">
                    <h4>Eco-Conscious</h4>
                    <p style="font-size: 12.5px; color: #6b6b6b; line-height: 1.7; margin: 0;">
                        All our items are ethically sourced and made with natural, sustainable fibers and dyes.
                    </p>
                </div>
            </div>

            <div>
                <div class="filter-bar">
                    <span>Showing <strong><asp:Literal ID="litCount" runat="server" /></strong> artisanal pieces</span>
                    <span>
                        SORT BY:
                        <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-input"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                            <asp:ListItem Text="Newest Arrivals" Value="newest" />
                            <asp:ListItem Text="Price: Low to High" Value="priceasc" />
                            <asp:ListItem Text="Price: High to Low" Value="pricedesc" />
                            <asp:ListItem Text="Top Rated" Value="rating" />
                        </asp:DropDownList>
                    </span>
                </div>

                <div class="product-grid">
                    <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
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
                                        <asp:Button runat="server" CssClass="btn-outline btn-small"
                                            CommandName="AddToWishlist" CommandArgument='<%# Eval("Id") %>'
                                            Text="Wishlist" CausesValidation="false" />
                                    </div>
                                    <asp:Literal runat="server" Visible='<%# !(bool)Eval("InStock") %>'
                                        Text="&lt;span style='font-size:11px;color:#c0392b;'&gt;Out of stock&lt;/span&gt;" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
                    Nothing matches this filter yet. Try another category.
                </asp:Panel>
            </div>
        </div>
    </main>

</asp:Content>
