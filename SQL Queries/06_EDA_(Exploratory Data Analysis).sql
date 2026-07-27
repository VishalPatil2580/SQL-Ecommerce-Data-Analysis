-- Phase 6 : Exploratory Data Analysis (EDA)

USE ecommerce_analysis;

-- 6.1 Dataset Overview

-- Total Customers

SELECT COUNT(*) AS Total_Customers
FROM customers;

-- Total Products

SELECT COUNT(*) AS Total_Products
FROM products;

-- Total Orders

SELECT COUNT(*) AS Total_Orders
FROM orders;

-- 6.2 Customer Analysis

-- Customers by Gender

SELECT
gender,
COUNT(*) AS Total_Customers
FROM customers
GROUP BY gender
ORDER BY Total_Customers DESC;

-- Customers by Membership

SELECT
    membership,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY membership
ORDER BY CASE
    WHEN membership = 'Gold' THEN 1
    WHEN membership = 'Silver' THEN 2
    WHEN membership = 'Platinum' THEN 3
    WHEN membership = 'None' THEN 4
END;

-- Customers by State

SELECT
state,
COUNT(*) AS Total_Customers
FROM customers
GROUP BY state
ORDER BY Total_Customers DESC;


-- Customers by City

SELECT
city,
COUNT(*) AS Total_Customers
FROM customers
GROUP BY city
ORDER BY Total_Customers DESC;

-- Average Customer Age

SELECT
ROUND(AVG(age),2) AS Average_Age
FROM customers;

-- Youngest Customer

SELECT MIN(age) AS Youngest_Customer
FROM customers;

-- Oldest Customer

SELECT MAX(age) AS Oldest_Customer
FROM customers;


-- 6.3 Product Analysis

-- Products by Category

SELECT
category,
COUNT(*) AS Total_Products
FROM products
GROUP BY category
ORDER BY Total_Products DESC;

-- Products by Brand

SELECT
brand,
COUNT(*) AS Total_Products
FROM products
GROUP BY brand
ORDER BY Total_Products DESC;

-- Average Product Price

SELECT
ROUND(AVG(price),2) AS Average_Price
FROM products;

-- Most Expensive Product

SELECT *
FROM products
ORDER BY price DESC
LIMIT 1;


-- Cheapest Product

SELECT *
FROM products
ORDER BY price ASC
LIMIT 1;

-- Average Product Rating

SELECT
ROUND(AVG(rating),2) AS Average_Rating
FROM products;

-- Lowest Stock Products

SELECT
product_id,
product_name,
stock_quantity
FROM products
ORDER BY stock_quantity ASC
LIMIT 10;


-- 6.4 Order Analysis

-- Orders by Status

SELECT
order_status,
COUNT(*) AS Total_Orders
FROM orders
GROUP BY order_status
ORDER BY Total_Orders DESC;

-- Orders by Payment Method

SELECT
payment_method,
COUNT(*) AS Total_Orders
FROM orders
GROUP BY payment_method
ORDER BY Total_Orders DESC;


-- Average Discount

SELECT
ROUND(AVG(discount),2) AS Average_Discount
FROM orders;

SELECT * FROM orders ORDER BY discount DESC LIMIT 100;
-- Average Quantity Ordered

SELECT
ROUND(AVG(quantity),2) AS Average_Quantity
FROM orders;

SELECT *FROM orders ORDER BY quantity;

-- Highest Discount

SELECT MAX(discount) AS Highest_Discount
FROM orders;

-- Lowest Discount

SELECT MIN(discount) AS Lowest_Discount
FROM orders;


-- 6.5 Customer & Order Analysis

-- Customers with Highest Number of Orders

SELECT
o.customer_id,
c.customer_name,
COUNT(o.order_id) AS Total_Orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY
o.customer_id,
c.customer_name
ORDER BY Total_Orders DESC
LIMIT 10;

-- Customers Without Orders

SELECT
c.customer_id,
c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- 6.6 Product & Order Analysis

-- Most Ordered Products

SELECT
o.product_id,
p.product_name,
COUNT(*) AS Total_Orders
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY
o.product_id,
p.product_name
ORDER BY Total_Orders DESC
LIMIT 10;

-- Least Ordered Products

SELECT
o.product_id,
p.product_name,
COUNT(*) AS Total_Orders
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY
o.product_id,
p.product_name
ORDER BY Total_Orders ASC
LIMIT 10;

-- Products Never Ordered

SELECT
p.product_id,
p.product_name
FROM products p
LEFT JOIN orders o
ON p.product_id = o.product_id
WHERE o.order_id IS NULL;


-- 6.7 Date Analysis

-- Orders by Year

SELECT
YEAR(order_date) AS Order_Year,
COUNT(*) AS Total_Orders
FROM orders
GROUP BY YEAR(order_date)
ORDER BY Order_Year;

-- Orders by Month

SELECT
MONTHNAME(order_date) AS Order_Month,
COUNT(*) AS Total_Orders
FROM orders
GROUP BY
MONTH(order_date),
MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- Orders by Day of Week

SELECT
DAYNAME(order_date) AS Day_Name,
COUNT(*) AS Total_Orders
FROM orders
GROUP BY DAYNAME(order_date)
ORDER BY Total_Orders DESC;