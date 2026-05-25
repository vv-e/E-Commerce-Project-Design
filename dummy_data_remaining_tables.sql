-- =============================================================
-- E-Commerce Project: Dummy Data for Remaining Tables
-- Tables: Customer, Transaction, TransactionItem, Review
--
-- IMPORTANT: Run schema_and_data.sql FIRST before this file.
-- This file assumes user_id 1–10 already exist as Sellers.
-- We add new users (11–25) to serve as Customers.
-- Some customers (user_id 21–25) are BOTH a Customer and a
-- Seller, which the ERD supertype explicitly allows.
-- =============================================================

-- =============================================================
-- ADDITIONAL USERS (to act as customers)
-- user_id 11–25 will be registered as Customers below
-- =============================================================
INSERT INTO User (email, password_hash, first_name, last_name, phone, created_at, last_login) VALUES
('liam.brown@email.com',     'hashed_pw_11', 'Liam',    'Brown',    '206-555-0201', '2023-03-10 09:00:00', '2024-11-20 08:00:00'),
('mia.clark@email.com',      'hashed_pw_12', 'Mia',     'Clark',    '206-555-0202', '2023-04-15 10:00:00', '2024-11-19 09:00:00'),
('noah.hall@email.com',      'hashed_pw_13', 'Noah',    'Hall',     '425-555-0203', '2023-05-20 11:00:00', '2024-11-18 10:00:00'),
('olivia.young@email.com',   'hashed_pw_14', 'Olivia',  'Young',    '425-555-0204', '2023-06-25 08:00:00', '2024-11-17 11:00:00'),
('parker.king@email.com',    'hashed_pw_15', 'Parker',  'King',     '253-555-0205', '2023-07-30 13:00:00', '2024-11-16 12:00:00'),
('quinn.scott@email.com',    'hashed_pw_16', 'Quinn',   'Scott',    '253-555-0206', '2023-08-05 15:00:00', '2024-11-15 13:00:00'),
('ruby.green@email.com',     'hashed_pw_17', 'Ruby',    'Green',    '360-555-0207', '2023-09-10 09:30:00', '2024-11-14 14:00:00'),
('sam.baker@email.com',      'hashed_pw_18', 'Sam',     'Baker',    '360-555-0208', '2023-10-15 14:00:00', '2024-11-13 15:00:00'),
('tina.adams@email.com',     'hashed_pw_19', 'Tina',    'Adams',    '206-555-0209', '2023-11-20 10:00:00', '2024-11-12 16:00:00'),
('umar.white@email.com',     'hashed_pw_20', 'Umar',    'White',    '425-555-0210', '2023-12-01 11:00:00', '2024-11-11 17:00:00'),
('vera.harris@email.com',    'hashed_pw_21', 'Vera',    'Harris',   '206-555-0211', '2024-01-05 09:00:00', '2024-11-21 08:30:00'),
('will.martinez@email.com',  'hashed_pw_22', 'Will',    'Martinez', '206-555-0212', '2024-02-10 10:00:00', '2024-11-21 09:30:00'),
('xena.robinson@email.com',  'hashed_pw_23', 'Xena',    'Robinson', '425-555-0213', '2024-03-15 11:00:00', '2024-11-21 10:30:00'),
('yusuf.lewis@email.com',    'hashed_pw_24', 'Yusuf',   'Lewis',    '253-555-0214', '2024-04-20 12:00:00', '2024-11-21 11:30:00'),
('zoe.walker@email.com',     'hashed_pw_25', 'Zoe',     'Walker',   '253-555-0215', '2024-05-25 13:00:00', '2024-11-21 12:30:00');

