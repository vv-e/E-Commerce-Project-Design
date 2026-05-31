-- -- -------------------------------------------------------------

-- DUMMY DATA — REVISED
-- Dates are unquoted clean datetime values
-- Addresses contain no commas to avoid CSV parsing issues
-- Transactions spread across 2024–2026 for dashboard filters
-- Customers 12 and 13 are intentionally inactive after mid-2024
-- Products spread across 2024–2026 for newest products visual
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- USERS
-- user_id 1–9:  Sellers only
-- user_id 11–15: Customers only
-- -------------------------------------------------------------
INSERT INTO User (user_id, email, password_hash, first_name, last_name, phone, created_at, last_login) VALUES
(1,  'alice.martin@email.com',  'hashed_pw_1',  'Alice',  'Martin',  '206-555-0101', '2023-01-15 09:00:00', '2026-04-10 14:22:00'),
(2,  'bob.nguyen@email.com',    'hashed_pw_2',  'Bob',    'Nguyen',  '206-555-0102', '2023-02-10 10:30:00', '2026-03-18 09:45:00'),
(3,  'carol.smith@email.com',   'hashed_pw_3',  'Carol',  'Smith',   '425-555-0103', '2023-03-05 11:00:00', '2026-05-01 16:00:00'),
(4,  'david.lee@email.com',     'hashed_pw_4',  'David',  'Lee',     '425-555-0104', '2023-04-20 08:00:00', '2024-06-17 11:30:00'),
(5,  'emma.johnson@email.com',  'hashed_pw_5',  'Emma',   'Johnson', '253-555-0105', '2023-05-12 13:00:00', '2026-05-10 10:10:00'),
(6,  'frank.davis@email.com',   'hashed_pw_6',  'Frank',  'Davis',   '253-555-0106', '2023-06-08 15:00:00', '2024-05-15 08:55:00'),
(7,  'grace.wilson@email.com',  'hashed_pw_7',  'Grace',  'Wilson',  '360-555-0107', '2023-07-01 09:30:00', '2026-04-22 12:00:00'),
(8,  'henry.moore@email.com',   'hashed_pw_8',  'Henry',  'Moore',   '360-555-0108', '2023-08-14 14:00:00', '2024-04-10 17:40:00'),
(9,  'iris.taylor@email.com',   'hashed_pw_9',  'Iris',   'Taylor',  '206-555-0109', '2023-09-25 10:00:00', '2026-05-20 09:25:00'),
(11, 'liam.brown@email.com',    'hashed_pw_11', 'Liam',   'Brown',   '206-555-0201', '2023-03-10 09:00:00', '2026-05-01 08:00:00'),
(12, 'mia.clark@email.com',     'hashed_pw_12', 'Mia',    'Clark',   '206-555-0202', '2023-04-15 10:00:00', '2024-02-19 09:00:00'),
(13, 'noah.hall@email.com',     'hashed_pw_13', 'Noah',   'Hall',    '425-555-0203', '2023-05-20 11:00:00', '2024-01-18 10:00:00'),
(14, 'olivia.young@email.com',  'hashed_pw_14', 'Olivia', 'Young',   '425-555-0204', '2023-06-25 08:00:00', '2026-03-17 11:00:00'),
(15, 'parker.king@email.com',   'hashed_pw_15', 'Parker', 'King',    '253-555-0205', '2023-07-30 13:00:00', '2024-02-16 12:00:00');

-- -------------------------------------------------------------
-- SELLERS (user_id 1–9)
-- -------------------------------------------------------------
INSERT INTO Seller (user_id, store_name, store_description, rating) VALUES
(1, 'Alices Artisan Goods',  'Handmade and unique items for your home',        4.85),
(2, 'Bobs Tech Corner',      'Affordable electronics and accessories',          4.60),
(3, 'Carols Kitchen Co',     'Premium cookware and kitchen essentials',         4.75),
(4, 'Davids Outdoor Depot',  'Gear for hiking camping and adventure',           4.55),
(5, 'Emma Fashion Hub',      'Trendy clothing and accessories for all seasons', 4.90),
(6, 'Franks Fitness Store',  'Workout equipment and supplements',               4.40),
(7, 'Graces Book Nook',      'New and used books across all genres',            4.95),
(8, 'Henrys Garden World',   'Seeds tools and supplies for gardeners',          4.70),
(9, 'Iris Beauty Bar',       'Skincare makeup and wellness products',           4.80);

