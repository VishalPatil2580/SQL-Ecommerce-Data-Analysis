-- Business Reporting

USE ecommerce_analysis;

-- Report 1 : Executive Sales Summary

SELECT
    COUNT(DISTINCT customer_id) AS Total_Customers,
    COUNT(DISTINCT product_id) AS Total_Products,
    COUNT(DISTINCT order_id) AS Total_Orders,
    SUM(quantity) AS Total_Quantity_Sold,
    ROUND(SUM(revenue),2) AS Gross_Revenue,
    ROUND(SUM(discount_amount),2) AS Total_Discount,
    ROUND(SUM(net_revenue),2) AS Net_Revenue,
    ROUND(AVG(net_revenue),2) AS Average_Order_Value
FROM sales_summary;


-- Report 2 : Monthly Sales Performance

SELECT
    sales_year,
    month_name,
    total_orders,
    total_quantity,
    revenue,
    discount_amount,
    net_revenue
FROM monthly_sales
ORDER BY sales_year, sales_month;


-- Report 3 : State Performance Report

SELECT
    state,
    total_orders,
    total_quantity,
    total_revenue
FROM state_sales
ORDER BY total_revenue DESC;


-- Report 4 : Category Performance Report

SELECT
    category,
    total_orders,
    total_quantity,
    total_revenue
FROM category_sales
ORDER BY total_revenue DESC;


-- Report 5 : Customer Performance Report

SELECT
    customer_id,
    customer_name,
    city,
    state,
    membership,
    total_orders,
    total_quantity,
    total_revenue
FROM customer_sales
ORDER BY total_revenue DESC
LIMIT 20;


-- Report 6 : Product Performance Report

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
LIMIT 20;


-- Report 7 : Payment Method Performance

SELECT
    payment_method,
    total_orders,
    total_revenue
FROM payment_summary
ORDER BY total_revenue DESC;


-- Report 8 : Order Status Report

SELECT
    order_status,
    total_orders,
    total_revenue
FROM order_status_summary
ORDER BY total_revenue DESC;


-- Report 9 : Top 10 Customers

SELECT
    customer_id,
    customer_name,
    total_orders,
    total_quantity,
    total_revenue
FROM customer_sales
ORDER BY total_revenue DESC
LIMIT 10;


-- Report 10 : Top 10 Products

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


-- Report 11 : Bottom 10 Products

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


-- Report 12 : Membership Performance
SELECT
    membership,
    COUNT(order_id) AS Total_Orders,
    SUM(quantity) AS Total_Quantity,
    ROUND(SUM(net_revenue),2) AS Total_Revenue
FROM sales_summary
GROUP BY membership
ORDER BY Total_Revenue DESC;


-- Report 13 : Discount Performance

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


-- Report 14 : Inventory Report

SELECT
    product_id,
    product_name,
    category,
    brand,
    stock_quantity,
    rating
FROM products
ORDER BY stock_quantity ASC;


-- Report 15 : Business Health Dashboard

SELECT
COUNT(DISTINCT customer_id) AS Customers,
COUNT(DISTINCT order_id) AS Orders,
COUNT(DISTINCT product_id) AS Products,
SUM(quantity) AS Quantity_Sold,
ROUND(SUM(net_revenue),2) AS Net_Revenue,
ROUND(AVG(net_revenue),2) AS Avg_Order_Value,
ROUND(AVG(discount),2) AS Avg_Discount
FROM sales_summary;