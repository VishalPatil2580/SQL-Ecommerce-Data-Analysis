-- Phase 3 : Data Cleaning & Standardization

USE ecommerce_analysis;

-- Create Backup Tables

CREATE TABLE customers_backup AS
SELECT *
FROM customers;

CREATE TABLE products_backup AS
SELECT *
FROM products;

CREATE TABLE orders_backup AS
SELECT *
FROM orders;

-- 3.1 Customers Table

-- Remove Leading & Trailing Spaces

UPDATE customers
SET customer_id = TRIM(customer_id),
    customer_name = TRIM(customer_name),
    gender = TRIM(gender),
    city = TRIM(city),
    state = TRIM(state),
    signup_date = TRIM(signup_date),
    membership = TRIM(membership),
    age = TRIM(age);

-- Replace Blank Values With NULL
SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET customer_id = NULL
WHERE customer_id = '';

UPDATE customers
SET customer_name = NULL
WHERE customer_name = '';

UPDATE customers
SET gender = NULL
WHERE gender = '';

UPDATE customers
SET city = NULL
WHERE city = '';

UPDATE customers
SET state = NULL
WHERE state = '';

UPDATE customers
SET signup_date = NULL
WHERE signup_date = '';

UPDATE customers
SET membership = NULL
WHERE membership = '';

UPDATE customers
SET age = NULL
WHERE age = '';

-- Standardize Gender

UPDATE customers
SET gender = 'Male'
WHERE LOWER(gender) = 'male';

UPDATE customers
SET gender = 'Female'
WHERE LOWER(gender) = 'female';

-- Standardize City

UPDATE customers
SET city = CONCAT(UPPER(LEFT(city,1)),LOWER(SUBSTRING(city,2)))
WHERE city IS NOT NULL;

-- Standardize Membership

UPDATE customers
SET membership = 'Silver'
WHERE LOWER(membership) = 'silver';

UPDATE customers
SET membership = 'Gold'
WHERE LOWER(membership) = 'gold';

UPDATE customers
SET membership = 'Platinum'
WHERE LOWER(membership) = 'platinum';

-- Replace Invalid Age With NULL

UPDATE customers
SET age = NULL
WHERE age IS NOT NULL
AND age NOT REGEXP '^[0-9]+$';

-- Remove Duplicate Records

DELETE c1
FROM customers c1
JOIN customers c2
ON c1.customer_id = c2.customer_id
AND c1.customer_name = c2.customer_name
AND c1.gender = c2.gender
AND c1.city = c2.city
AND c1.state = c2.state
AND c1.signup_date = c2.signup_date
AND c1.membership = c2.membership
AND c1.age = c2.age
WHERE c1.customer_id > c2.customer_id;


-- 3.2 Products Table

-- Remove Leading & Trailing Spaces

UPDATE products
SET product_id = TRIM(product_id),
    product_name = TRIM(product_name),
    category = TRIM(category),
    brand = TRIM(brand),
    price = TRIM(price),
    stock_quantity = TRIM(stock_quantity),
    supplier = TRIM(supplier),
    rating = TRIM(rating);

-- Replace Blank Values With NULL

UPDATE products
SET product_id = NULL
WHERE product_id = '';

UPDATE products
SET product_name = NULL
WHERE product_name = '';

UPDATE products
SET category = NULL
WHERE category = '';

UPDATE products
SET brand = NULL
WHERE brand = '';

UPDATE products
SET price = NULL
WHERE price = '';

UPDATE products
SET stock_quantity = NULL
WHERE stock_quantity = '';

UPDATE products
SET supplier = NULL
WHERE supplier = '';

UPDATE products
SET rating = NULL
WHERE rating = '';

-- Standardize Category

UPDATE products
SET category = 'Electronics'
WHERE LOWER(category) IN ('electronics','electronic');

UPDATE products
SET category = 'Home'
WHERE LOWER(category) = 'home';

UPDATE products
SET category = 'Clothing'
WHERE LOWER(category) = 'clothing';

