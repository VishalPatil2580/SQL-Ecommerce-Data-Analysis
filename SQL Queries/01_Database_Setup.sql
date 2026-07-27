-- Phase 1 : Database Setup
-- Create Database
CREATE DATABASE ecommerce_analysis;

-- Use Database
USE ecommerce_analysis;

-- Show tables present in database
SHOW TABLES;

-- Table Structure
DESCRIBE customers;
DESCRIBE products;
DESCRIBE orders;

-- Total Number of Rows
SELECT COUNT(*) AS Total_Customers
FROM customers;

SELECT COUNT(*) AS Total_Products
FROM products;

SELECT COUNT(*) AS Total_Orders
FROM orders;

-- Total Number of Columns
SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ecommerce_analysis'
AND TABLE_NAME = 'customers';

SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ecommerce_analysis'
AND TABLE_NAME = 'products';

SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ecommerce_analysis'
AND TABLE_NAME = 'orders';

-- View First 10 Records
SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM products
LIMIT 10;

SELECT *
FROM orders
LIMIT 10;

-- View Last 10 Records
SELECT *
FROM customers
ORDER BY customer_id DESC
LIMIT 10;

SELECT *
FROM products
ORDER BY product_id DESC
LIMIT 10;

SELECT *
FROM orders
ORDER BY order_id DESC
LIMIT 10;