-- -------------------------------------------------------------
-- CUSTOMERS (user_id 11–15)
-- Addresses use no commas to avoid CSV parsing issues
-- -------------------------------------------------------------
INSERT INTO Customer (user_id, shipping_address, billing_address) VALUES
(11, '101 Pine St Seattle WA 98101',      '101 Pine St Seattle WA 98101'),
(12, '202 Oak Ave Bellevue WA 98004',     '202 Oak Ave Bellevue WA 98004'),
(13, '303 Maple Rd Tacoma WA 98401',      '303 Maple Rd Tacoma WA 98401'),
(14, '404 Cedar Ln Redmond WA 98052',     '404 Cedar Ln Redmond WA 98052'),
(15, '505 Birch Blvd Kirkland WA 98033',  '505 Birch Blvd Kirkland WA 98033');

-- -------------------------------------------------------------
-- CATEGORIES
-- -------------------------------------------------------------
INSERT INTO Category (category_id, name, description) VALUES
(1, 'Electronics',    'Gadgets and electronic accessories'),
(2, 'Home & Kitchen', 'Cookware and home decor'),
(3, 'Clothing',       'Apparel and fashion accessories'),
(4, 'Outdoors',       'Camping and outdoor recreation gear'),
(5, 'Books',          'Fiction and non-fiction books'),
(6, 'Beauty',         'Skincare and personal care products');

-- -------------------------------------------------------------
-- PRODUCTS (28 total)
-- created_at spread across 2024–2026 for newest products visual
-- No commas in descriptions to avoid CSV parsing issues
-- -------------------------------------------------------------
INSERT INTO Product (product_id, seller_id, category_id, name, description, price, created_at, is_active) VALUES
-- Electronics (2024)
(1,  2, 1, 'Wireless Earbuds',         'Bluetooth 5.0 24hr battery life',          49.99, '2024-01-10', TRUE),
(2,  2, 1, 'USB-C Hub 7-in-1',         'HDMI USB 3.0 SD card and more',            34.99, '2024-01-15', TRUE),
(3,  2, 1, 'Gaming Mouse',             'RGB 16000 DPI programmable buttons',        59.99, '2024-02-01', TRUE),
(4,  2, 1, 'Mechanical Keyboard',      'TKL layout blue switches backlit',          89.99, '2024-02-10', TRUE),
(5,  2, 1, 'Portable Charger 20000mAh','Dual USB-A fast charge support',            29.99, '2024-03-05', TRUE),
-- Home & Kitchen (2024)
(6,  3, 2, 'Cast Iron Skillet 12in',   'Pre-seasoned oven safe to 500F',            44.99, '2024-01-20', TRUE),
(7,  3, 2, 'Stainless Steel Pot Set',  '5-piece set with lids dishwasher safe',     79.99, '2024-02-05', TRUE),
(8,  1, 2, 'Scented Soy Candle',       'Hand-poured lavender and vanilla scent',    18.99, '2024-02-20', TRUE),
(9,  3, 2, 'Bamboo Cutting Board',     'Large antimicrobial juice groove',           24.99, '2024-03-01', TRUE),
(10, 1, 2, 'Ceramic Mug Set',          'Microwave and dishwasher safe 14oz each',   32.99, '2024-03-15', TRUE),
-- Clothing (2025)
(11, 5, 3, 'Classic White Tee',        '100% organic cotton unisex fit',            19.99, '2025-01-05', TRUE),
(12, 5, 3, 'Slim Fit Jeans',           'Stretch denim available in 3 washes',       54.99, '2025-01-25', TRUE),
(13, 5, 3, 'Puffer Jacket',            'Water-resistant packable warm to 20F',     119.99, '2025-02-12', TRUE),
(14, 5, 3, 'Running Shorts',           'Moisture-wicking 5in inseam side pockets',  29.99, '2025-03-10', TRUE),
(15, 5, 3, 'Wool Beanie',              'Soft merino wool one size fits most',        16.99, '2025-03-20', TRUE),
-- Outdoors (2025)
(16, 4, 4, 'Hiking Backpack 45L',      'Waterproof hip belt hydration compatible',  89.99, '2025-06-18', TRUE),
(17, 4, 4, 'Sleeping Bag -10C',        'Mummy style lightweight compression sack',  69.99, '2025-07-08', TRUE),
(18, 4, 4, 'Trekking Poles Pair',      'Aluminum collapsible cork grip',             39.99, '2025-08-25', TRUE),
(19, 4, 4, 'Portable Water Filter',    'Filters 0.1 micron 1000L capacity',         34.99, '2025-09-12', TRUE),
-- Books (2026)
(20, 7, 5, 'Clean Code',               'By Robert C. Martin essential for devs',    39.99, '2026-01-08', TRUE),
(21, 7, 5, 'The Pragmatic Programmer', 'Your journey to mastery 20th anniversary',  45.99, '2026-01-22', TRUE),
(22, 7, 5, 'Dune',                     'Frank Herbert classic sci-fi epic',          16.99, '2026-02-14', TRUE),
(23, 7, 5, 'Atomic Habits',            'James Clear build good habits break bad',   17.99, '2026-03-03', TRUE),
-- Beauty (2026)
(24, 9, 6, 'Vitamin C Serum 30ml',     'Brightening anti-aging all skin types',     28.99, '2026-03-12', TRUE),
(25, 9, 6, 'Hyaluronic Moisturizer',   'Fragrance-free 48hr hydration',             22.99, '2026-04-03', TRUE),
(26, 9, 6, 'SPF 50 Sunscreen',         'Lightweight non-greasy reef-safe',          18.99, '2026-04-22', TRUE),
(27, 9, 6, 'Retinol Night Cream',      '0.3% retinol reduces fine lines overnight', 34.99, '2026-05-08', TRUE),
(28, 9, 6, 'Jade Face Roller',         'Natural jade dual-ended reduces puffiness', 14.99, '2026-05-25', TRUE);

