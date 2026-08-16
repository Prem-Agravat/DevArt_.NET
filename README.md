# 🎨 DevArt .NET — UI Design & Application Showcase

DevArt is a premium, modern handicraft e-commerce website designed to provide a seamless shopping experience for unique handmade goods. 

The design phase of this project is now **fully completed**. High-fidelity UI/UX specifications have been developed in Figma, covering both the **User (Customer) Section** and the **Store Admin Section**, with all essential features implemented to guide the upcoming **.NET implementation**.

---

## 🔗 Figma Prototype & Design Link

Explore the complete interactive design prototype for both the User and Admin sections:

* **⚡ Live Interactive Prototype**: [Launch Figma Prototype](https://www.figma.com/proto/m7cDokzMiorS3tfrNO6bFe/DevArt-.NET-project?node-id=53-2&p=f&t=OUpyDVe3yAo1aCtE-0&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=2%3A478&show-proto-sidebar=1)

---

## 📂 Repository Structure

```text
├── figma/
│   ├── design_link.md        # Interactive Figma prototype link
│   └── Home Page.png         # Desktop Home Page layout preview
├── README.md                 # Project documentation and specifications
└── .gitignore                # Standard .NET gitignore file
```

---

## 🗺️ Completed Design Architecture

The DevArt website design is structured into two main divisions, covering all the workflows and features required for a robust e-commerce platform:

### 🛍️ 1. User (Customer) Section
Designed to deliver a clean, intuitive, and conversion-optimized storefront for users.
* **Authentication**: Responsive signup and login forms.
* **Homepage**: A welcoming interface showcasing featured crafts, search functionality, and curated category collections.
* **Product Catalog & Details**: Grid listings of products with category filters, sorting options, and dynamic details page including images, description, rating, price, and "Add to Cart" actions.
* **Cart & Checkout Process**: A clean shopping cart manager leading to a multi-stage checkout form (Shipping, Billing, Payment).
* **User Profile & Order Management**: Personalized dashboard displaying user profile details, active wishlists, current order status, and historical purchase data.

### 💼 2. Store Admin Section
Designed to give store administrators full visibility and control over products, sales, and orders.
* **Admin Dashboard**: Visual analytics panel tracking sales metrics, total revenue, top-selling items, and quick action widgets.
* **Product & Inventory Management**: Fully designed interface to view active stock, edit existing product listings, configure prices, and publish new handicraft products with descriptions and images.
* **Order Management**: Panel to view incoming customer orders, manage fulfillment stages, and process returns or cancellations.
* **User Overview**: Database interface to review registered user accounts and simple customer insights.

---

## 🎨 Design Highlights & Visual Identity

The website follows a premium visual language based on **Tactile Minimalism** and **Organic Aesthetics**:

* **Earthy Color Palette**:
  - **Primary Earthy Brown**: `#8B5E3C` (Primary CTA buttons, navigation highlights, brand focus)
  - **Secondary Soft Blue**: `#A9C7EB` (Tags, badges, interactive states)
  - **Clean Background**: `#F8F9FA` (Soft off-white canvas for products)
* **Modern Typography**:
  - **Headings**: `DM Sans` (Clean, geometric, bold headlines)
  - **Body Text**: `Work Sans` (Highly legible, crisp body layout)
* **Shapes & Visual Depth**:
  - Spacious layouts with clean 8px baseline margins.
  - Tactile elements featuring soft 12px–20px corner radiuses and subtle drop shadows.

---

## 🛠️ Planned Development Stack

The completed designs serve as the blueprint for the web application's development phase:
- **Web Frontend / Backend**: ASP.NET Core (MVC, Razor Pages, or Blazor Server/WebAssembly)
- **Database / ORM**: Entity Framework Core & SQL Server
- **Authentication**: ASP.NET Core Identity (with cookie or token-based authorization)

---

## 🎯 Project Status

All core modules have been fully designed, marking the UI/UX stage complete.

| Module / Screen | Section | Design Status | Development Status |
|:---|:---:|:---:|:---:|
| **UI/UX Design Phase** | Overall | ✅ Completed | - |
| **Authentication System** | User | ✅ Completed | 🚧 Planned |
| **Homepage & Search** | User | ✅ Completed | 🚧 Planned |
| **Product Listings & Details** | User | ✅ Completed | 🚧 Planned |
| **Wishlist & Cart Management** | User | ✅ Completed | 🚧 Planned |
| **Checkout & Order Success** | User | ✅ Completed | 🚧 Planned |
| **User Profile & Orders List** | User | ✅ Completed | 🚧 Planned |
| **Admin Dashboard Analytics** | Admin | ✅ Completed | 🚧 Planned |
| **Inventory & Product CRUD** | Admin | ✅ Completed | 🚧 Planned |
| **Admin Order Management** | Admin | ✅ Completed | 🚧 Planned |
| **.NET Application Setup** | Infrastructure | - | 🚧 Planned |

---

## ⭐ Support

If you like this project, consider giving it a **Star ⭐** on GitHub! It helps support the project and motivates future development.
