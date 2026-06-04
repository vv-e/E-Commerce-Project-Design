-- -------------------------------------------------------------
-- List Current Inventory
-- Joins Product, Inventory, and Category to show stock levels
-- for all active products. Flags any product at or below its
-- restock threshold as LOW STOCK for easy identification.
-- -- -------------------------------------------------------------

SELECT 
    p.product_id,
    p.name,
    p.price,
    c.name AS category,
    s.store_name AS seller,
    i.quantity_in_stock,
    i.restock_threshold,
    CASE 
        WHEN i.quantity_in_stock <= i.restock_threshold THEN 'LOW STOCK'
        ELSE 'OK'
    END AS stock_status
FROM Product p
JOIN Inventory i ON p.product_id = i.product_id
JOIN Category c ON p.category_id = c.category_id
JOIN Seller s ON p.seller_id = s.user_id
WHERE p.is_active = TRUE
ORDER BY stock_status DESC, p.name ASC;


-- -------------------------------------------------------------
-- Create a New Product
-- Inserting a product requires two statements: one for the
-- Product record itself, and one for its Inventory row.
-- LAST_INSERT_ID() captures the auto-generated product_id
-- from the first insert so the Inventory row references it
-- correctly without hardcoding the ID.
-- -------------------------------------------------------------

INSERT INTO Product (seller_id, category_id, name, description, price, is_active)
VALUES (1, 2, 'Linen Table Runner', 'Hand-stitched, 72 inch, natural linen.', 24.99, TRUE);

-- Inventory row must be inserted immediately after so
-- LAST_INSERT_ID() still holds the correct product_id
INSERT INTO Inventory (product_id, quantity_in_stock, restock_threshold)
VALUES (LAST_INSERT_ID(), 40, 10);


-- -------------------------------------------------------------
-- Modify Product Quantity
-- Decrements stock by 1 for a given product_id. In a real
-- application this would be called at checkout, and the
-- quantity would reflect the number of units purchased rather
-- than a hardcoded 1.
-- -------------------------------------------------------------
UPDATE Inventory
SET quantity_in_stock = quantity_in_stock - 1  -- relative update, not an absolute overwrite
WHERE product_id = 1;


-- -------------------------------------------------------------
-- Delete a Product
-- Rather than removing the row entirely, we set is_active to
-- FALSE. This preserves the product record for historical
-- reference TransactionItem rows still reference this
-- product_id, so a hard DELETE would violate the foreign key
-- constraint and erase purchase history.
-- -------------------------------------------------------------
UPDATE Product
SET is_active = FALSE  -- hides product from listings without destroying historical data
WHERE product_id = 1;


-- -------------------------------------------------------------
--  Most popular products for a date range
-- -------------------------------------------------------------
SET @range_start = '2024-01-01 00:00:00';
SET @range_end   = '2024-12-31 23:59:59';

SELECT
    p.product_id,
    p.name AS product_name,
    c.name AS category,
    SUM(ti.quantity) AS total_units_sold,
    SUM(ti.quantity * ti.unit_price) AS total_revenue
FROM TransactionItem ti
JOIN `Transaction` t ON ti.transaction_id = t.transaction_id
JOIN Product p ON ti.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
WHERE t.status = 'completed'
  AND t.transaction_date BETWEEN @range_start AND @range_end
GROUP BY p.product_id, p.name, c.name
ORDER BY units_sold DESC, revenue DESC
LIMIT 10;


-- -------------------------------------------------------------
-- Least popular products for a date range
-- -------------------------------------------------------------
SET @range_start = '2024-01-01 00:00:00';
SET @range_end   = '2024-12-31 23:59:59';

SELECT
    p.product_id,
    p.name,
    c.name AS category,
    SUM(ti.quantity) AS units_sold,
    SUM(ti.quantity * ti.unit_price) AS revenue
FROM TransactionItem ti
JOIN `Transaction` t ON ti.transaction_id = t.transaction_id
JOIN Product p ON ti.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
WHERE t.status = 'completed'
  AND t.transaction_date BETWEEN @range_start AND @range_end
GROUP BY p.product_id, p.name, c.name
ORDER BY units_sold ASC, revenue ASC
LIMIT 10;


-- -------------------------------------------------------------
-- Inactive customers + products they usually purchase
-- Customers with no completed purchase in the last @inactive_months months.
-- -------------------------------------------------------------
SET @as_of_date      = '2026-05-31 23:59:59';
SET @inactive_months = 3;

WITH last_purchase AS (
    SELECT
        customer_id,
        MAX(transaction_date) AS last_purchase_date
    FROM `Transaction`
    WHERE status = 'completed'
    GROUP BY customer_id
),
inactive_customers AS (
    SELECT
        c.user_id AS customer_id,
        u.email,
        u.first_name,
        u.last_name,
        lp.last_purchase_date
    FROM Customer c
    JOIN `User` u ON c.user_id = u.user_id
    LEFT JOIN last_purchase lp ON c.user_id = lp.customer_id
    WHERE lp.last_purchase_date IS NULL
       OR lp.last_purchase_date < DATE_SUB(@as_of_date, INTERVAL @inactive_months MONTH)
),
purchase_history AS (
    SELECT
        t.customer_id,
        ti.product_id,
        p.name AS product_name,
        SUM(ti.quantity) AS times_purchased
    FROM `Transaction` t
    JOIN TransactionItem ti ON t.transaction_id = ti.transaction_id
    JOIN Product p ON ti.product_id = p.product_id
    WHERE t.status = 'completed'
    GROUP BY t.customer_id, ti.product_id, p.name
),
ranked_products AS (
    SELECT
        ph.customer_id,
        ph.product_id,
        ph.product_name,
        ph.times_purchased,
        ROW_NUMBER() OVER (
            PARTITION BY ph.customer_id
            ORDER BY ph.times_purchased DESC, ph.product_name ASC
        ) AS purchase_rank
    FROM purchase_history ph
    JOIN inactive_customers ic ON ph.customer_id = ic.customer_id
)
SELECT
    ic.customer_id,
    ic.email,
    ic.first_name,
    ic.last_name,
    ic.last_purchase_date,
    rp.product_id,
    rp.product_name,
    rp.times_purchased AS usual_purchase_count
FROM inactive_customers ic
LEFT JOIN ranked_products rp
    ON ic.customer_id = rp.customer_id
   AND rp.purchase_rank <= 3
ORDER BY ic.last_name, ic.first_name, rp.purchase_rank;
