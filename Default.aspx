<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DevArt._Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>DevArt - Elevate Your Sanctuary</title>
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <!-- Header -->
        <header class="site-header">
            <div class="header-container">
                <a href="Default.aspx" class="brand">
                    <img src="Images/devart-logo.png" alt="Dev Art Logo" class="brand-logo-img" />
                    <span class="brand-name">Dev Art</span>
                </a>

                <nav class="main-nav">
                    <a href="Default.aspx" class="nav-link active">Home</a>
                    <a href="Categories.aspx" class="nav-link">Categories</a>
                    <a href="Collection.aspx" class="nav-link">Our Collection</a>
                    <a href="Offers.aspx" class="nav-link">Offers</a>
                    <a href="About.aspx" class="nav-link">About</a>
                </nav>

                <div class="header-actions">
                    <div class="search-box">
                        <svg class="search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="Search decor..."></asp:TextBox>
                    </div>

                    <a href="Cart.aspx" class="header-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                            <line x1="3" y1="6" x2="21" y2="6"></line>
                            <path d="M16 10a4 4 0 0 1-8 0"></path>
                        </svg>
                    </a>

                    <a href="Profile.aspx" class="header-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                    </a>

                    <a href="Login.aspx" class="login-button">Login/Registration</a>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="home-page">
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
        </main>

        <!-- Footer -->
        <footer class="site-footer">
            <div class="footer-container">
                <div class="footer-column footer-about">
                    <h3>DevArt Home</h3>
                    <p>Curating tranquil spaces through thoughtful design and sustainable craftsmanship since 2024.</p>
                </div>
                <div class="footer-column">
                    <h3>Company</h3>
                    <a href="About.aspx">About Us</a>
                    <a href="#">Sustainability</a>
                    <a href="#">Store Locator</a>
                </div>
                <div class="footer-column">
                    <h3>Support</h3>
                    <a href="#">Shipping & Returns</a>
                    <a href="Contact.aspx">Contact</a>
                </div>
                <div class="footer-column">
                    <h3>Follow Us</h3>
                    <div class="social-icons">
                        <a href="#" class="social-icon" aria-label="Website">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="2" y1="12" x2="22" y2="12"></line>
                                <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path>
                            </svg>
                        </a>
                        <a href="#" class="social-icon" aria-label="Instagram">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                                <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                                <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>© 2024 DevArt Home Decor. All rights reserved.</p>
                <div>
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                </div>
            </div>
        </footer>

    </form>
</body>
</html>
