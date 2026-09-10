<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="DevArt.About" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - About Us</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="page-shell">
        <h1 class="page-title">Crafted in the Heart of Rajkot</h1>
        <p class="page-subtitle">Based in Rajkot, Gujarat, India &mdash; 100% hand-stitched with love in Rajkot households.</p>

        <div class="detail-split">
            <div class="detail-image">
                <img src="Images/community_workspace.jpg" alt="The DevArt studio in Rajkot" />
            </div>
            <div>
                <h2 class="section-heading" style="margin-top:0;">Our Humble Beginnings</h2>
                <p style="font-size:13.5px;line-height:1.9;color:#5a5a5a;">
                    What started as a passion project in a small living room in Rajkot, Gujarat, has grown
                    into a community of creators. DevArt is more than a business; it is a
                    &ldquo;made from home&rdquo; story dedicated to the soul of Indian handicrafts.
                </p>
                <p style="font-size:13.5px;line-height:1.9;color:#5a5a5a;">
                    Rajkot has always been a hub of industrious creativity. By rooting our business here we
                    tap into a legacy of craftsmanship that dates back centuries. Every piece we ship carries
                    a bit of our city&#39;s warmth and the resilience of its people.
                </p>
                <p><a href="Collection.aspx" class="newsletter-btn">Explore Our Collection</a></p>
            </div>
        </div>

        <h2 class="section-heading">The Soul of DevArt</h2>
        <div class="steps-how">
            <div class="step-card">
                <h4>Traditional Torans</h4>
                <p>We preserve the ancient art of toran making, bringing auspiciousness and colour to
                   modern doorways through heirloom-quality beadwork.</p>
            </div>
            <div class="step-card">
                <h4>Cushion &amp; Sofa Covers</h4>
                <p>Redefining living spaces with fabrics that tell a story. Each cover is a canvas of
                   Gujarat&#39;s rich textile heritage, designed for the modern home.</p>
            </div>
            <div class="step-card">
                <h4>Empowering Local Artists</h4>
                <p>Our mission is to give Rajkot&#39;s local artisans a global platform, ensuring their
                   incredible skills are passed down to future generations.</p>
            </div>
        </div>

        <h2 class="section-heading" id="sustainability">Sustainable Craftsmanship</h2>
        <div class="panel">
            <p style="font-size:13.5px;line-height:1.9;color:#5a5a5a;margin:0 0 14px;">
                We work directly with local artisans to source authentic, handmade pieces. From intricately
                embroidered torans to cotton bedsheets and plush sofa covers, every product tells a story of
                heritage, skill and environmental responsibility. We focus on natural materials, low-impact
                dyes and fair wage practices.
            </p>
            <div class="stat-row" style="margin:0;">
                <div class="stat-tile">
                    <div class="label">Hand-stitched</div>
                    <div class="value">100%</div>
                </div>
                <div class="stat-tile">
                    <div class="label">Artisan families</div>
                    <div class="value">40+</div>
                </div>
                <div class="stat-tile">
                    <div class="label">Crafting since</div>
                    <div class="value">2024</div>
                </div>
            </div>
        </div>
    </main>

</asp:Content>
