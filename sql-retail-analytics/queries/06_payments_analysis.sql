-- -----------------------------------------------------------
-- 06: PAYMENTS ANALYSIS
-- Dataset: Target Brazil Retail
-- Schema: retail_analytics
-- Author: Roshni M S
-- -----------------------------------------------------------


-- ===========================================================
-- 1. MONTH-ON-MONTH ORDERS BY PAYMENT TYPE
-- ===========================================================

SELECT
  FORMAT_TIMESTAMP('%Y-%m', o.order_purchase_timestamp) AS year_month,
  p.payment_type,
  COUNT(DISTINCT p.order_id) AS total_orders
FROM `retail_analytics.payments` p
JOIN `retail_analytics.orders` o
  ON p.order_id = o.order_id
GROUP BY year_month, payment_type
ORDER BY year_month, total_orders DESC;



-- ===========================================================
-- 2. TOTAL ORDERS BY PAYMENT TYPE
-- ===========================================================

SELECT
  payment_type,
  COUNT(DISTINCT order_id) AS total_orders
FROM `retail_analytics.payments`
GROUP BY payment_type
ORDER BY total_orders DESC;



-- ===========================================================
-- 3. TOTAL REVENUE BY PAYMENT TYPE
-- ===========================================================

SELECT
  payment_type,
  ROUND(SUM(payment_value), 2) AS total_revenue
FROM `retail_analytics.payments`
GROUP BY payment_type
ORDER BY total_revenue DESC;



-- ===========================================================
-- 4. AVERAGE PAYMENT VALUE BY PAYMENT TYPE
-- ===========================================================

SELECT
  payment_type,
  ROUND(AVG(payment_value), 2) AS avg_payment_value
FROM `retail_analytics.payments`
GROUP BY payment_type
ORDER BY avg_payment_value DESC;



-- ===========================================================
-- 5. PAYMENT INSTALLMENTS ANALYSIS (EMI patterns)
-- ===========================================================

SELECT
  payment_installments,
  COUNT(order_id) AS total_orders
FROM `retail_analytics.payments`
GROUP BY payment_installments
ORDER BY payment_installments;



-- ===========================================================
-- 6. AVERAGE ORDER VALUE BY NUMBER OF INSTALLMENTS
-- ===========================================================

SELECT
  payment_installments,
  ROUND(AVG(payment_value), 2) AS avg_payment_value
FROM `retail_analytics.payments`
GROUP BY payment_installments
ORDER BY payment_installments;



-- ===========================================================
-- 7. PAYMENT TYPE CONTRIBUTION (%)
-- ===========================================================

SELECT
  payment_type,
  ROUND(SUM(payment_value), 2) AS total_revenue,
  ROUND(
    100 * SUM(payment_value) / SUM(SUM(payment_value)) OVER(),
  2) AS percent_contribution
FROM `retail_analytics.payments`
GROUP BY payment_type
ORDER BY percent_contribution DESC;



-- ===========================================================
-- 8. PAYMENT SUCCESS PATTERN 
-- Highest spenders on each payment type
-- ===========================================================

SELECT
  payment_type,
  MAX(payment_value) AS max_single_payment
FROM `retail_analytics.payments`
GROUP BY payment_type
ORDER BY max_single_payment DESC;
