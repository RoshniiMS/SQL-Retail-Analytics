-- -----------------------------------------------------------
-- 05: DELIVERY PERFORMANCE ANALYSIS
-- Dataset: Target Brazil Retail
-- Schema: retail_analytics
-- Author: Roshni M S
-- -----------------------------------------------------------


-- ===========================================================
-- 1. DELIVERY TIME (DAYS)
-- Actual delivery date - purchase timestamp
-- ===========================================================

SELECT
  order_id,
  DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY)
    AS delivery_time_days
FROM `retail_analytics.orders`
WHERE order_delivered_customer_date IS NOT NULL;



-- ===========================================================
-- 2. DIFFERENCE BETWEEN ESTIMATED & ACTUAL DELIVERY
-- Positive → Late | Negative → Delivered earlier
-- ===========================================================

SELECT
  order_id,
  DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY)
    AS delivery_gap_days
FROM `retail_analytics.orders`
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;



-- ===========================================================
-- 3. KPI: AVERAGE DELIVERY TIME
-- ===========================================================

SELECT
  ROUND(
    AVG(
      DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY)
    ), 2
  ) AS avg_delivery_time_days
FROM `retail_analytics.orders`
WHERE order_delivered_customer_date IS NOT NULL;



-- ===========================================================
-- 4. KPI: LATE DELIVERY RATE (%)
-- ===========================================================

SELECT
  ROUND(
    100 * COUNTIF(order_delivered_customer_date > order_estimated_delivery_date) 
    / COUNT(order_id),
  2) AS late_delivery_rate_percent
FROM `retail_analytics.orders`
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;



-- ===========================================================
-- 5. KPI: AVG DELIVERY DELAY / EARLY DELIVERY (EST vs ACTUAL)
-- Positive = late | Negative = early
-- ===========================================================

SELECT
  ROUND(
    AVG(
      DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY)
    ),
  2) AS avg_delivery_gap_days
FROM `retail_analytics.orders`
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;



-- ===========================================================
-- 6. AVERAGE DELIVERY TIME BY STATE
-- ===========================================================

SELECT
  c.customer_state,
  ROUND(
    AVG(
      DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)
    ), 2
  ) AS avg_delivery_time_days
FROM `retail_analytics.orders` o
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_time_days DESC;



-- ===========================================================
-- 7. TOP 5 SLOWEST STATES (Highest avg delivery time)
-- ===========================================================

SELECT
  c.customer_state,
  ROUND(
    AVG(
      DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)
    ), 2
  ) AS avg_delivery_time_days
FROM `retail_analytics.orders` o
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY customer_state
ORDER BY avg_delivery_time_days DESC
LIMIT 5;



-- ===========================================================
-- 8. TOP 5 FASTEST STATES (Lowest avg delivery time)
-- ===========================================================

SELECT
  c.customer_state,
  ROUND(
    AVG(
      DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)
    ), 2
  ) AS avg_delivery_time_days
FROM `retail_analytics.orders` o
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY customer_state
ORDER BY avg_delivery_time_days ASC
LIMIT 5;



-- ===========================================================
-- 9. STATES WITH FASTEST DELIVERY COMPARED TO ESTIMATE
-- (Delivered earlier than estimated)
-- ===========================================================

SELECT
  c.customer_state,
  ROUND(
    AVG(
      DATE_DIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date, DAY)
    ), 2
  ) AS avg_delivery_gap_days
FROM `retail_analytics.orders` o
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_gap_days ASC  -- most early deliveries
LIMIT 5;



-- ===========================================================
-- 10. STATES WITH WORST DELAY (Most late deliveries)
-- ===========================================================

SELECT
  c.customer_state,
  ROUND(
    AVG(
      DATE_DIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date, DAY)
    ), 2
  ) AS avg_delivery_gap_days
FROM `retail_analytics.orders` o
JOIN `retail_analytics.customers` c
  ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_gap_days DESC
LIMIT 5;