-- -------------------------------------------------------------
-- INVENTORY (one row per product)
-- Low stock items marked where quantity <= restock_threshold
-- -------------------------------------------------------------
INSERT INTO Inventory (product_id, quantity_in_stock, restock_threshold, last_updated) VALUES
(1,  142, 20, '2024-11-01'),  -- healthy
(2,  87,  15, '2024-11-02'),  -- healthy
(3,  8,   15, '2024-11-10'),  -- LOW STOCK
(4,  56,  20, '2024-11-05'),  -- healthy
(5,  12,  20, '2024-11-12'),  -- LOW STOCK
(6,  34,  10, '2024-11-03'),  -- healthy
(7,  22,  10, '2024-11-04'),  -- healthy
(8,  6,   15, '2024-11-14'),  -- LOW STOCK
(9,  48,  10, '2024-11-06'),  -- healthy
(10, 9,   10, '2024-11-15'),  -- LOW STOCK
(11, 200, 30, '2025-01-01'),  -- healthy
(12, 95,  25, '2025-01-02'),  -- healthy
(13, 18,  25, '2025-02-08'),  -- LOW STOCK
(14, 110, 30, '2025-03-03'),  -- healthy
(15, 77,  20, '2025-03-04'),  -- healthy
(16, 29,  15, '2025-06-05'),  -- healthy
(17, 11,  15, '2025-07-09'),  -- LOW STOCK
(18, 43,  10, '2025-08-06'),  -- healthy
(19, 7,   10, '2025-09-16'),  -- LOW STOCK
(20, 63,  10, '2026-01-02'),  -- healthy
(21, 41,  10, '2026-01-03'),  -- healthy
(22, 88,  10, '2026-02-04'),  -- healthy
(23, 5,   10, '2026-03-17'),  -- LOW STOCK
(24, 33,  15, '2026-03-06'),  -- healthy
(25, 14,  15, '2026-04-07'),  -- LOW STOCK
(26, 61,  15, '2026-04-08'),  -- healthy
(27, 4,   15, '2026-05-18'),  -- LOW STOCK
(28, 26,  10, '2026-05-09');  -- healthy

