-- -----------------------------------------------------------
-- 01: EXPLORATORY DATA ANALYSIS (EDA)
-- Dataset: Target Brazil Retail (95k+ orders)
-- Data Warehouse: Google BigQuery
-- Schema: retail_analytics
-- -----------------------------------------------------------


-- ===========================================================
-- 1. STRUCTURE OF TABLES
-- ===========================================================

-- 1.1 Customers table structure
SELECT
  column_name,
  data_type
FROM `retail_analytics`.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'customers'
ORDER BY ordinal_position;


-- 1.2 Orders table structure
SELECT
  column_name,
  data_type
FROM `retail_analytics`.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'orders'
ORDER BY ordinal_position;


-- ===========================================================
-- 2. DATE RANGE OF ORDERS
-- ===========================================================

SELECT
  MIN(order_purchase_timestamp) AS first_order_date,
  MAX(order_purchase_timestamp) AS last_order_date
FROM `retail_analytics.orders`;


-- ===========================================================
-- 3. UNIQUE CITIES AND STATES
-- ===========================================================

SELECT
  COUNT(DISTINCT customer_city) AS unique_cities,
  COUNT(DISTINCT customer_state) AS unique_states
FROM `retail_analytics.customers`;


-- ===========================================================
-- 4. ROW COUNTS OF ALL TABLES 
-- ===========================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM `retail_analytics.customers`
UNION ALL
SELECT 'orders', COUNT(*) FROM `retail_analytics.orders`
UNION ALL
SELECT 'order_items', COUNT(*) FROM `retail_analytics.order_items`
UNION ALL
SELECT 'payments', COUNT(*) FROM `retail_analytics.payments`
UNION ALL
SELECT 'products', COUNT(*) FROM `retail_analytics.products`
UNION ALL
SELECT 'geolocation', COUNT(*) FROM `retail_analytics.geolocation`
UNION ALL
SELECT 'sellers', COUNT(*) FROM `retail_analytics.sellers`;


-- ===========================================================
-- 5. SAMPLE PREVIEW OF EACH TABLE
-- ===========================================================

SELECT * FROM `retail_analytics.customers` LIMIT 5;
SELECT * FROM `retail_analytics.orders` LIMIT 5;
SELECT * FROM `retail_analytics.order_items` LIMIT 5;
SELECT * FROM `retail_analytics.payments` LIMIT 5;
SELECT * FROM `retail_analytics.products` LIMIT 5;
SELECT * FROM `retail_analytics.geolocation` LIMIT 5;
SELECT * FROM `retail_analytics.sellers` LIMIT 5;

