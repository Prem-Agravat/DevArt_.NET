-- ==========================================================================
-- DevArt Database1.mdf  — Seed Data Script
-- Run this in Visual Studio: Server Explorer → right-click Database1.mdf
--   → New Query → paste & Execute
-- ==========================================================================

-- ---------------------------------------------------------------- Categories
INSERT INTO Categories (Name, Description, Image) VALUES
('Torans',           'Traditional handcrafted door decorations',    'category_torans.jpg'),
('Cushion Covers',   'Artisan cushion covers for every interior',    'category_cushion.jpg'),
('Sofa & Table Covers','Handcrafted covers for sofas and tables',   'category_sofacover.jpg'),
('Bedsheet',         'Hand-block printed and embroidered bedsheets', 'category_bedsheet.jpg');

-- ---------------------------------------------------------------- Products
INSERT INTO Products (CategoryId, Name, Description, Price, Stock, Image, Rating, IsAvailable) VALUES
(1, 'Marigold Essence Doorway Arch',
 'Add a touch of artisan charm to your home with this handcrafted toran. Made from soft, durable cotton, it features intricate traditional hand embroidery.',
 499.00, 24, 'category_torans.jpg', 4.8, 1),
(1, 'Beaded Heritage Toran',
 'Heirloom-quality beadwork that brings auspiciousness and colour to a modern doorway, made by Rajkot artisans.',
 749.00, 12, 'category_torans.jpg', 4.6, 1),
(1, 'Festive Torans Trio',
 'Three coordinated torans sized for a main door, a puja room and a window.',
 1299.00, 0, 'category_torans.jpg', 4.7, 0),
(2, 'Velvet Accent Pillow',
 'A plush velvet accent pillow cover in a deep jewel tone, finished with a hidden zip and piped edges.',
 499.00, 30, 'product_velvet_pillow.jpg', 4.7, 1),
(2, 'Cushion Cover Set',
 'A pair of handwoven cotton covers, each a canvas of Gujarat''s rich textile heritage, designed for the modern home.',
 899.00, 18, 'product_cushion_set.jpg', 4.5, 1),
(2, 'Indigo Block-Print Cover',
 'Hand block-printed in natural indigo on pure linen, softening beautifully with every wash.',
 599.00, 22, 'category_cushion.jpg', 4.4, 1),
(2, 'Woven Linen Scarf - Sage',
 'A featherweight handloom linen wrap in a soft sage, woven on a pit loom.',
 499.00, 26, 'product_velvet_pillow.jpg', 4.1, 1),
(3, 'Artisanal Ceramic Vase',
 'A studio-fired stoneware vase with a matte sand glaze, thrown and finished entirely by hand.',
 1299.00, 9, 'product_ceramic_vase.jpg', 4.9, 1),
(3, 'Quilted Sofa Throw Cover',
 'A three-seater quilted cover that drapes cleanly over the arms and protects upholstery without hiding it.',
 2400.00, 7, 'category_sofacover.jpg', 4.3, 1),
(3, 'Nesting Ash Tables',
 'A pair of nesting side tables in solid ash with a hand-rubbed oil finish.',
 6900.00, 4, 'product_nesting_tables.jpg', 4.8, 1),
(4, 'Kutch Embroidered Bedsheet',
 'King-size cotton percale with mirror-work embroidery along the border, finished with two pillow covers.',
 1899.00, 15, 'category_bedsheet.jpg', 4.6, 1),
(4, 'Sanganeri Print Bedsheet',
 'Traditional Sanganeri hand-block florals on a soft cotton base, colour-fast and pre-shrunk.',
 1499.00, 20, 'category_bedsheet.jpg', 4.2, 1);

-- ---------------------------------------------------------------- Offers
INSERT INTO Offers (Code, Title, Description, DiscountType, DiscountValue, MinAmount, MaxDiscount, StartDate, EndDate, IsActive) VALUES
('FREESHIP150', 'Free Shipping',          'Complimentary shipping on qualifying purchases.',               'freeshipping', 60.00,  150.00,  60.00,  GETDATE(), '2027-03-31', 1),
('WELCOME15',   'Welcome Gift',           'For new members. Apply to your first purchase.',                'flat',         100.00, 500.00,  100.00, GETDATE(), '2027-03-31', 1),
('ARTISAN20',   'Artisan Toran 20% OFF',  'Valid on all items in the Toran Decor category.',               'percent',      20.00,  0.00,    500.00, GETDATE(), '2027-03-31', 1),
('NEWARTISAN15','15% OFF First Order',    'Fifteen percent off the first order placed on a new account.',  'percent',      15.00,  0.00,    400.00, GETDATE(), '2027-03-31', 1),
('DEVARTLOYAL', '₹200 Reward Credit',    'A loyalty reward credit for returning collectors.',              'flat',         200.00, 1500.00, 200.00, GETDATE(), '2027-03-31', 1),
('DEVART10',    'DevArt Welcome 10%',     'Ten percent off, sent to every newsletter subscriber.',          'percent',      10.00,  0.00,    300.00, GETDATE(), '2027-06-30', 1),
('FESTIVE25',   'Festive Season 25%',     'Twenty-five percent off festive orders above ₹2000.',           'percent',      25.00,  2000.00, 750.00, GETDATE(), '2027-06-30', 1),
('NEWHOME15',   'New Home 15%',           'Fifteen percent off for customers furnishing a new home.',       'percent',      15.00,  0.00,    400.00, GETDATE(), '2027-06-30', 1);

-- ---------------------------------------------------------------- Admins
INSERT INTO Admins (Name, Email, PasswordHash) VALUES
('Admin', 'admin@devart.com', 'Admin@123');

-- ---------------------------------------------------------------- Users (Demo)
INSERT INTO Users (Name, Email, PasswordHash, Phone, CreatedAt) VALUES
('Parth Dhanani',    'parth@devart.in',          'Devart@123', '9876543210', '2024-03-14'),
('Prem Agravat',     'prem123@studio.dev',        'Devart@123', '9876543211', '2024-03-27'),
('Dev Chauhan',      'dev123@gmail.com',           'Devart@123', '9876543212', '2024-07-02'),
('Ramanshu Dhanani', 'ramanshu321@gmail.com',      'Devart@123', '9876543213', '2025-01-19'),
('Om Hirpara',       'om665@gmail.com',            'Devart@123', '9876543214', '2025-06-05'),
('Viraj Vaja',       'viraj525@gmail.com',         'Devart@123', '9876543215', '2026-02-11');

