# E-Commerce-Project-Design
**Course:** Database Technologies, Spring 2026

Relational database design and implementation for online marketplace, including seed data, required SQL queries, and a Tableau analytics dashboard.

## Schema Overview

Nine tables in Boyce-Codd Normal Form:

- User, Seller, Customer, Category, Product, Inventory, Transaction, TransactionItem, Review

Relationships at a glance: User branches to Seller and Customer. Seller lists Product. Product belongs to Category and has one Inventory record. Customer places Transaction. Transaction contains TransactionItem line items. Customer and Product participate in Review.

**Strong Entities** (independent): User, Seller, Customer, Category, Product, Transaction

**Weak Entities** (dependent):  
- Inventory: depends entirely on a Product record  
- Review: a customer can only review a product once
    - composite PK (customer_id + product_id)
- TransactionItem: price snapshot

**Supertype / Subtype**  
- Supertype: User  
- Subtypes: Customer and Seller overlap, a user can be a customer, seller, or both
- They share the user_id as PK. Discriminator is implied by the subtype tables.

## Normalization

The schema was normalized to BCNF during the implementation phase. Key splits:

1. User + Customer + Seller: supertype/subtype instead of one wide user table
2. Product + Inventory: stock lifecycle separated from catalog listing
3. Transaction + TransactionItem: resolves order line items without repeating groups
4. Review: separate entity with composite PK enforcing one review per pair
5. Category: lookup table eliminates redundant category names on products

## Required Queries

All seven assignment queries:

1. List products currently in inventory (with low-stock flag)
2. Create a new product (Product INSERT + Inventory INSERT via LAST_INSERT_ID)
3. Modify product inventory quantity (relative UPDATE on Inventory)
4. Delete a product from inventory (soft delete: is_active = FALSE on Product)
5. Most popular products for a date range (GROUP BY, completed transactions only)
6. Least popular products for a date range (same logic, ascending order)
7. Inactive customers and products they usually purchase (CTEs + ROW_NUMBER window function)

## Design Decisions

- **Snapshot pricing**: TransactionItem.unit_price stores price at purchase time; Product.price may change later
- **Snapshot shipping**: Transaction.shipping_address stored on the order; customer address may change later
- **Soft delete**: Products are hidden via is_active instead of hard DELETE, preserving FK history in TransactionItem
- **Check constraints**: price >= 0, rating BETWEEN 1 AND 5, quantity > 0 on line items
- **Tableau revenue**: calculated at line-item level (quantity * unit_price) to avoid join fanout double-counting

## Seed Data

Enough sample data to demonstrate all features: 14 users, 9 sellers, 5 customers, 6 categories, 28 products, 22 transactions, 36 line items, 18 reviews. Ten products are flagged low-stock; specific customers are seeded as inactive for dashboard and query demos.

## Tableau Dashboard

Open ecommerce_dashboard.twbx in Tableau Desktop or Tableau Public. Data source: CSV files in sql data/, related to match the normalized schema.

## Slideshow & Presentation
https://docs.google.com/presentation/d/1z-sQ0JWjsjaZEkRBNolMZIunxdzwMoYGv7Fu5ASKJ3k/edit?usp=sharing
