<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Offers.aspx.cs" Inherits="DevArt.Offers" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Offers</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <h1 class="page-title">Offers</h1>
        <p class="page-subtitle">Seasonal savings on handcrafted pieces. Copy a code, then apply it in your cart.</p>

        <asp:Panel ID="pnlStatus" runat="server" Visible="false">
            <asp:Literal ID="litStatus" runat="server" />
        </asp:Panel>

        <div class="offer-grid">
            <asp:Repeater ID="rptOffers" runat="server" OnItemCommand="rptOffers_ItemCommand">
                <ItemTemplate>
                    <div class="offer-card">
                        <span class="kicker"><%# Server.HtmlEncode(Convert.ToString(Eval("Kicker"))) %></span>
                        <h3><%# Server.HtmlEncode(Convert.ToString(Eval("Name"))) %></h3>
                        <p><%# Server.HtmlEncode(Convert.ToString(Eval("Description"))) %></p>
                        <div class="offer-code">
                            <span><%# Eval("Code") %></span>
                            <asp:Button runat="server" CssClass="btn-outline btn-small"
                                CommandName="Copy" CommandArgument='<%# Eval("Code") %>'
                                Text="Copy" CausesValidation="false" />
                        </div>
                        <span style="font-size:11.5px;color:#8c8c8c;">
                            <%# Eval("DiscountLabel") %> &middot;
                            <%# (decimal)Eval("MinimumSpend") > 0 ? "Min. spend &#8377;" + ((decimal)Eval("MinimumSpend")).ToString("N0") : "No minimum spend" %>
                            &middot; Valid to <%# Eval("ExpiresOn", "{0:MMM d, yyyy}") %>
                        </span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <h2 class="section-heading">How to Redeem</h2>
        <div class="steps-how">
            <div class="step-card">
                <div class="num">1</div>
                <h4>Find Your Code</h4>
                <p>Browse the offers above and hit <strong>Copy</strong> to put the promo code in your cart.</p>
            </div>
            <div class="step-card">
                <div class="num">2</div>
                <h4>Fill Your Cart</h4>
                <p>Add qualifying artisanal items to your shopping bag and proceed to checkout.</p>
            </div>
            <div class="step-card">
                <div class="num">3</div>
                <h4>Apply &amp; Save</h4>
                <p>Paste the code into the <strong>Promo Code</strong> field in the cart and watch the total drop.</p>
            </div>
        </div>
    </main>

</asp:Content>
