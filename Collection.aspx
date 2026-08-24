<%@ Page Title="Our Collection" Language="C#" AutoEventWireup="true" CodeBehind="Collection.aspx.cs" Inherits="DevArt.Collection" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>DevArt - Our Collection</title>
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
                    <a href="Default.aspx" class="nav-link">Home</a>
                    <a href="Categories.aspx" class="nav-link">Categories</a>
                    <a href="Collection.aspx" class="nav-link active">Our Collection</a>
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
            <section class="about-section">
                <div class="about-container">
                    <h1 class="about-title">Our Collection</h1>
                    <p class="about-subtitle">Artisanal products designed for peaceful living.</p>
                    
                    <div class="about-content-card" style="text-align: center;">
                        <p>Explore our premium handmade e-commerce catalog of authentic crafts. Items can be added to your wishlist and shopping cart.</p>
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