-- -------------------------------------------------------------
-- TRANSACTIONS (22 total spread across 2024–2026)
-- Customers 12 and 13 have no transactions after early 2024
-- making them genuinely inactive for the dashboard filter
-- -------------------------------------------------------------
INSERT INTO Transaction (transaction_id, customer_id, transaction_date, status, total_amount, shipping_address) VALUES
(1,  11, '2024-01-12', 'completed', 79.98,  '101 Pine St Seattle WA 98101'),
(2,  12, '2024-02-18', 'completed', 44.99,  '202 Oak Ave Bellevue WA 98004'),
(3,  13, '2024-03-25', 'completed', 174.98, '303 Maple Rd Tacoma WA 98401'),
(4,  14, '2024-04-03', 'completed', 89.99,  '404 Cedar Ln Redmond WA 98052'),
(5,  15, '2024-05-10', 'cancelled', 49.99,  '505 Birch Blvd Kirkland WA 98033'),
(6,  11, '2024-06-08', 'completed', 76.97,  '101 Pine St Seattle WA 98101'),
(7,  12, '2024-07-14', 'refunded',  79.99,  '202 Oak Ave Bellevue WA 98004'),
(8,  13, '2024-08-05', 'completed', 49.98,  '303 Maple Rd Tacoma WA 98401'),
(9,  14, '2024-09-12', 'completed', 124.98, '404 Cedar Ln Redmond WA 98052'),
(10, 15, '2024-10-20', 'completed', 70.97,  '505 Birch Blvd Kirkland WA 98033'),
(11, 11, '2025-01-15', 'completed', 119.99, '101 Pine St Seattle WA 98101'),
(12, 12, '2025-02-09', 'completed', 57.98,  '202 Oak Ave Bellevue WA 98004'),
(13, 13, '2025-04-16', 'completed', 34.99,  '303 Maple Rd Tacoma WA 98401'),
(14, 14, '2025-06-23', 'completed', 94.98,  '404 Cedar Ln Redmond WA 98052'),
(15, 15, '2025-08-01', 'completed', 139.98, '505 Birch Blvd Kirkland WA 98033'),
(16, 11, '2025-10-08', 'completed', 39.99,  '101 Pine St Seattle WA 98101'),
(17, 14, '2025-11-14', 'completed', 49.98,  '404 Cedar Ln Redmond WA 98052'),
(18, 15, '2026-01-22', 'completed', 45.99,  '505 Birch Blvd Kirkland WA 98033'),
(19, 11, '2026-02-03', 'completed', 76.97,  '101 Pine St Seattle WA 98101'),
(20, 14, '2026-03-10', 'completed', 29.99,  '404 Cedar Ln Redmond WA 98052'),
(21, 15, '2026-04-05', 'completed', 32.98,  '505 Birch Blvd Kirkland WA 98033'),
(22, 11, '2026-05-01', 'completed', 69.98,  '101 Pine St Seattle WA 98101');

-- -------------------------------------------------------------
-- TRANSACTION ITEMS
-- Composite PK: (transaction_id, product_id)
-- unit_price is a snapshot of price at time of purchase
-- -------------------------------------------------------------
INSERT INTO TransactionItem (transaction_id, product_id, quantity, unit_price) VALUES
-- Tx 1 (Liam 2024-01): Wireless Earbuds + Portable Charger
(1,  1,  1, 49.99),
(1,  5,  1, 29.99),
-- Tx 2 (Mia 2024-02): Cast Iron Skillet
(2,  6,  1, 44.99),
-- Tx 3 (Noah 2024-03): Puffer Jacket + Slim Fit Jeans
(3,  13, 1, 119.99),
(3,  12, 1, 54.99),
-- Tx 4 (Olivia 2024-04): Hiking Backpack
(4,  16, 1, 89.99),
-- Tx 5 (Parker cancelled): Wireless Earbuds
(5,  1,  1, 49.99),
-- Tx 6 (Liam 2024-06): Ceramic Mug Set + Bamboo Cutting Board + Candle
(6,  10, 1, 32.99),
(6,  9,  1, 24.99),
(6,  8,  1, 18.99),
-- Tx 7 (Mia 2024-07 refunded): Stainless Steel Pot Set
(7,  7,  1, 79.99),
-- Tx 8 (Noah 2024-08): Classic White Tee + Running Shorts
(8,  11, 1, 19.99),
(8,  14, 1, 29.99),
-- Tx 9 (Olivia 2024-09): Hiking Backpack + Portable Water Filter
(9,  16, 1, 89.99),
(9,  19, 1, 34.99),
-- Tx 10 (Parker 2024-10): Clean Code + Atomic Habits
(10, 20, 1, 39.99),
(10, 23, 1, 17.99),
-- Tx 11 (Liam 2025-01): Puffer Jacket
(11, 13, 1, 119.99),
-- Tx 12 (Mia 2025-02): Clean Code + Atomic Habits
(12, 20, 1, 39.99),
(12, 23, 1, 17.99),
-- Tx 13 (Noah 2025-04): Portable Water Filter
(13, 19, 1, 34.99),
-- Tx 14 (Olivia 2025-06): Gaming Mouse + USB-C Hub
(14, 3,  1, 59.99),
(14, 2,  1, 34.99),
-- Tx 15 (Parker 2025-08): Mechanical Keyboard + Wireless Earbuds
(15, 4,  1, 89.99),
(15, 1,  1, 49.99),
-- Tx 16 (Liam 2025-10): Trekking Poles
(16, 18, 1, 39.99),
-- Tx 17 (Olivia 2025-11): Classic White Tee + Running Shorts
(17, 11, 1, 19.99),
(17, 14, 1, 29.99),
-- Tx 18 (Parker 2026-01): The Pragmatic Programmer
(18, 21, 1, 45.99),
-- Tx 19 (Liam 2026-02): Wool Beanie + Running Shorts x2
(19, 15, 1, 16.99),
(19, 14, 2, 29.99),
-- Tx 20 (Olivia 2026-03): Running Shorts
(20, 14, 1, 29.99),
-- Tx 21 (Parker 2026-04): Dune + Hyaluronic Moisturizer
(21, 22, 1, 16.99),
(21, 25, 1, 15.99),
-- Tx 22 (Liam 2026-05): Cast Iron Skillet + Bamboo Cutting Board
(22, 6,  1, 44.99),
(22, 9,  1, 24.99);

