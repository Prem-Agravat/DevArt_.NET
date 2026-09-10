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
    </main>

</asp:Content>