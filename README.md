# Retail Analytics Using SQL (Brazil E-Commerce Dataset)

This project analyzes the Brazil e-commerce retail dataset using SQL to uncover customer behavior, geographic patterns, delivery performance, payment trends, and economic insights.
It includes modular SQL scripts, well-documented analysis, and a final insights report.

---

## 📁 Project Structure

```
SQL-Retail-Analytics/
│
├── queries/
│   ├── 01_eda.sql
│   ├── 02_time_trends.sql
│   ├── 03_geography.sql
│   ├── 04_economy_analysis.sql
│   ├── 05_delivery_performance.sql
│   └── 06_payments_analysis.sql
│
└── 07_final_insights.md     # Full insights report
```



---

##  Dataset

The dataset contains customers, orders, payments, items, products, geolocation, and delivery details.  
It covers **95k+ orders** across all states of Brazil from **2016–2018**.

---

## What This Project Does

- Performs full SQL analysis across **time, geography, payments, and logistics**  
- Computes KPIs:  
  - Delivery time  
  - Late delivery rate  
  - Estimated vs actual gap  
  - Revenue growth  
  - Payment behavior  
- Builds business insights and recommendations  
- Organizes SQL queries into clean, reproducible files  
- Produces a final insight summary (07_final_insights.md)

---

##  Key Insights (Summary)

- Delivery time averages **~12 days**, slower in northern states  
- **8.11%** of orders are late  
- Orders often arrive **earlier** than the estimated date  
- Revenue grew strongly from **2017 → 2018**  
- Credit card dominates both **order count** and **revenue share**  
- Afternoon and night see the highest order volumes  
- Installments heavily influence high-value purchases  
- Freight cost and delivery time rise sharply in remote states

Full findings:  
**See `07_final_insights.md`**

---

##  Skills Demonstrated

- SQL joins, subqueries, aggregates  
- Time-series and trend analysis  
- Geographic segmentation  
- Payment and revenue analysis  
- KPI creation  
- Logistics & delivery analytics  
- Writing modular SQL  
- Git & GitHub project structuring

---

## How To Run

1. Clone the repo  
2. Open the `queries/` folder  
3. Run the `.sql` scripts in **BigQuery**  
4. Read final insights in `07_final_insights.md`

---

## Author

**Roshni M S**  
Business Analytics | SQL | Data Analysis

