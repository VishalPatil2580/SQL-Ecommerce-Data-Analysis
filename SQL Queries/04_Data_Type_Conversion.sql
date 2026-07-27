-- Phase 4 : Data Type Conversion

USE ecommerce_analysis;

-- Convert Customer Table
ALTER TABLE customers
MODIFY customer_id VARCHAR(10),
MODIFY customer_name VARCHAR(100),
MODIFY gender VARCHAR(10),
MODIFY city VARCHAR(50),
MODIFY state VARCHAR(20),
MODIFY signup_date DATE,
MODIFY membership VARCHAR(20),
MODIFY age INT(20);


-- 4.2 Convert Products Table

-- Convert Price Data Type

ALTER TABLE products
MODIFY product_id VARCHAR(10),
MODIFY product_name VARCHAR(100),
MODIFY category VARCHAR(50),
MODIFY brand VARCHAR(100),
MODIFY supplier VARCHAR(50);

-- Convert Stock Quantity Data Type

ALTER TABLE products
MODIFY stock_quantity INT;

-- Convert Rating Data Type

ALTER TABLE products
MODIFY rating DECIMAL(3,1);

-- 4.3 Convert Orders Table

ALTER TABLE orders
MODIFY order_id VARCHAR(10),
MODIFY customer_id VARCHAR(10),
MODIFY product_id VARCHAR(10),
MODIFY payment_method VARCHAR(50),
MODIFY order_status VARCHAR(50);

-- Convert Order Date Data Type

ALTER TABLE orders
MODIFY order_date DATE;

-- Convert Quantity Data Type

ALTER TABLE orders
MODIFY quantity INT;

-- Convert Discount Data Type

ALTER TABLE orders
MODIFY discount DECIMAL(5,2);


-- 4.4 Verify Converted Data Types

DESCRIBE customers;
DESCRIBE products;
DESCRIBE orders;

-- Verify Date Conversion
SELECT signup_date
FROM customers
LIMIT 10;

SELECT order_date
FROM orders
LIMIT 10;

-- Verify Numeric Columns

SELECT age
FROM customers
LIMIT 10;

SELECT price,
       stock_quantity,
       rating
FROM products
LIMIT 10;

SELECT quantity,
       discount
FROM orders
LIMIT 10;