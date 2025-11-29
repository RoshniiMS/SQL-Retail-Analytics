-- -----------------------------------------------------------
-- 02: TIME-BASED TRENDS & SEASONALITY
-- Dataset: Target Brazil Retail
-- Schema: retail_analytics
-- Author: Roshni M S
-- -----------------------------------------------------------


-- ===========================================================
-- 1. YEARLY NUMBER OF ORDERS (Trend Analysis)
-- ===========================================================

SELECT
  EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
  COUNT(order_id) AS total_orders
FROM `retail_analytics.orders`
GROUP BY order_year
ORDER BY order_year;


-- ===========================================================
-- 2. MONTHLY NUMBER OF ORDERS (Seasonality)
-- ===========================================================

SELECT
  EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
  EXTRACT(MONTH FROM order_purchase_timestamp) AS order_month,
  COUNT(order_id) AS total_orders
FROM `retail_analytics.orders`
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


-- ===========================================================
-- 3. ORDERS BY MONTH (Aggregated Month Name)
-- ===========================================================

SELECT
  FORMAT_TIMESTAMP('%Y-%m', order_purchase_timestamp) AS year_month,
  COUNT(order_id) AS total_orders
FROM `retail_analytics.orders`
GROUP BY year_month
ORDER BY year_month;


-- ===========================================================
-- 4. TIME-OF-DAY ORDER DISTRIBUTION
-- Buckets: Dawn(0–6), Morning(7–12), Afternoon(13–18), Night(19–23)
-- ===========================================================

SELECT
  CASE 
    WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 0 AND 6 THEN 'Dawn'
    WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 7 AND 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 13 AND 18 THEN 'Afternoon'
    ELSE 'Night'
  END AS time_of_day,
  COUNT(order_id) AS total_orders
FROM `retail_analytics.orders`
GROUP BY time_of_day
ORDER BY total_orders DESC;


-- ===========================================================
-- 5. ORDERS BY WEEKDAY 
-- ===========================================================

SELECT
  FORMAT_TIMESTAMP('%A', order_purchase_timestamp) AS weekday,
  COUNT(order_id) AS total_orders
FROM `retail_analytics.orders`
GROUP BY weekday
ORDER BY total_orders DESC;


