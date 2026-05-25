create database ecommercedb;
use ecommercedb;

-- -------------------------------------------------------------
--	  USER
--    The supertype entity. Sellers and Customers both share
--    user_id as their PK/FK, so this must be created first.
-- -------------------------------------------------------------
CREATE TABLE User (
    user_id       INT            NOT NULL AUTO_INCREMENT,
    email         VARCHAR(255)   NOT NULL,
    password_hash VARCHAR(255)   NOT NULL,
    first_name    VARCHAR(100)   NOT NULL,
    last_name     VARCHAR(100)   NOT NULL,
    phone         VARCHAR(20),
    created_at    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login    DATETIME,
 
    CONSTRAINT pk_user    PRIMARY KEY (user_id),
    CONSTRAINT uq_email   UNIQUE      (email)
);
 
-- -------------------------------------------------------------
--    SELLER (Subtype of User)
--    user_id is both PK and FK — it must already exist in User.
--    store_name must be unique across all sellers.
-- -------------------------------------------------------------
CREATE TABLE Seller (
    user_id           INT             NOT NULL,
    store_name        VARCHAR(255)    NOT NULL,
    store_description TEXT,
    rating            DECIMAL(3,2),
 
    CONSTRAINT pk_seller         PRIMARY KEY (user_id),
    CONSTRAINT fk_seller_user    FOREIGN KEY (user_id) REFERENCES User(user_id),
    CONSTRAINT uq_store_name     UNIQUE      (store_name)
);

-- -------------------------------------------------------------
--    CATEGORY
--    Standalone table, no foreign keys.
--    name must be unique to avoid duplicate categories.
-- -------------------------------------------------------------
CREATE TABLE Category (
    category_id  INT            NOT NULL AUTO_INCREMENT,
    name         VARCHAR(100)   NOT NULL,
    description  TEXT,
 
    CONSTRAINT pk_category   PRIMARY KEY (category_id),
    CONSTRAINT uq_cat_name   UNIQUE      (name)
);

-- -------------------------------------------------------------
--    PRODUCT
--    References both Seller(user_id) and Category(category_id),
--    so both of those tables must exist first.
-- -------------------------------------------------------------
CREATE TABLE Product (
    product_id   INT             NOT NULL AUTO_INCREMENT,
    seller_id    INT             NOT NULL,
    category_id  INT             NOT NULL,
    name         VARCHAR(255)    NOT NULL,
    description  TEXT,
    price        DECIMAL(10,2)   NOT NULL,
    created_at   DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_active    BOOLEAN         NOT NULL DEFAULT TRUE,
 
    CONSTRAINT pk_product          PRIMARY KEY (product_id),
    CONSTRAINT fk_product_seller   FOREIGN KEY (seller_id)   REFERENCES Seller(user_id),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

 
-- -------------------------------------------------------------
--    INVENTORY (Weak Entity)
--    Existence depends entirely on a Product record.
--    product_id is both PK and FK.
-- -------------------------------------------------------------
CREATE TABLE Inventory (
    product_id        INT      NOT NULL,
    quantity_in_stock INT      NOT NULL DEFAULT 0,
    restock_threshold INT      NOT NULL DEFAULT 10,
    last_updated      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 
    CONSTRAINT pk_inventory         PRIMARY KEY (product_id),
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES Product(product_id)
);


