<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="DevArt.About" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">DevArt - About Us</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="about-page-wrapper">

        <!-- HERO SECTION CARD -->
        <div class="about-hero-card">
            <div class="about-hero-text-col">
                <h1 class="about-hero-title">Crafted in the Heart of Rajkot</h1>
                <div class="about-badge-pill">Our Humble Beginnings</div>
                <p class="about-hero-desc">
                    What started as a passion project in a small living room in Rajkot, Gujarat, has grown into a community of creators. DevArt is more than a business; it's a "made from home" story dedicated to the soul of Indian handicrafts.
                </p>
                <a href="Collection.aspx" class="about-hero-btn">Explore Our Collection</a>
            </div>

            <div class="about-hero-img-col">
                <div class="about-artisan-frame">
                    <img src="Images/artisan_woman.jpg" alt="Crafted in Rajkot" class="about-artisan-img" />
                    <div class="about-overlay-badge">
                        <div class="stat-num">100%</div>
                        <div class="stat-text">Hand-stitched with love in Rajkot households.</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- THE SOUL OF DEVART SECTION -->
        <div class="about-soul-section">
            <h2 class="about-section-title">The Soul of DevArt</h2>
            <div class="about-title-bar"></div>

            <div class="about-cards-grid">
                <!-- CARD 1 -->
                <div class="about-feature-card">
                    <img src="Images/category_torans.jpg" alt="Traditional Torans" class="about-card-img" />
                    <h3 class="about-card-title">Traditional Torans</h3>
                    <p class="about-card-desc">
                        We preserve the ancient art of 'Toran' making, bringing auspiciousness and color to modern doorways through heirloom-quality beadwork.
                    </p>
                </div>

                <!-- CARD 2 -->
                <div class="about-feature-card">
                    <img src="Images/product_cushion_set.jpg" alt="Cushion & Sofa Covers" class="about-card-img" />
                    <h3 class="about-card-title">Cushion &amp; Sofa Covers</h3>
                    <p class="about-card-desc">
                        Redefining living spaces with fabrics that tell a story. Each cover is a canvas of Gujarat's rich textile heritage, designed for the modern home.
                    </p>
                </div>

                <!-- CARD 3 -->
                <div class="about-feature-card">
                    <img src="Images/artisan_loom.jpg" alt="Empowering Local Artists" class="about-card-img" />
                    <h3 class="about-card-title">Empowering Local Artists</h3>
                    <p class="about-card-desc">
                        Our mission is to provide a global platform for Rajkot's local artisans, ensuring their incredible skills are passed down to future generations.
                    </p>
                </div>
            </div>
        </div>

        <!-- RAJKOT HERITAGE SECTION -->
        <div class="about-heritage-grid">
            <div class="about-heritage-box">
                <div>
                    <h3 class="heritage-title">The Rajkot Heritage</h3>
                    <p class="heritage-desc">
                        Rajkot has always been a hub of industrious creativity. By rooting our business here, we tap into a legacy of craftsmanship that dates back centuries. Every piece we ship carries a bit of our city's warmth and the resilience of its people.
                    </p>
                </div>
                <div class="heritage-loc-pill">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                    <span>Based in Rajkot, Gujarat, India</span>
                </div>
            </div>

            <div class="about-map-card">
                <img src="Images/rajkot_map.jpg" alt="Rajkot Heritage Map" class="about-map-img" />
            </div>
        </div>

    </main>

</asp:Content>