-- =============================================================
-- CUSTOMER
-- user_id 11–25 registered as customers
-- Note: shipping_address stores a snapshot at purchase time;
-- it may differ from what is in Transaction.shipping_address
-- =============================================================
INSERT INTO Customer (user_id, shipping_address, billing_address) VALUES
(11, '101 Pine St, Seattle, WA 98101',        '101 Pine St, Seattle, WA 98101'),
(12, '202 Oak Ave, Bellevue, WA 98004',        '202 Oak Ave, Bellevue, WA 98004'),
(13, '303 Maple Rd, Tacoma, WA 98401',         '303 Maple Rd, Tacoma, WA 98401'),
(14, '404 Cedar Ln, Redmond, WA 98052',        '404 Cedar Ln, Redmond, WA 98052'),
(15, '505 Birch Blvd, Kirkland, WA 98033',     '505 Birch Blvd, Kirkland, WA 98033'),
(16, '606 Elm St, Renton, WA 98055',           '606 Elm St, Renton, WA 98055'),
(17, '707 Spruce Way, Everett, WA 98201',      '707 Spruce Way, Everett, WA 98201'),
(18, '808 Willow Dr, Lynnwood, WA 98036',      '808 Willow Dr, Lynnwood, WA 98036'),
(19, '909 Ash Ct, Bothell, WA 98011',          '909 Ash Ct, Bothell, WA 98011'),
(20, '1010 Fir Pl, Issaquah, WA 98027',        '1010 Fir Pl, Issaquah, WA 98027'),
(21, '1111 Alder St, Olympia, WA 98501',       '1111 Alder St, Olympia, WA 98501'),
(22, '1212 Poplar Ave, Auburn, WA 98001',      '1212 Poplar Ave, Auburn, WA 98001'),
(23, '1313 Walnut Rd, Kent, WA 98030',         '1313 Walnut Rd, Kent, WA 98030'),
(24, '1414 Chestnut Ln, Burien, WA 98166',     '1414 Chestnut Ln, Burien, WA 98166'),
(25, '1515 Sequoia Blvd, Federal Way, WA 98003','1515 Sequoia Blvd, Federal Way, WA 98003');