-- Standardize Brand

UPDATE products
SET brand = CONCAT(UPPER(LEFT(brand,1)),LOWER(SUBSTRING(brand,2)))
WHERE brand IS NOT NULL;

-- Replace Invalid Price With NULL

UPDATE products
SET price = NULL
WHERE price IS NOT NULL
AND price NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';

-- Replace Invalid Stock Quantity

UPDATE products
SET stock_quantity = NULL
WHERE stock_quantity IS NOT NULL
AND stock_quantity NOT REGEXP '^-?[0-9]+$';

-- Replace Invalid Rating

UPDATE products
SET rating = NULL
WHERE rating IS NOT NULL
AND rating NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';

-- Remove Duplicate Records

DELETE p1
FROM products p1
JOIN products p2
ON p1.product_id = p2.product_id
AND p1.product_name = p2.product_name
AND p1.category = p2.category
AND p1.brand = p2.brand
AND p1.price = p2.price
AND p1.stock_quantity = p2.stock_quantity
AND p1.supplier = p2.supplier
AND p1.rating = p2.rating
WHERE p1.product_id > p2.product_id;


-- 3.3 Orders Table

-- Remove Leading & Trailing Spaces

UPDATE orders
SET order_id = TRIM(order_id),
    customer_id = TRIM(customer_id),
    product_id = TRIM(product_id),
    order_date = TRIM(order_date),
    quantity = TRIM(quantity),
    discount = TRIM(discount),
    payment_method = TRIM(payment_method),
    order_status = TRIM(order_status);

-- Replace Blank Values With NULL

UPDATE orders
SET order_id = NULL
WHERE order_id = '';

UPDATE orders
SET customer_id = NULL
WHERE customer_id = '';

UPDATE orders
SET product_id = NULL
WHERE product_id = '';

UPDATE orders
SET order_date = NULL
WHERE order_date = '';

UPDATE orders
SET quantity = NULL
WHERE quantity = '';

UPDATE orders
SET discount = NULL
WHERE discount = '';

UPDATE orders
SET payment_method = NULL
WHERE payment_method = '';

UPDATE orders
SET order_status = NULL
WHERE order_status = '';

-- Standardize Payment Method

UPDATE orders
SET payment_method = 'UPI'
WHERE LOWER(payment_method) = 'upi';

UPDATE orders
SET payment_method = 'Cash'
WHERE LOWER(payment_method) = 'cash';

UPDATE orders
SET payment_method = 'Card'
WHERE LOWER(payment_method) = 'card';

-- Standardize Order Status

UPDATE orders
SET order_status = 'Delivered'
WHERE LOWER(order_status) = 'delivered';

UPDATE orders
SET order_status = 'Returned'
WHERE LOWER(order_status) = 'returned';

UPDATE orders
SET order_status = 'Cancelled'
WHERE LOWER(order_status) = 'cancelled';

UPDATE orders
SET order_status = 'Shipped'
WHERE LOWER(order_status) = 'shipped';

-- Remove % Symbol From Discount

UPDATE orders
SET discount = REPLACE(discount,'%','')
WHERE discount LIKE '%\%%';

-- Replace Invalid Discount With NULL

UPDATE orders
SET discount = NULL
WHERE discount IS NOT NULL
AND discount NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';

-- Replace Invalid Quantity With NULL

UPDATE orders
SET quantity = NULL
WHERE quantity IS NOT NULL
AND quantity NOT REGEXP '^-?[0-9]+$';

-- Remove Duplicate Records

DELETE o1
FROM orders o1
JOIN orders o2
ON o1.order_id = o2.order_id
AND o1.customer_id = o2.customer_id
AND o1.product_id = o2.product_id
AND o1.order_date = o2.order_date
AND o1.quantity = o2.quantity
AND o1.discount = o2.discount
AND o1.payment_method = o2.payment_method
AND o1.order_status = o2.order_status
WHERE o1.order_id > o2.order_id;