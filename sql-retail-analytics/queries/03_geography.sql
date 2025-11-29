-- -----------------------------------------------------------
-- 03: GEOGRAPHIC ANALYSIS (STATE & CITY LEVEL)
-- Dataset: Target Brazil Retail
-- Schema: retail_analytics
-- Author: Roshni M S
-- -----------------------------------------------------------


-- ===========================================================
-- 1. CUSTOMER DISTRIBUTION BY STATE
-- ===========================================================

SELECT
  customer_state,
  COUNT(DISTINCT customer_id) AS total_customers
FROM `retail_analytics.customers`
GROUP BY customer_state
ORDER BY total_customers DESC;


-- ===========================================================
-- 2. CUSTOMER DISTRIBUTION BY CITY (top 20)
-- ===========================================================

SELECT
  customer_city,
  COUNT(DISTINCT customer_id) AS total_customers
FROM `retail_analytics.customers`
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 20;


-- ===========================================================
-- 3. MONTH-ON-MONTH ORDERS BY STATE
-- ===========================================================

SELECT
  c.customer_state,
  FORMAT_TIMESTAMP('%Y-%m', o.order_purchase_timestamp) AS year_month,
  COUNT(o.order_id) AS total_orders
FROM `retail_analytics.orders` o
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
GROUP BY customer_state, year_month
ORDER BY customer_state, year_month;


-- ===========================================================
-- 4. TOTAL ORDERS BY STATE
-- ===========================================================

SELECT
  c.customer_state,
  COUNT(o.order_id) AS total_orders
FROM `retail_analytics.orders` o
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;


-- ===========================================================
-- 5. FREIGHT COST BY STATE (Total & Average)
-- ===========================================================

SELECT
  c.customer_state,
  ROUND(SUM(oi.freight_value), 2) AS total_freight,
  ROUND(AVG(oi.freight_value), 2) AS avg_freight
FROM `retail_analytics.order_items` oi
JOIN `retail_analytics.orders` o
  ON oi.order_id = o.order_id
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY avg_freight DESC;


-- ===========================================================
-- 6. TOTAL ORDER VALUE BY STATE (Price)
-- ===========================================================

SELECT
  c.customer_state,
  ROUND(SUM(oi.price), 2) AS total_price,
  ROUND(AVG(oi.price), 2) AS avg_price
FROM `retail_analytics.order_items` oi
JOIN `retail_analytics.orders` o
  ON oi.order_id = o.order_id
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY total_price DESC;


-- ===========================================================
-- 7. TOP 3 PRODUCT CATEGORIES PER STATE 
-- ===========================================================

WITH category_sales AS (
  SELECT
    c.customer_state,
    p.`product category` AS product_category,
    COUNT(oi.product_id) AS total_items_sold
  FROM `retail_analytics.order_items` oi
  JOIN `retail_analytics.orders` o
    ON oi.order_id = o.order_id
  JOIN `retail_analytics.customers` c
    ON o.customer_id = c.customer_id
  JOIN `retail_analytics.products` p
    ON oi.product_id = p.product_id
  GROUP BY customer_state, product_category
),

ranked_categories AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY customer_state
      ORDER BY total_items_sold DESC
    ) AS rank_in_state
  FROM category_sales
)

SELECT
  customer_state,
  product_category,
  total_items_sold
FROM ranked_categories
WHERE rank_in_state <= 3
ORDER BY customer_state, total_items_sold DESC;
