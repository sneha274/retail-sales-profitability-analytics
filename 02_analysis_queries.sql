-- 02_analysis_queries.sql
-- Core business questions for Retail Sales & Profitability Analytics

-- Q1: Profit by Category
SELECT category,
       ROUND(SUM(sales), 2)  AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(profit) * 1.0 / SUM(sales), 4) AS overall_margin
FROM orders_clean
GROUP BY category
ORDER BY total_profit DESC;

-- Q2: Profit by Sub-Category (find the losers)
SELECT category, sub_category,
       ROUND(SUM(sales), 2)  AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(profit) * 1.0 / SUM(sales), 4) AS overall_margin
FROM orders_clean
GROUP BY category, sub_category
ORDER BY total_profit ASC;

-- Q3: Does discount level hurt profit? (bucket discounts)
SELECT
    CASE
        WHEN discount = 0 THEN '0%'
        WHEN discount <= 0.2 THEN '1-20%'
        WHEN discount <= 0.4 THEN '21-40%'
        WHEN discount <= 0.6 THEN '41-60%'
        ELSE '60%+'
    END AS discount_bucket,
    COUNT(*) AS orders,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS avg_profit_per_order,
    ROUND(SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_unprofitable_orders
FROM orders_clean
GROUP BY discount_bucket
ORDER BY discount_bucket;

-- Q4: Profit margin by Region
SELECT region,
       ROUND(SUM(sales), 2)  AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(profit) * 1.0 / SUM(sales), 4) AS overall_margin
FROM orders_clean
GROUP BY region
ORDER BY total_profit DESC;

-- Q5: Top 10 most profitable products
SELECT product_name, category,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit
FROM orders_clean
GROUP BY product_name, category
ORDER BY total_profit DESC
LIMIT 10;

-- Q6: Bottom 10 least profitable (worst loss-making) products
SELECT product_name, category,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit
FROM orders_clean
GROUP BY product_name, category
ORDER BY total_profit ASC
LIMIT 10;

-- Q7: Monthly sales trend
SELECT strftime('%Y-%m', order_date) AS year_month,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit
FROM orders_clean
GROUP BY year_month
ORDER BY year_month;

-- Q9: Root cause of Supplies losses (specific losing products)
SELECT product_name,
       ROUND(SUM(sales), 2)  AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(AVG(discount), 3) AS avg_discount,
       COUNT(*) AS num_orders
FROM orders_clean
WHERE sub_category = 'Supplies'
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 8;

-- Q8: Customer segment profitability
SELECT segment,
       COUNT(DISTINCT customer_id) AS num_customers,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(profit) * 1.0 / SUM(sales), 4) AS overall_margin
FROM orders_clean
GROUP BY segment
ORDER BY total_profit DESC;
