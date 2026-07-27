-- KPI Analysis

USE ecommerce_analysis;

-- 1. Overall Business KPIs

-- Total Customers

SELECT COUNT(*) AS Total_Customers
FROM customers;

-- Total Products

SELECT COUNT(*) AS Total_Products
FROM products;

-- Total Orders

SELECT COUNT(*) AS Total_Orders
FROM orders;

-- Total Quantity Sold

SELECT SUM(quantity) AS Total_Quantity_Sold
FROM orders;

-- Total Revenue (Before Discount)

SELECT
ROUND(SUM(price * quantity),2) AS Total_Revenue
FROM sales_summary;

-- Total Discount Amount

SELECT
ROUND(SUM(discount_amount),2) AS Total_Discount
FROM sales_summary;

-- Net Revenue

SELECT
ROUND(SUM(net_revenue),2) AS Net_Revenue
FROM sales_summary;

-- Average Order Value

SELECT
ROUND(AVG(net_revenue),2) AS Average_Order_Value
FROM sales_summary;


-- 2. Monthly KPI Analysis

SELECT
sales_year,
month_name,
SUM(total_orders) AS Total_Orders,
SUM(total_quantity) AS Total_Quantity,
ROUND(SUM(revenue),2) AS Revenue,
ROUND(SUM(net_revenue),2) AS Net_Revenue
FROM monthly_sales
GROUP BY
sales_year,
month_name,
sales_month
ORDER BY
sales_year,
sales_month;


-- 3. Category KPI Analysis

SELECT
category,
SUM(total_orders) AS Total_Orders,
SUM(total_quantity) AS Total_Quantity,
ROUND(SUM(total_revenue),2) AS Revenue
FROM category_sales
GROUP BY category
ORDER BY Revenue DESC;


-- 4. Customer KPI Analysis

-- Top 10 Customers by Revenue

SELECT
customer_id,
customer_name,
total_orders,
total_quantity,
total_revenue
FROM customer_sales
ORDER BY total_revenue DESC
LIMIT 10;

-- Bottom 10 Customers by Revenue

SELECT
customer_id,
customer_name,
total_orders,
total_quantity,
total_revenue
FROM customer_sales
ORDER BY total_revenue
LIMIT 10;


-- 5. Product KPI Analysis

-- Top 10 Products by Revenue

SELECT
product_id,
product_name,
category,
brand,
total_orders,
total_quantity,
total_revenue
FROM product_sales
ORDER BY total_revenue DESC
LIMIT 10;

-- Bottom 10 Products by Revenue

SELECT
product_id,
product_name,
category,
brand,
total_orders,
total_quantity,
total_revenue
FROM product_sales
ORDER BY total_revenue
LIMIT 10;


-- 6. State KPI Analysis

SELECT
state,
total_orders,
total_quantity,
total_revenue
FROM state_sales
ORDER BY total_revenue DESC;


-- 7. Payment Method KPI Analysis

SELECT
payment_method,
total_orders,
total_revenue
FROM payment_summary
ORDER BY total_revenue DESC;


-- 8. Order Status KPI Analysis

SELECT
order_status,
total_orders,
total_revenue
FROM order_status_summary
ORDER BY total_revenue DESC;


-- 9. Discount KPI Analysis

SELECT
CASE
    WHEN discount = 0 THEN 'No Discount'
    WHEN discount BETWEEN 1 AND 10 THEN '1-10%'
    WHEN discount BETWEEN 11 AND 20 THEN '11-20%'
    ELSE 'Above 20%'
END AS Discount_Group,

COUNT(order_id) AS Total_Orders,
ROUND(SUM(net_revenue),2) AS Total_Revenue,
ROUND(AVG(net_revenue),2) AS Average_Order_Value
FROM sales_summary
GROUP BY Discount_Group
ORDER BY Total_Revenue DESC;


-- 10. Membership KPI Analysis

SELECT
membership,
COUNT(order_id) AS Total_Orders,
SUM(quantity) AS Total_Quantity,
ROUND(SUM(net_revenue),2) AS Total_Revenue
FROM sales_summary
GROUP BY membership
ORDER BY Total_Revenue DESC;