-- -------------------------------------------------------------
-- REVIEWS
-- Composite PK: (customer_id, product_id)
-- Only completed transaction products are reviewed
-- -------------------------------------------------------------
INSERT INTO Review (customer_id, product_id, rating, title, body, created_at) VALUES
(11, 1,  5, 'Best earbuds for the price',      'Clear sound comfortable fit battery lasts all day',         '2024-01-16'),
(12, 6,  4, 'Solid skillet',                   'Heats evenly and the pre-seasoning held up well',           '2024-02-22'),
(14, 16, 5, 'Best pack I have used',           'Comfortable on long hauls hydration sleeve fits a 3L bladder', '2024-04-27'),
(11, 10, 4, 'Nice mug set',                    'Sturdy and a good size easy to clean',                      '2024-06-12'),
(14, 19, 4, 'Compact and effective',           'Used this on a 5 day trip lightweight and easy to use',     '2024-09-16'),
(15, 20, 5, 'Required reading for developers', 'Changed how I think about writing code dense but rewarding', '2024-10-25'),
(11, 13, 5, 'Warm and packable',               'Kept me warm on a winter hike worth every penny',           '2025-01-19'),
(12, 20, 5, 'Fantastic book',                  'Practical and motivating the habit framework actually works', '2025-02-13'),
(13, 19, 4, 'Does the job',                    'Reliable filter for backcountry trips no issues',            '2025-04-20'),
(14, 3,  5, 'Game changer for my setup',       'Precision is incredible RGB is subtle zero complaints',     '2025-06-27'),
(15, 4,  4, 'Great keyboard',                  'Blue switches feel satisfying backlight is clean',           '2025-08-05'),
(11, 18, 5, 'Perfect trekking poles',          'Lightweight and sturdy cork grip is comfortable',           '2025-10-12'),
(14, 11, 5, 'Perfect everyday tee',            'Soft holds its shape after washing true to size',           '2025-11-18'),
(15, 21, 4, 'Timeless advice',                 'Some examples feel dated but core principles are relevant',  '2026-01-26'),
(11, 15, 5, 'Great beanie',                    'Soft warm and fits well one of my favorites',               '2026-02-07'),
(14, 14, 4, 'Good running shorts',             'Comfortable and moisture-wicking pockets are deep enough',  '2026-03-14'),
(15, 22, 5, 'Classic for good reason',         'Dune is as epic as everyone says glad I finally read it',   '2026-04-09'),
(11, 6,  4, 'Great skillet',                   'Even heating easy to clean solid purchase',                 '2026-05-05');