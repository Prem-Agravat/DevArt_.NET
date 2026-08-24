<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DevArt._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="home-page">

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="hero-container">
                <div class="hero-card">
                    <h1 class="hero-title">Elevate Your Sanctuary with New Arrivals</h1>
                    <p class="hero-subtitle">Discover a curated selection of artisanal furniture and tactile lighting designed to bring harmony to your home.</p>
                    <a href="Collection.aspx" class="hero-btn">Shop Now</a>
                </div>
            </div>
        </section>

        <!-- Browse Categories -->
        <section class="categories-section">
            <div class="section-header">
                <h2 class="section-title">Browse Categories</h2>
                <a href="Categories.aspx" class="view-all-link">View All</a>
            </div>
            <div class="categories-grid">
                <a href="Categories.aspx?category=Torans" class="category-item">
                    <div class="category-image-wrapper">
                        <img src="Images/category_torans.jpg" alt="Torans" class="category-image" />
                    </div>
                    <span class="category-label">Torans</span>
                </a>
                <a href="Categories.aspx?category=CushionCover" class="category-item">
                    <div class="category-image-wrapper">
                        <img src="Images/category_cushion.jpg" alt="ChusionCover" class="category-image" />
                    </div>
                    <span class="category-label">ChusionCover</span>
                </a>
                <a href="Categories.aspx?category=SofaCover" class="category-item">
                    <div class="category-image-wrapper">
                        <img src="Images/category_sofacover.jpg" alt="SofaCover" class="category-image" />
                    </div>
                    <span class="category-label">SofaCover</span>
                </a>
                <a href="Categories.aspx?category=BedSheet" class="category-item">
                    <div class="category-image-wrapper">
                        <img src="Images/category_bedsheet.jpg" alt="BedSheet" class="category-image" />
                    </div>
                    <span class="category-label">BedSheet</span>
                </a>
            </div>
        </section>

        <!-- Featured Essentials -->
        <section class="featured-section">
            <div class="section-title-wrapper">
                <h2 class="featured-title">Featured Essentials</h2>
                <p class="featured-subtitle">Handpicked pieces that embody the Serene Dwelling aesthetic.</p>
            </div>
            <div class="products-grid">
                <!-- Card 1 -->
                <div class="product-card">
                    <div class="product-image-container">
                        <img src="Images/product_cushion_set.jpg" alt="Cushion Cover Set" class="product-image" />
                        <button type="button" class="wishlist-btn" aria-label="Add to Wishlist">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                    <div class="product-details">
                        <h3 class="product-title">Cushion Cover Set</h3>
                        <div class="product-footer">
                            <span class="product-price">&#8377;499</span>
                            <button type="button" class="cart-btn" aria-label="Add to Cart">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="9" cy="21" r="1"></circle>
                                    <circle cx="20" cy="21" r="1"></circle>
                                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Card 2 -->
                <div class="product-card">
                    <div class="product-image-container">
                        <img src="Images/product_ceramic_vase.jpg" alt="Artisanal Ceramic Vase" class="product-image" />
                        <button type="button" class="wishlist-btn" aria-label="Add to Wishlist">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                    <div class="product-details">
                        <h3 class="product-title">Artisanal Ceramic Vase</h3>
                        <div class="product-footer">
                            <span class="product-price">&#8377;499</span>
                            <button type="button" class="cart-btn" aria-label="Add to Cart">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="9" cy="21" r="1"></circle>
                                    <circle cx="20" cy="21" r="1"></circle>
                                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Card 3 -->
                <div class="product-card">
                    <div class="product-image-container">
                        <img src="Images/product_velvet_pillow.jpg" alt="Velvet Accent Pillow" class="product-image" />
                        <button type="button" class="wishlist-btn" aria-label="Add to Wishlist">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                    <div class="product-details">
                        <h3 class="product-title">Velvet Accent Pillow</h3>
                        <div class="product-footer">
                            <span class="product-price">&#8377;499</span>
                            <button type="button" class="cart-btn" aria-label="Add to Cart">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="9" cy="21" r="1"></circle>
                                    <circle cx="20" cy="21" r="1"></circle>
                                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Card 4 -->
                <div class="product-card">
                    <div class="product-image-container">
                        <img src="Images/product_nesting_tables.jpg" alt="Nesting Ash Tables" class="product-image" />
                        <button type="button" class="wishlist-btn" aria-label="Add to Wishlist">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                    <div class="product-details">
                        <h3 class="product-title">Nesting Ash Tables</h3>
                        <div class="product-footer">
                            <span class="product-price">&#8377;499</span>
                            <button type="button" class="cart-btn" aria-label="Add to Cart">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="9" cy="21" r="1"></circle>
                                    <circle cx="20" cy="21" r="1"></circle>
                                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Community Section -->
        <section class="community-section">
            <div class="community-container">
                <div class="community-image-wrapper">
                    <img src="Images/community_workspace.jpg" alt="Join the DevArt Community" class="community-image" />
                </div>
                <div class="community-content">
                    <h2 class="community-title">Join the DevArt Community</h2>
                    <p class="community-subtitle">Sign up for our newsletter and receive 10% off your first order, plus exclusive access to styling guides and private sales.</p>
                    <div class="newsletter-form">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="newsletter-input" TextMode="Email" placeholder="Enter your email"></asp:TextBox>
                        <asp:Button ID="btnSubscribe" runat="server" Text="Subscribe" CssClass="newsletter-btn" />
                    </div>
                    <p class="newsletter-subtext">By subscribing, you agree to our <a href="#">Privacy Policy</a>.</p>
                </div>
            </div>
        </section>

    </div>

</asp:Content>
