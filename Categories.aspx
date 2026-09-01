<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="DevArt.Categories" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Categories</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <h1 class="page-title">Categories</h1>
        <p class="page-subtitle">Explore our range of artisanal handicrafts, thoughtfully created to bring warmth and character to your home.</p>

        <div class="category-grid">
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <a class="category-tile" href='<%# "Collection.aspx?category=" + Server.UrlEncode(Convert.ToString(Eval("Name"))) %>'>
                        <img src='<%# "Images/" + Eval("Image") %>' alt='<%# Eval("Name") %>' />
                        <div class="overlay">
                            <h3><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></h3>
                            <span><%# Eval("Count") %> pieces &middot; Explore Collection</span>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <h2 class="section-heading">New this season</h2>
        <div class="product-grid">
            <asp:Repeater ID="rptNew" runat="server">
                <ItemTemplate>
                    <div class="product-card">
                        <div class="thumb">
                            <img src='<%# "Images/" + Eval("Image") %>' alt='<%# Eval("Name") %>' />
                            <span class="flag"><%# Eval("Badge") %></span>
                        </div>
                        <div class="body">
                            <span class="kicker"><%# Server.HtmlEncode(Convert.ToString(Eval("Category"))) %></span>
                            <span class="name"><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></span>
                            <span class="price">&#8377;<%# Eval("Price", "{0:N0}") %></span>
                            <div class="card-actions">
                                <a class="btn-outline btn-small" href='<%# "ProductDetail.aspx?id=" + Eval("Id") %>'>View</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </main>

</asp:Content>
