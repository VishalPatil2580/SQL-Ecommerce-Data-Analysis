-- Phase 5 : Data Validation

USE ecommerce_analysis;

-- 5.1 Customers Table Validation

-- Total Records After Cleaning

SELECT COUNT(*) AS Total_Customers
FROM customers;

-- Check Missing Values

SELECT *
FROM customers
WHERE customer_id IS NULL
OR customer_name IS NULL
OR gender IS NULL
OR city IS NULL
OR state IS NULL
OR signup_date IS NULL
OR membership IS NULL
OR age IS NULL;

-- Check Duplicate Customer IDs

SELECT
customer_id,
COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check Complete Duplicate Records

SELECT
customer_id,
customer_name,
gender,
city,
state,
signup_date,
membership,
age,
COUNT(*) AS duplicate_count
FROM customers
GROUP BY
customer_id,
customer_name,
gender,
city,
state,
signup_date,
membership,
age
HAVING COUNT(*) > 1;

-- Validate Gender

SELECT DISTINCT gender
FROM customers
ORDER BY gender;

-- Validate Membership

SELECT DISTINCT membership
FROM customers
ORDER BY membership;

-- Validate Age Range

SELECT *
FROM customers
WHERE age NOT BETWEEN 18 AND 80;

-- Verify Data Types

DESCRIBE customers;

-- 5.2 Products Table Validation

-- Total Records After Cleaning

SELECT COUNT(*) AS Total_Products
FROM products;

-- Check Missing Values

SELECT *
FROM products
WHERE product_id IS NULL
OR product_name IS NULL
OR category IS NULL
OR brand IS NULL
OR price IS NULL
OR stock_quantity IS NULL
OR supplier IS NULL
OR rating IS NULL;

-- Check Duplicate Product IDs

SELECT
product_id,
COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Check Complete Duplicate Records

SELECT
product_id,
product_name,
category,
brand,
price,
stock_quantity,
supplier,
rating,
COUNT(*) AS duplicate_count
FROM products
GROUP BY
product_id,
product_name,
category,
brand,
price,
stock_quantity,
supplier,
rating
HAVING COUNT(*) > 1;

-- Validate Category

SELECT DISTINCT category
FROM products
ORDER BY category;

-- Validate Price

SELECT *
FROM products
WHERE price <= 0;

-- Validate Stock Quantity

SELECT *
FROM products
WHERE stock_quantity < 0;

-- Validate Rating

SELECT *
FROM products
WHERE rating NOT BETWEEN 0 AND 5;

-- Verify Data Types

DESCRIBE products;


-- 5.3 Orders Table Validation

-- Total Records After Cleaning

SELECT COUNT(*) AS Total_Orders
FROM orders;

-- Check Missing Values

SELECT *
FROM orders
WHERE order_id IS NULL
OR customer_id IS NULL
OR product_id IS NULL
OR order_date IS NULL
OR quantity IS NULL
OR discount IS NULL
OR payment_method IS NULL
OR order_status IS NULL;

-- Check Duplicate Order IDs

SELECT
order_id,
COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check Complete Duplicate Records

SELECT
order_id,
customer_id,
product_id,
order_date,
quantity,
discount,
payment_method,
order_status,
COUNT(*) AS duplicate_count
FROM orders
GROUP BY
order_id,
customer_id,
product_id,
order_date,
quantity,
discount,
payment_method,
order_status
HAVING COUNT(*) > 1;

-- Validate Quantity

SELECT *
FROM orders
WHERE quantity <= 0;

-- Validate Discount

SELECT *
FROM orders
WHERE discount < 0
OR discount > 100;

-- Validate Payment Method

SELECT DISTINCT payment_method
FROM orders
ORDER BY payment_method;

-- Validate Order Status

SELECT DISTINCT order_status
FROM orders
ORDER BY order_status;

-- Verify Customer IDs

SELECT *
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Verify Product IDs

SELECT *
FROM orders o
LEFT JOIN products p
ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Verify Data Types

DESCRIBE orders;


-- 5.4 Final Validation Summary

-- Customers

SELECT
COUNT(*) AS Total_Customers,
SUM(customer_id IS NULL) AS Missing_Customer_ID,
SUM(customer_name IS NULL) AS Missing_Customer_Name,
SUM(age IS NULL) AS Missing_Age
FROM customers;

-- Products

SELECT
COUNT(*) AS Total_Products,
SUM(product_id IS NULL) AS Missing_Product_ID,
SUM(product_name IS NULL) AS Missing_Product_Name,
SUM(price IS NULL) AS Missing_Price
FROM products;

-- Orders

SELECT
COUNT(*) AS Total_Orders,
SUM(order_id IS NULL) AS Missing_Order_ID,
SUM(customer_id IS NULL) AS Missing_Customer_ID,
SUM(product_id IS NULL) AS Missing_Product_ID,
SUM(quantity IS NULL) AS Missing_Quantity
FROM orders;

-- Indexes & Constraints

-- Create Primary Keys

ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

ALTER TABLE products
ADD PRIMARY KEY (product_id);

ALTER TABLE orders
ADD PRIMARY KEY (order_id);

-- Create Foreign Keys

ALTER TABLE orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- Create Indexes

CREATE INDEX idx_customer
ON orders(customer_id);

CREATE INDEX idx_product
ON orders(product_id);

CREATE INDEX idx_order_date
ON orders(order_date);

CREATE INDEX idx_category
ON products(category);

CREATE INDEX idx_membership
ON customers(membership);

CREATE INDEX idx_state
ON customers(state);