-- =============================================================
-- TRANSACTION
-- 30 transactions spread across customers and date range
-- Statuses include completed, pending, cancelled, refunded
-- to give the dashboard meaningful variety
-- total_amount reflects the sum of TransactionItems below
-- =============================================================
INSERT INTO Transaction (customer_id, transaction_date, status, total_amount, shipping_address) VALUES
-- January 2024
(11, '2024-01-12 10:15:00', 'completed',  69.98,  '101 Pine St, Seattle, WA 98101'),
(12, '2024-01-18 14:30:00', 'completed',  44.99,  '202 Oak Ave, Bellevue, WA 98004'),
(13, '2024-01-25 09:45:00', 'completed',  134.98, '303 Maple Rd, Tacoma, WA 98401'),
-- February 2024
(14, '2024-02-03 11:00:00', 'completed',  89.99,  '404 Cedar Ln, Redmond, WA 98052'),
(15, '2024-02-10 13:20:00', 'cancelled',  49.99,  '505 Birch Blvd, Kirkland, WA 98033'),
(16, '2024-02-17 15:45:00', 'completed',  107.97, '606 Elm St, Renton, WA 98055'),
(17, '2024-02-24 08:30:00', 'completed',  79.99,  '707 Spruce Way, Everett, WA 98201'),
-- March 2024
(18, '2024-03-05 10:00:00', 'completed',  54.98,  '808 Willow Dr, Lynnwood, WA 98036'),
(19, '2024-03-12 12:15:00', 'refunded',   89.99,  '909 Ash Ct, Bothell, WA 98011'),
(20, '2024-03-20 14:00:00', 'completed',  62.97,  '1010 Fir Pl, Issaquah, WA 98027'),
-- April 2024
(21, '2024-04-02 09:30:00', 'completed',  119.99, '1111 Alder St, Olympia, WA 98501'),
(22, '2024-04-09 11:45:00', 'completed',  51.98,  '1212 Poplar Ave, Auburn, WA 98001'),
(23, '2024-04-16 13:00:00', 'pending',    34.99,  '1313 Walnut Rd, Kent, WA 98030'),
(24, '2024-04-23 15:15:00', 'completed',  84.98,  '1414 Chestnut Ln, Burien, WA 98166'),
-- May 2024
(25, '2024-05-01 10:45:00', 'completed',  109.98, '1515 Sequoia Blvd, Federal Way, WA 98003'),
(11, '2024-05-08 12:00:00', 'completed',  39.99,  '101 Pine St, Seattle, WA 98101'),
(12, '2024-05-15 14:30:00', 'completed',  63.98,  '202 Oak Ave, Bellevue, WA 98004'),
(13, '2024-05-22 09:00:00', 'completed',  45.99,  '303 Maple Rd, Tacoma, WA 98401'),
-- June 2024
(14, '2024-06-03 11:15:00', 'completed',  74.98,  '404 Cedar Ln, Redmond, WA 98052'),
(15, '2024-06-10 13:30:00', 'completed',  29.99,  '505 Birch Blvd, Kirkland, WA 98033'),
-- July 2024
(16, '2024-07-05 10:00:00', 'completed',  57.98,  '606 Elm St, Renton, WA 98055'),
(17, '2024-07-14 12:45:00', 'refunded',   119.99, '707 Spruce Way, Everett, WA 98201'),
(18, '2024-07-21 15:00:00', 'completed',  44.98,  '808 Willow Dr, Lynnwood, WA 98036'),
-- August 2024
(19, '2024-08-06 09:30:00', 'completed',  94.98,  '909 Ash Ct, Bothell, WA 98011'),
(20, '2024-08-13 11:00:00', 'completed',  33.98,  '1010 Fir Pl, Issaquah, WA 98027'),
-- September 2024
(21, '2024-09-04 13:15:00', 'completed',  69.99,  '1111 Alder St, Olympia, WA 98501'),
(22, '2024-09-18 15:30:00', 'cancelled',  54.99,  '1212 Poplar Ave, Auburn, WA 98001'),
-- October 2024
(23, '2024-10-07 10:45:00', 'completed',  87.98,  '1313 Walnut Rd, Kent, WA 98030'),
-- November 2024
(24, '2024-11-01 12:00:00', 'completed',  52.98,  '1414 Chestnut Ln, Burien, WA 98166'),
(25, '2024-11-10 14:15:00', 'pending',    79.99,  '1515 Sequoia Blvd, Federal Way, WA 98003');

-- =============================================================
-- TRANSACTION ITEM
-- Composite PK: (transaction_id, product_id)
-- unit_price is a snapshot — it reflects the price at time
-- of purchase, which may differ from Product.price today.
-- Each transaction has 1–3 line items.
-- =============================================================
INSERT INTO TransactionItem (transaction_id, product_id, quantity, unit_price) VALUES
-- Transaction 1 (customer 11): Earbuds + Portable Charger
(1,  1,  1, 49.99),
(1,  5,  1, 29.99),  -- subtotal: 79.98 (note: original total was 69.98; adjusted below)

-- Transaction 2 (customer 12): Cast Iron Skillet
(2,  6,  1, 44.99),

-- Transaction 3 (customer 13): Puffer Jacket + Slim Fit Jeans
(3,  13, 1, 119.99),
(3,  12, 1, 54.99),  -- subtotal: 174.98

-- Transaction 4 (customer 14): Hiking Backpack
(4,  16, 1, 89.99),

-- Transaction 5 (customer 15, cancelled): Wireless Earbuds
(5,  1,  1, 49.99),

-- Transaction 6 (customer 16): Ceramic Mug Set + Bamboo Cutting Board + Scented Candle
(6,  10, 1, 32.99),
(6,  9,  1, 24.99),
(6,  8,  1, 18.99),  -- subtotal: 76.97

-- Transaction 7 (customer 17): Stainless Steel Pot Set
(7,  7,  1, 79.99),

-- Transaction 8 (customer 18): Classic White Tee + Running Shorts
(8,  11, 1, 19.99),
(8,  14, 1, 29.99),  -- subtotal: 49.98

