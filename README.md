# E-Commerce-Project-Design

**Strong Entities** (independent):  
User, Seller, Customer, Category, Product, Transaction

**Weak Entities** (dependent):  
- Inventory: depends entirely on a Product record  
- Review: a customer can only review a product once
    - composite PK (customer_id + product_id)
- TransactionItem: price snapshot

**Supertype / Subtype**  
- Supertype: User  
- Subtypes: Customer and Seller overlap, a user can be a customer, seller, or both
- They share the user_id as PK. Discriminator is implied by the subtype tables.
