-- Sales Summary Views

USE ecommerce_analysis;

-- 1. Sales Summary View

CREATE VIEW sales_summary AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.customer_name,
    c.city,
    c.state,
    c.membership,
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    o.quantity,
    p.price,
    o.discount,
    (p.price * o.quantity) AS revenue,
    ROUND((p.price * o.quantity) * (o.discount / 100),2) AS discount_amount,
    ROUND((p.price * o.quantity) * (1 - o.discount / 100),2) AS net_revenue,
    o.payment_method,
    o.order_status
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN products p
ON o.product_id = p.product_id;

SELECT * FROM sales_summary;


-- 2. Monthly Sales Summary View

CREATE VIEW monthly_sales AS
SELECT
    YEAR(order_date) AS sales_year,
    MONTH(order_date) AS sales_month,
    MONTHNAME(order_date) AS month_name,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(price * quantity),2) AS revenue,
    ROUND(SUM((price * quantity) * (discount / 100)),2) AS discount_amount,
    ROUND(SUM((price * quantity) * (1 - discount / 100)),2) AS net_revenue
FROM sales_summary
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    MONTHNAME(order_date);

SELECT *
FROM monthly_sales
ORDER BY sales_year, sales_month;


-- 3. Customer Sales Summary View

CREATE VIEW customer_sales AS
SELECT
    customer_id,
    customer_name,
    city,
    state,
    membership,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(net_revenue),2) AS total_revenue
FROM sales_summary
GROUP BY
    customer_id,
    customer_name,
    city,
    state,
    membership;

SELECT *
FROM customer_sales;


-- 4. Product Sales Summary View

CREATE VIEW product_sales AS
SELECT
    product_id,
    product_name,
    category,
    brand,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(net_revenue),2) AS total_revenue
FROM sales_summary
GROUP BY
    product_id,
    product_name,
    category,
    brand;

SELECT *
FROM product_sales;


-- 5. Category Sales Summary View

CREATE VIEW category_sales AS
SELECT
    category,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(net_revenue),2) AS total_revenue
FROM sales_summary
GROUP BY category;

SELECT *
FROM category_sales;


-- 6. State Sales Summary View

CREATE VIEW state_sales AS
SELECT
    state,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(net_revenue),2) AS total_revenue
FROM sales_summary
GROUP BY state;

SELECT *
FROM state_sales;


-- 7. Payment Method Summary View

CREATE VIEW payment_summary AS
SELECT
    payment_method,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(net_revenue),2) AS total_revenue
FROM sales_summary
GROUP BY payment_method;

SELECT *
FROM payment_summary;


-- 8. Order Status Summary View

CREATE VIEW order_status_summary AS
SELECT
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(net_revenue),2) AS total_revenue
FROM sales_summary
GROUP BY order_status;

SELECT *
FROM order_status_summary;