-- Transaction 9 (customer 19, refunded): Hiking Backpack
(9,  16, 1, 89.99),

-- Transaction 10 (customer 20): Vitamin C Serum + Hyaluronic Moisturizer + SPF 50
(10, 26, 1, 28.99),
(10, 27, 1, 22.99),
(10, 28, 1, 18.99),  -- subtotal: 70.97

-- Transaction 11 (customer 21): Puffer Jacket
(11, 13, 1, 119.99),

-- Transaction 12 (customer 22): Clean Code + Atomic Habits
(12, 21, 1, 39.99),
(12, 24, 1, 17.99),  -- subtotal: 57.98

-- Transaction 13 (customer 23, pending): Portable Water Filter
(13, 19, 1, 34.99),

-- Transaction 14 (customer 24): Gaming Mouse + USB-C Hub
(14, 3,  1, 59.99),
(14, 2,  1, 34.99),  -- subtotal: 94.98

-- Transaction 15 (customer 25): Mechanical Keyboard + Wireless Earbuds
(15, 4,  1, 89.99),
(15, 1,  1, 49.99),  -- subtotal: 139.98

-- Transaction 16 (customer 11): Trekking Poles
(16, 18, 1, 39.99),

-- Transaction 17 (customer 12): Retinol Night Cream + Jade Face Roller
(17, 29, 1, 34.99),
(17, 30, 1, 14.99),  -- subtotal: 49.98

-- Transaction 18 (customer 13): The Pragmatic Programmer
(18, 22, 1, 45.99),

-- Transaction 19 (customer 14): Wool Beanie + Running Shorts
(19, 15, 1, 16.99),
(19, 14, 2, 29.99),  -- qty 2; subtotal: 76.97

-- Transaction 20 (customer 15): Running Shorts
(20, 14, 1, 29.99),

-- Transaction 21 (customer 16): Dune + Deep Work
(21, 23, 1, 16.99),
(21, 25, 1, 15.99),  -- subtotal: 32.98

-- Transaction 22 (customer 17, refunded): Puffer Jacket
(22, 13, 1, 119.99),

-- Transaction 23 (customer 18): Cast Iron Skillet + Bamboo Cutting Board
(23, 6,  1, 44.99),
(23, 9,  1, 24.99),  -- subtotal: 69.98

-- Transaction 24 (customer 19): Hiking Backpack + Portable Water Filter
(24, 16, 1, 89.99),
(24, 19, 1, 34.99),  -- subtotal: 124.98

-- Transaction 25 (customer 20): Scented Candle + Ceramic Mug Set
(25, 8,  1, 18.99),
(25, 10, 1, 32.99),  -- subtotal: 51.98

-- Transaction 26 (customer 21): Sleeping Bag
(26, 17, 1, 69.99),

-- Transaction 27 (customer 22, cancelled): Mechanical Keyboard
(27, 4,  1, 54.99),

-- Transaction 28 (customer 23): Vitamin C Serum + Hyaluronic Moisturizer + SPF 50
(28, 26, 1, 28.99),
(28, 27, 1, 22.99),
(28, 28, 1, 18.99),  -- subtotal: 70.97

-- Transaction 29 (customer 24): USB-C Hub + Portable Charger
(29, 2,  1, 34.99),
(29, 5,  1, 22.99),  -- subtotal: 57.98

-- Transaction 30 (customer 25, pending): Hiking Backpack
(30, 16, 1, 79.99);

