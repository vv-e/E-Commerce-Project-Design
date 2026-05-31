-- -------------------------------------------------------------
-- Validates the Categories Performing Best sheet in Tableau.
-- Revenue is calculated at the line item level (quantity * price)
-- rather than using the transaction total_amount, which avoids
-- double counting caused by Tableau's relationship fanout across
-- multiple joined tables. The category ranking here should match
-- the bar order shown in the Categories Performing Best sheet.
-- -------------------------------------------------------------
SELECT
    c.name AS category,
    -- Multiply quantity purchased by unit price to get line item revenue
    -- then sum across all transaction items per category
    SUM(ti.quantity * p.price) AS total_revenue
FROM TransactionItem ti
    -- Join products to get the price and category for each line item
    JOIN Product p ON ti.product_id = p.product_id
    -- Join categories to get the human-readable category name
    JOIN Category c ON p.category_id = c.category_id
GROUP BY c.name
ORDER BY total_revenue DESC;

-- -------------------------------------------------------------
-- Validates the user -> customer -> transaction join chain.
-- Every customer should appear even if they have zero transactions
-- (LEFT JOIN ensures this). Customers with 0 orders are effectively
-- inactive and should match the users shown in the User Login Activity
-- sheet in Tableau. Last login and last purchase date are included
-- to directly validate what the Tableau sheet displays.
-- -------------------------------------------------------------
SELECT
    u.first_name,
    u.last_name,
    u.last_login,
    -- Last purchase date comes from the most recent transaction date
    MAX(t.transaction_date) AS last_purchase_date,
    COUNT(t.transaction_id) AS total_orders
FROM User u
    -- Join to customer to confirm user has a customer record
    JOIN Customer c ON u.user_id = c.user_id
    -- LEFT JOIN to preserve customers with no transactions
    LEFT JOIN Transaction t ON c.user_id = t.customer_id
GROUP BY u.first_name, u.last_name, u.last_login
ORDER BY total_orders DESC;

-- -------------------------------------------------------------
-- Validates the product -> inventory join and checks stock health.
-- Every product should have exactly one inventory record.
-- Products at or below restock_threshold are flagged as Low Stock.
-- Results should match the Inventory Levels sheet in Tableau.
-- -------------------------------------------------------------
SELECT
    p.name AS product,
    i.quantity_in_stock,
    i.restock_threshold,
    -- Flag products that need restocking based on reorder threshold
    CASE
        WHEN i.quantity_in_stock <= i.restock_threshold THEN 'Low Stock'
        ELSE 'OK'
    END AS stock_status
FROM Product p
    -- Join inventory to get current stock levels per product
    JOIN Inventory i ON p.product_id = i.product_id
ORDER BY i.quantity_in_stock ASC;