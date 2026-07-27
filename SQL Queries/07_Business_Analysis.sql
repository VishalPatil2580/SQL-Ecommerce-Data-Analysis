-- Business Analysis

USE ecommerce_analysis;

-- 1. Customer Analysis

-- Total Customers by Gender

SELECT
    gender,
    COUNT(*) AS total_customers
FROM customers
GROUP BY gender
ORDER BY total_customers DESC;

-- Total Customers by Membership

SELECT
    membership,
    COUNT(*) AS total_customers
FROM customers
GROUP BY membership
ORDER BY total_customers DESC;

-- Total Customers by State

SELECT
    state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC;

-- Top 10 Cities with Highest Customers

SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC
LIMIT 10;

-- Customer Age Distribution

SELECT
    CASE
		WHEN age BETWEEN 0 AND 17 THEN '0-17'
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_customers
FROM customers
GROUP BY age_group
ORDER BY age_group;


-- 2. Product Analysis

-- Total Products by Category

SELECT
    category,
    COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;

-- Total Products by Brand

SELECT
    brand,
    COUNT(*) AS total_products
FROM products
GROUP BY brand
ORDER BY total_products DESC;

-- Products by Supplier

SELECT
    supplier,
    COUNT(*) AS total_products
FROM products
GROUP BY supplier
ORDER BY total_products DESC;

-- Average Product Price by Category

SELECT
    category,
    ROUND(AVG(price),2) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;

-- Average Rating by Category

SELECT
    category,
    ROUND(AVG(rating),2) AS average_rating
FROM products
GROUP BY category
ORDER BY average_rating DESC;

-- Products with Lowest Stock

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
ORDER BY stock_quantity
LIMIT 10;


-- 3. Order Analysis

-- Orders by Status

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Orders by Payment Method

SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- Orders by Year

SELECT
    YEAR(order_date) AS order_year,
    COUNT(*) AS total_orders
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;

-- Orders by Month

SELECT
    MONTHNAME(order_date) AS month_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);


-- 4. Customer Purchase Analysis

-- Customers with Highest Number of Orders

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC
LIMIT 10;

-- Customers Who Never Placed Any Order

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- 5. Product Sales Analysis

-- Top 10 Most Ordered Products

SELECT
    p.product_id,
    p.product_name,
    SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- Bottom 10 Least Ordered Products

SELECT
    p.product_id,
    p.product_name,
    SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity
LIMIT 10;

-- Products Never Ordered

SELECT
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN orders o
ON p.product_id = o.product_id
WHERE o.product_id IS NULL;


-- 6. Customer & Product Relationship

-- Top 10 Customers Purchasing Highest Quantity

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.quantity) AS total_quantity
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_quantity DESC
LIMIT 10;

-- Most Purchased Category

SELECT
    p.category,
    SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_quantity DESC;

-- Most Purchased Brand

SELECT
    p.brand,
    SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.brand
ORDER BY total_quantity DESC;