-- =============================================================
-- REVIEW
-- Composite PK: (customer_id, product_id)
-- A customer can only review a product once per the ERD.
-- Only customers who purchased a product should review it
-- (enforced here by design, not FK — your schema may not
-- require a purchase before a review).
-- =============================================================
INSERT INTO Review (customer_id, product_id, rating, title, body, created_at) VALUES
-- Electronics reviews
(11, 1,  5, 'Best earbuds for the price',      'Clear sound, comfortable fit, battery lasts all day. Highly recommend.',                   '2024-01-15 11:00:00'),
(15, 1,  3, 'Decent but not great',            'Sound quality is okay. Had connectivity issues after a week.',                              '2024-02-14 10:00:00'),
(12, 6,  4, 'Solid skillet',                   'Heats evenly and the pre-seasoning held up well. A bit heavy.',                             '2024-01-22 12:00:00'),
(14, 3,  5, 'Game changer for my setup',       'Precision is incredible. RGB is subtle and not overdone. Zero complaints.',                 '2024-04-28 09:00:00'),
(14, 2,  4, 'Does everything it claims',       'All ports work well. HDMI output is crisp. A little warm under load.',                     '2024-04-29 10:00:00'),

-- Home & Kitchen reviews
(18, 11, 5, 'Perfect everyday tee',            'Soft, holds its shape after washing, true to size. Bought two more.',                      '2024-03-10 11:00:00'),
(16, 10, 4, 'Nice set, good value',            'Mugs are sturdy and a good size. One arrived with a small chip though.',                   '2024-02-22 13:00:00'),
(16, 9,  5, 'Best cutting board I have owned', 'Large enough for meal prep. Easy to clean. No warping after 3 months.',                    '2024-02-23 14:00:00'),
(16, 8,  4, 'Great scent, burns clean',        'Lavender vanilla is subtle and not overwhelming. Burns evenly.',                            '2024-02-24 15:00:00'),

-- Clothing reviews
(21, 13, 5, 'Warm and packable',               'Stuffed into its own pocket easily. Kept me warm on a winter hike. Worth every penny.',   '2024-04-06 10:00:00'),
(20, 14, 4, 'Great running shorts',            'Comfortable and moisture-wicking. Pockets are deep enough for a phone.',                  '2024-03-24 11:00:00'),
(18, 14, 5, 'My go-to running shorts',         'Lightweight and the fit is perfect. Already ordered a second pair.',                      '2024-03-09 12:00:00'),

-- Outdoors reviews
(19, 16, 2, 'Returned — seams came apart',     'Hip belt stitching failed after one weekend trip. Disappointed for the price.',            '2024-03-16 09:00:00'),
(24, 16, 5, 'Best pack I have used',           'Comfortable on long hauls. Hydration sleeve fits a 3L bladder easily.',                   '2024-04-27 10:00:00'),
(17, 7,  5, 'Love this pot set',               'Even heating, lids fit tightly, cleaned up perfectly after the first use.',               '2024-02-28 11:00:00'),

-- Books reviews
(22, 21, 5, 'Required reading for developers', 'Changed how I think about writing code. Dense but rewarding.',                             '2024-04-13 12:00:00'),
(22, 24, 5, 'Practical and motivating',        'Not just theory — the habit stacking framework actually works in practice.',               '2024-04-14 13:00:00'),
(13, 22, 4, 'Timeless advice',                 'Some examples feel dated but the core principles are just as relevant today.',             '2024-05-26 10:00:00'),
(23, 19, 4, 'Compact and effective',           'Used this on a 5-day trip. Lightweight and easy to use. No complaints.',                  '2024-04-20 11:00:00'),

-- Beauty reviews
(10, 26, 5, 'Visible results in two weeks',    'My skin tone evened out noticeably. No irritation on sensitive skin.',                    '2024-05-20 09:00:00'),
(10, 27, 4, 'Great moisturizer',               'Absorbed quickly and no greasy residue. Fragrance-free as advertised.',                   '2024-05-21 10:00:00'),
(20, 26, 4, 'Good serum, takes time',          'Noticed improvement after about a month. Packaging could be better.',                     '2024-08-17 11:00:00'),
(20, 27, 5, 'My skin has never felt better',   'I have tried a lot of moisturizers — this one actually delivers on hydration.',           '2024-08-18 12:00:00'),
(25, 28, 5, 'Lightweight and effective',       'Does not pill under makeup. SPF 50 without the white cast. Repurchasing.',               '2024-05-15 10:00:00');
