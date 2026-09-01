<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="DevArt.Admin.Inventory" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Inventory</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-head">
        <h1>Inventory Management</h1>
        <a href="ProductEdit.aspx" class="newsletter-btn">+ Add New Product</a>
    </div>

    <asp:Panel ID="pnlStatus" runat="server" Visible="false">
        <asp:Literal ID="litStatus" runat="server" />
    </asp:Panel>

    <div class="chip-row">
        <asp:Repeater ID="rptChips" runat="server">
            <ItemTemplate>
                <a class='chip <%# Eval("Css") %>'
                   href='<%# "Inventory.aspx?category=" + Server.UrlEncode(Convert.ToString(Eval("Value"))) %>'>
                    <%# Server.HtmlEncode(Convert.ToString(Eval("Text"))) %>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <div class="admin-card">
        <table class="data-table">
            <thead>
                <tr><th>Product</th><th>Category</th><th>Material</th><th>Price</th><th>Stock</th><th></th></tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Category"))) %></td>
                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Material"))) %></td>
                            <td>&#8377;<%# Eval("Price", "{0:N0}") %></td>
                            <td>
                                <span class='pill <%# (int)Eval("Stock") == 0 ? "pill-amber" : "pill-green" %>'>
                                    <%# (int)Eval("Stock") == 0 ? "Out of stock" : Eval("Stock") + " left" %>
                                </span>
                            </td>
                            <td style="text-align:right;white-space:nowrap;">
                                <a class="btn-outline btn-small" href='<%# "ProductEdit.aspx?id=" + Eval("Id") %>'>Edit</a>
                                <asp:Button runat="server" CssClass="link-button" style="margin-left:10px;color:#c0392b;"
                                    CommandName="DeleteProduct" CommandArgument='<%# Eval("Id") %>'
                                    Text="Delete" CausesValidation="false"
                                    OnClientClick="return confirm('Delete this product? This action cannot be undone.');" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
            No products in this category yet.
        </asp:Panel>
    </div>

</asp:Content>
