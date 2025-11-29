-- -----------------------------------------------------------
-- 04: ECONOMIC ANALYSIS (COST, REVENUE, FREIGHT)
-- Dataset: Target Brazil Retail
-- Schema: retail_analytics
-- Author: Roshni M S
-- -----------------------------------------------------------


-- ===========================================================
-- 1. % Increase in Order Cost (Jan–Aug 2017 vs Jan–Aug 2018)
-- Using payment_value as total order cost
-- ===========================================================

WITH revenue_by_year AS (
  SELECT
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS yr,
    SUM(p.payment_value) AS total_revenue
  FROM `retail_analytics.orders` o
  JOIN `retail_analytics.payments` p
    ON o.order_id = p.order_id
  WHERE EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
  GROUP BY yr
)

SELECT
  ( (SELECT total_revenue FROM revenue_by_year WHERE yr = 2018) -
    (SELECT total_revenue FROM revenue_by_year WHERE yr = 2017) )
    / (SELECT total_revenue FROM revenue_by_year WHERE yr = 2017)
    * 100
    AS percent_increase_cost_Jan_to_Aug;
    


-- ===========================================================
-- 2. TOTAL & AVERAGE ORDER PRICE PER STATE
-- Uses price column from order_items
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
GROUP BY c.customer_state
ORDER BY total_price DESC;



-- ===========================================================
-- 3. TOTAL & AVERAGE FREIGHT VALUE PER STATE
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
GROUP BY c.customer_state
ORDER BY avg_freight DESC;



-- ===========================================================
-- 4. TOTAL REVENUE BY STATE 
-- ===========================================================

SELECT
  c.customer_state,
  ROUND(SUM(p.payment_value), 2) AS total_revenue_state
FROM `retail_analytics.payments` p
JOIN `retail_analytics.orders` o
  ON p.order_id = o.order_id
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue_state DESC;



-- ===========================================================
-- 5. AVG PAYMENT VALUE BY PAYMENT METHOD (Economic Behavior)
-- ===========================================================

SELECT
  payment_type,
  ROUND(AVG(payment_value), 2) AS avg_spend
FROM `retail_analytics.payments`
GROUP BY payment_type
ORDER BY avg_spend DESC;



-- ===========================================================
-- 6. REVENUE CONTRIBUTION BY PAYMENT TYPE
-- ===========================================================

SELECT
  payment_type,
  ROUND(SUM(payment_value), 2) AS total_revenue,
  ROUND(100 * SUM(payment_value) / SUM(SUM(payment_value)) OVER(), 2) AS percent_contribution
FROM `retail_analytics.payments`
GROUP BY payment_type
ORDER BY percent_contribution DESC;
