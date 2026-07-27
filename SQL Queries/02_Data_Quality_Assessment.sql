-- Phase 2 : Data Quality Assessment 
USE ecommerce_analysis;

-- 2.1 Customers Table

-- Check Missing Values

-- Missing Customer ID
SELECT *
FROM customers
WHERE customer_id IS NULL
OR TRIM(customer_id) = '';

-- Missing Customer Name
SELECT *
FROM customers
WHERE customer_name IS NULL
OR TRIM(customer_name) = '';

-- Missing Gender
SELECT *
FROM customers
WHERE gender IS NULL
OR TRIM(gender) = '';

-- Missing City
SELECT *
FROM customers
WHERE city IS NULL
OR TRIM(city) = '';

-- Missing State
SELECT *
FROM customers
WHERE state IS NULL
OR TRIM(state) = '';

-- Missing Signup Date
SELECT *
FROM customers
WHERE signup_date IS NULL
OR TRIM(signup_date) = '';

-- Missing Membership
SELECT *
FROM customers
WHERE membership IS NULL
OR TRIM(membership) = '';

-- Missing Age
SELECT *
FROM customers
WHERE age IS NULL
OR TRIM(age) = '';

-- Check Duplicate Records

-- Duplicate Customer IDs
SELECT
customer_id,
COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Complete Duplicate Rows
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

-- Check Data Consistency

SELECT DISTINCT gender
FROM customers
ORDER BY gender;

SELECT DISTINCT city
FROM customers
ORDER BY city;

SELECT DISTINCT state
FROM customers
ORDER BY state;

SELECT DISTINCT membership
FROM customers
ORDER BY membership;

-- Check Wrong Data Type Entries

-- Age contains text instead of numbers
SELECT *
FROM customers
WHERE age IS NOT NULL
AND TRIM(age) <> ''
AND age NOT REGEXP '^[0-9]+$';

-- Check Invalid Values / Outliers

-- Invalid Age
SELECT *
FROM customers
WHERE age REGEXP '^[0-9]+$'
AND CAST(age AS UNSIGNED) NOT BETWEEN 18 AND 80;

-- Check Date Formats

SELECT DISTINCT signup_date
FROM customers
ORDER BY signup_date;


-- 2.2 Products Table

-- Check Missing Values

SELECT *
FROM products
WHERE product_id IS NULL
OR TRIM(product_id) = '';

SELECT *
FROM products
WHERE product_name IS NULL
OR TRIM(product_name) = '';

SELECT *
FROM products
WHERE category IS NULL
OR TRIM(category) = '';

SELECT *
FROM products
WHERE brand IS NULL
OR TRIM(brand) = '';

SELECT *
FROM products
WHERE price IS NULL
OR TRIM(price) = '';

SELECT *
FROM products
WHERE stock_quantity IS NULL
OR TRIM(stock_quantity) = '';

SELECT *
FROM products
WHERE supplier IS NULL
OR TRIM(supplier) = '';

SELECT *
FROM products
WHERE rating IS NULL
OR TRIM(rating) = '';

-- Check Duplicate Records

SELECT
product_id,
COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

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

-- Check Data Consistency

SELECT DISTINCT category
FROM products
ORDER BY category;

SELECT DISTINCT brand
FROM products
ORDER BY brand;

SELECT DISTINCT supplier
FROM products
ORDER BY supplier;

-- Check Wrong Data Type Entries

-- Price contains text
SELECT *
FROM products
WHERE price IS NOT NULL
AND TRIM(price) <> ''
AND price NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';

-- Stock Quantity contains text
SELECT *
FROM products
WHERE stock_quantity IS NOT NULL
AND TRIM(stock_quantity) <> ''
AND stock_quantity NOT REGEXP '^-?[0-9]+$';

-- Rating contains text
SELECT *
FROM products
WHERE rating IS NOT NULL
AND TRIM(rating) <> ''
AND rating NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';

-- Check Invalid Values / Outliers

SELECT *
FROM products
WHERE price REGEXP '^[0-9]+(\\.[0-9]+)?$'
AND CAST(price AS DECIMAL(10,2)) <= 0;

SELECT *
FROM products
WHERE stock_quantity REGEXP '^-?[0-9]+$'
AND CAST(stock_quantity AS SIGNED) < 0;

SELECT *
FROM products
WHERE rating REGEXP '^[0-9]+(\\.[0-9]+)?$'
AND CAST(rating AS DECIMAL(3,1)) NOT BETWEEN 0 AND 5;


-- 2.3 Orders Table

-- Check Missing Values

SELECT *
FROM orders
WHERE order_id IS NULL
OR TRIM(order_id) = '';

SELECT *
FROM orders
WHERE customer_id IS NULL
OR TRIM(customer_id) = '';

SELECT *
FROM orders
WHERE product_id IS NULL
OR TRIM(product_id) = '';

SELECT *
FROM orders
WHERE order_date IS NULL
OR TRIM(order_date) = '';

SELECT *
FROM orders
WHERE quantity IS NULL
OR TRIM(quantity) = '';

SELECT *
FROM orders
WHERE discount IS NULL
OR TRIM(discount) = '';

SELECT *
FROM orders
WHERE payment_method IS NULL
OR TRIM(payment_method) = '';

SELECT *
FROM orders
WHERE order_status IS NULL
OR TRIM(order_status) = '';

-- Check Duplicate Records

SELECT
order_id,
COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

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

-- Check Foreign Key Integrity

SELECT *
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT *
FROM orders o
LEFT JOIN products p
ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Check Data Consistency

SELECT DISTINCT payment_method
FROM orders
ORDER BY payment_method;

SELECT DISTINCT order_status
FROM orders
ORDER BY order_status;

-- Check Wrong Data Type Entries

-- Quantity contains text
SELECT *
FROM orders
WHERE quantity IS NOT NULL
AND TRIM(quantity) <> ''
AND quantity NOT REGEXP '^-?[0-9]+$';

-- Discount contains text
SELECT *
FROM orders
WHERE discount IS NOT NULL
AND TRIM(discount) <> ''
AND discount NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?%?$';

-- Check Invalid Values / Outliers

-- Invalid Quantity
SELECT *
FROM orders
WHERE quantity REGEXP '^-?[0-9]+$'
AND CAST(quantity AS SIGNED) <= 0;

-- Negative Discount
SELECT *
FROM orders
WHERE discount REGEXP '^-?[0-9]+(\\.[0-9]+)?$'
AND CAST(discount AS DECIMAL(5,2)) < 0;

-- Discount Greater Than 100
SELECT *
FROM orders
WHERE discount REGEXP '^-?[0-9]+(\\.[0-9]+)?$'
AND CAST(discount AS DECIMAL(5,2)) > 100;

-- Check Date Formats

SELECT DISTINCT order_date
FROM orders
ORDER BY order_date;
