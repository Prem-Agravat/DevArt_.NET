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
│   └── assets/               # Exported high-fidelity UI screenshots
│       ├── homepage.png
│       ├── categories.png
│       ├── collection.png
│       ├── offers.png
│       └── admin_dashboard.png
├── README.md                 # Project documentation and specifications
└── .gitignore                # Standard .NET gitignore file
```

---

## 🖼️ Completed UI Showcase

Below are the actual high-fidelity website designs for both the customer-facing storefront and the store admin dashboard:

### 🏠 1. Homepage
A visually rich and tactile landing page with a hero banner featuring artisanal goods, a categories navigator, and featured items.

![DevArt Homepage](figma/assets/homepage.png)

---

### 📂 2. Categories
An organized category showcase designed to help users browse specific crafts such as Torans, Cushion Covers, Sofa Covers, and Bedsheets.

![DevArt Categories](figma/assets/categories.png)

---

### 🛍️ 3. Our Collection (Catalog)
A comprehensive product catalog grid complete with filters (by categories like Torans, Cushion Covers, Bedsheet) and price tags.

![DevArt Our Collection](figma/assets/collection.png)

---

### 🎟️ 4. Offers & Wishlist
A dedicated interface displaying available discount coupons (e.g., Free Shipping, Welcome Gift) and user rewards alongside redemption guides.

![DevArt Offers](figma/assets/offers.png)

---

### 💼 5. Store Admin Panel
A clean administrative interface featuring real-time overview metrics (Total Sales, Total Orders, Customers, Active Orders) and a recent orders log.

![DevArt Admin Dashboard](figma/assets/admin_dashboard.png)

---

## 🗺️ Completed Design Architecture

The DevArt website design covers all essential e-commerce workflows:

### 🛍️ User (Customer) Flow
* **Authentication**: Responsive signup and login forms.
* **Homepage**: Hero banners, category quick-links, and search bar.
* **Catalog & Filtering**: Checkbox filters, product grids, and sorting.
* **Detail & Purchase**: Detailed product pages with descriptions, prices, and checkout actions.
* **Offers & Coupons**: Code listings with interactive discount codes.

### 💼 Store Admin Flow
* **Dashboard Analytics**: Real-time sales trackers, customer counts, and overview tables.
* **Inventory CRUD**: Management interface to view active stock, update prices, and edit products.
* **Orders Fulfillment**: Admin tables to monitor order IDs, product details, and customer names.

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
