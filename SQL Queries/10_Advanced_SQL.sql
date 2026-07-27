-- Advanced SQL

USE ecommerce_analysis;

-- 1. Common Table Expressions (CTE)

-- Top 10 Customers by Revenue

WITH customer_revenue AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(net_revenue) AS total_revenue
    FROM sales_summary
    GROUP BY
        customer_id,
        customer_name
)
SELECT *
FROM customer_revenue
ORDER BY total_revenue DESC
LIMIT 10;

-- Monthly Revenue

WITH monthly_sales AS
(
    SELECT
        YEAR(order_date) AS sales_year,
        MONTHNAME(order_date) AS sales_month,
        SUM(net_revenue) AS total_revenue
    FROM sales_summary
    GROUP BY
        YEAR(order_date),
        MONTH(order_date),
        MONTHNAME(order_date)
)
SELECT *
FROM monthly_sales
ORDER BY sales_year, MONTH(STR_TO_DATE(sales_month,'%M'));


-- 2. ROW_NUMBER()

-- Assign Row Number to Products by Revenue

SELECT
    product_name,
    SUM(net_revenue) AS revenue,
    ROW_NUMBER() OVER(
        ORDER BY SUM(net_revenue) DESC
    ) AS `row_number`
FROM sales_summary
GROUP BY product_name;

-- 3. RANK()

SELECT
    customer_name,
    SUM(net_revenue) AS revenue,
    RANK() OVER(
        ORDER BY SUM(net_revenue) DESC
    ) AS customer_rank
FROM sales_summary
GROUP BY customer_name;

-- 4. DENSE_RANK()

SELECT
    category,
    SUM(net_revenue) AS revenue,
    DENSE_RANK() OVER(
        ORDER BY SUM(net_revenue) DESC
    ) AS category_rank
FROM sales_summary
GROUP BY category;


-- 5. NTILE()

-- Divide Customers into 4 Revenue Groups

SELECT
    customer_name,
    SUM(net_revenue) AS revenue,
    NTILE(4) OVER(
        ORDER BY SUM(net_revenue) DESC
    ) AS revenue_group
FROM sales_summary
GROUP BY customer_name;


-- 6. LAG()

-- Compare Monthly Revenue with Previous Month

WITH monthly_sales AS
(
SELECT
YEAR(order_date) AS sales_year,
MONTH(order_date) AS sales_month,
SUM(net_revenue) AS revenue
FROM sales_summary
GROUP BY
YEAR(order_date),
MONTH(order_date)
)
SELECT
sales_year,
sales_month,
revenue,
LAG(revenue) OVER(
ORDER BY sales_year,sales_month
) AS previous_month_revenue
FROM monthly_sales;


-- 7. LEAD()

-- Compare Monthly Revenue with Next Month

WITH monthly_sales AS
(
SELECT
YEAR(order_date) AS sales_year,
MONTH(order_date) AS sales_month,
SUM(net_revenue) AS revenue
FROM sales_summary
GROUP BY
YEAR(order_date),
MONTH(order_date)
)
SELECT
sales_year,
sales_month,
revenue,
LEAD(revenue) OVER(
ORDER BY sales_year,sales_month
) AS next_month_revenue
FROM monthly_sales;


-- 8. Running Total

WITH monthly_sales AS
(
SELECT
YEAR(order_date) AS sales_year,
MONTH(order_date) AS sales_month,
SUM(net_revenue) AS revenue
FROM sales_summary
GROUP BY
YEAR(order_date),
MONTH(order_date)
)
SELECT
sales_year,
sales_month,
revenue,
SUM(revenue)
OVER(
ORDER BY sales_year,sales_month
) AS running_total
FROM monthly_sales;


-- 9. Moving Average

WITH monthly_sales AS
(
SELECT
YEAR(order_date) AS sales_year,
MONTH(order_date) AS sales_month,
SUM(net_revenue) AS revenue
FROM sales_summary
GROUP BY
YEAR(order_date),
MONTH(order_date)
)
SELECT
sales_year,
sales_month,
revenue,
ROUND(AVG(revenue)
OVER(
ORDER BY sales_year,sales_month
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
),2) AS moving_average
FROM monthly_sales;


-- 10. Subquery

-- Products Generating Above Average Revenue

SELECT
product_name,
SUM(net_revenue) AS revenue
FROM sales_summary
GROUP BY product_name
HAVING revenue >
(
SELECT
AVG(total_revenue)
FROM product_sales
);


-- 11. Correlated Subquery

-- Customers Spending More Than Average Revenue of Their Membership

SELECT *
FROM customer_sales c
WHERE total_revenue >
(
SELECT
AVG(total_revenue)
FROM customer_sales
WHERE membership = c.membership
);


-- 12. CASE Statement

SELECT
customer_name,
total_revenue,
CASE
WHEN total_revenue >= 10000 THEN 'High Value'
WHEN total_revenue >= 5000 THEN 'Medium Value'
ELSE 'Low Value'
END AS customer_segment
FROM customer_sales;


-- 13. EXISTS

SELECT *
FROM customers c
WHERE EXISTS
(
SELECT 1
FROM orders o
WHERE c.customer_id = o.customer_id
);


-- 14. NOT EXISTS

SELECT *
FROM customers c
WHERE NOT EXISTS
(
SELECT 1
FROM orders o
WHERE c.customer_id = o.customer_id
);


-- 15. Temporary Table

CREATE TEMPORARY TABLE temp_top_products AS
SELECT
product_id,
product_name,
SUM(net_revenue) AS revenue
FROM sales_summary
GROUP BY
product_id,
product_name;

SELECT *
FROM temp_top_products
ORDER BY revenue DESC
LIMIT 10;