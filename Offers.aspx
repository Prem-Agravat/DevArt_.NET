<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Offers.aspx.cs" Inherits="DevArt.Offers" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - Offers</asp:Content>

<asp:Content ID="HeadContentBlock" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* FIXED POPUP OVERLAY & MODAL STYLES FOR OFFERS COPY */
        .inv-modal-overlay {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100vw !important;
            height: 100vh !important;
            background: rgba(15, 23, 42, 0.55) !important;
            backdrop-filter: blur(4px) !important;
            z-index: 999999 !important;
            display: flex;
            align-items: center !important;
            justify-content: center !important;
            padding: 20px !important;
            box-sizing: border-box !important;
        }

        .inv-modal-card {
            background: #ffffff !important;
            border-radius: 24px !important;
            width: 100% !important;
            max-width: 380px !important;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25) !important;
            overflow: hidden !important;
            position: relative !important;
            animation: offerModalFade 0.25s cubic-bezier(0.16, 1, 0.3, 1) !important;
        }

        @keyframes offerModalFade {
            from { opacity: 0; transform: scale(0.95) translateY(10px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="offers-page-wrapper">
        <div class="offers-top-bar">
            <a href="javascript:history.back();" class="offers-back-arrow" title="Go back">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
            </a>
            <h1 class="offers-page-title">Offers</h1>
        </div>

        <asp:Panel ID="pnlStatus" runat="server" Visible="false" style="max-width: 1100px; margin: 0 auto 24px;">
            <asp:Literal ID="litStatus" runat="server" />
        </asp:Panel>

        <!-- DASHED CARD CONTAINER -->
        <div class="offers-dashed-container">
            <div class="offers-dashed-header">
                <h2 class="offers-dashed-title">Your Shopping Wishlist</h2>
                <span class="offers-dashed-count">(<%= OfferCount %> ITEMS)</span>
            </div>

            <div class="offers-cards-grid">
                <asp:Repeater ID="rptOffers" runat="server" OnItemCommand="rptOffers_ItemCommand">
                    <ItemTemplate>
                        <div class="offer-v2-card <%# GetTopBarStyle(Container.ItemIndex) %>">
                            <div class="offer-v2-badge <%# GetBadgeStyle(Container.ItemIndex) %>">
                                <%# GetIconSvg(Container.DataItem, Container.ItemIndex) %>
                            </div>

                            <h3 class="offer-v2-headline <%# Container.ItemIndex % 2 == 1 ? "green" : "brown" %>">
                                <%# Server.HtmlEncode(GetHeadline(Container.DataItem)) %>
                            </h3>
                            <div class="offer-v2-subhead">
                                <%# Server.HtmlEncode(GetSubhead(Container.DataItem)) %>
                            </div>

                            <p class="offer-v2-desc">
                                <%# Server.HtmlEncode(Convert.ToString(Eval("Description"))) %>
                            </p>

                            <div class="offer-v2-code-box">
                                <span class="offer-v2-code-text"><%# Eval("Code") %></span>
                                <asp:LinkButton runat="server" CssClass="offer-v2-copy-btn"
                                    CommandName="Copy" CommandArgument='<%# Eval("Code") %>'
                                    OnClientClick='<%# "copyOfferCode(this, \"" + Eval("Code") + "\");" %>'
                                    CausesValidation="false" title="Copy offer code">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#855335" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect>
                                        <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path>
                                    </svg>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- HOW TO REDEEM SECTION -->
        <div class="redeem-section">
            <h2 class="redeem-title">How to Redeem</h2>

            <div class="redeem-grid">
                <div class="redeem-card">
                    <div class="redeem-step-num">1</div>
                    <h3 class="redeem-step-title">Find Your Code</h3>
                    <p class="redeem-step-desc">
                        Browse the offers above and click <strong>'Copy'</strong> to save the promo code to your clipboard.
                    </p>
                </div>

                <div class="redeem-card">
                    <div class="redeem-step-num">2</div>
                    <h3 class="redeem-step-title">Fill Your Cart</h3>
                    <p class="redeem-step-desc">
                        Add qualifying artisanal items to your shopping bag and proceed to checkout.
                    </p>
                </div>

                <div class="redeem-card">
                    <div class="redeem-step-num">3</div>
                    <h3 class="redeem-step-title">Apply &amp; Save</h3>
                    <p class="redeem-step-desc">
                        Paste the code into the <strong>'Promo Code'</strong> field during payment and watch the total drop.
                    </p>
                </div>
            </div>
        </div>

        <!-- OFFER CODE COPY SUCCESS POPUP MODAL (STRICTLY MATCHING USER IMAGE 2) -->
        <div id="pnlOfferCopySuccessModal" runat="server" class="inv-modal-overlay" style="display: none;">
            <div class="inv-modal-card" style="max-width: 380px; text-align: center; padding: 32px 24px; border-radius: 24px; border-top: 4px solid #1E293B; background: #ffffff; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
                <div style="width: 56px; height: 56px; background: #DBEAFE; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                    <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#2563EB" stroke-width="2.8" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="16 9 10.5 15 7.5 12"></polyline>
                    </svg>
                </div>

                <h2 style="font-family: 'DM Sans', sans-serif; font-size: 20px; font-weight: 800; color: #0F172A; margin: 0 0 6px;">Offer Code Copy</h2>
                <p style="font-size: 13.5px; color: #64748B; margin: 0 0 24px;">successfully Copy</p>

                <asp:Button ID="btnReturnToCart" runat="server" Text="&larr; Return to Cart" OnClick="btnReturnToCart_Click" OnClientClick="window.location.href='Cart.aspx'; return false;" CausesValidation="false" style="width: 100%; height: 46px; background: #6E4125; color: #ffffff; border-radius: 14px; border: none; font-size: 14px; font-weight: 700; cursor: pointer;" />
            </div>
        </div>
    </main>

    <script type="text/javascript">
        function copyOfferCode(btn, code) {
            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(code);
            }
            var modal = document.getElementById('<%= pnlOfferCopySuccessModal.ClientID %>');
            if (modal) {
                modal.style.display = 'flex';
            }
        }
    </script>

</asp:Content>
