<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Offers.aspx.cs" Inherits="DevArt.Admin.AdminOffers" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt Admin - Offers</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-head">
        <h1>Offers Management</h1>
        <a href="OfferEdit.aspx" class="newsletter-btn">+ Add Offer</a>
    </div>

    <asp:Panel ID="pnlStatus" runat="server" Visible="false">
        <asp:Literal ID="litStatus" runat="server" />
    </asp:Panel>

    <div class="offer-grid">
        <asp:Repeater ID="rptOffers" runat="server" OnItemCommand="rptOffers_ItemCommand">
            <ItemTemplate>
                <div class="offer-card">
                    <span class="kicker"><%# Server.HtmlEncode(Convert.ToString(Eval("Kicker"))) %></span>
                    <h3><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></h3>

                    <div class="summary-line"><span>Discount</span><span><%# Eval("DiscountLabel") %></span></div>
                    <div class="summary-line"><span>Promo Code</span><span><%# Eval("Code") %></span></div>
                    <div class="summary-line"><span>Min. Spend</span><span>&#8377;<%# Eval("MinimumSpend", "{0:N0}") %></span></div>
                    <div class="summary-line"><span>Expiry Date</span><span><%# Eval("ExpiresOn", "{0:MMM d, yyyy}") %></span></div>
                    <div class="summary-line">
                        <span>Status</span>
                        <span class='pill <%# (bool)Eval("IsActive") && !(bool)Eval("IsExpired") ? "pill-green" : "pill-amber" %>'>
                            <%# (bool)Eval("IsExpired") ? "Expired" : ((bool)Eval("IsActive") ? "Active" : "Paused") %>
                        </span>
                    </div>

                    <div class="card-actions">
                        <a class="btn-outline btn-small" href='<%# "OfferEdit.aspx?id=" + Eval("Id") %>'>Edit</a>
                        <asp:Button runat="server" CssClass="link-button" style="color:#c0392b;"
                            CommandName="DeleteOffer" CommandArgument='<%# Eval("Id") %>'
                            Text="Delete" CausesValidation="false"
                            OnClientClick="return confirm('Delete this offer? This action cannot be undone.');" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
        No offers configured yet.
    </asp:Panel>

</asp:Content>
