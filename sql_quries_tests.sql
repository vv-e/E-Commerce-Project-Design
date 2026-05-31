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
    i.quantity_in_stock,
    i.restock_threshold,
    CASE 
        WHEN i.quantity_in_stock <= i.restock_threshold THEN 'LOW STOCK'
        ELSE 'OK'
    END AS stock_status
FROM Product p
JOIN Inventory i ON p.product_id = i.product_id   -- each product has exactly one inventory row
JOIN Category c ON p.category_id = c.category_id  -- bring in the human-readable category name
WHERE p.is_active = TRUE                          -- exclude soft-deleted products
ORDER BY stock_status DESC, p.name ASC;           -- LOW STOCK rows surface first


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