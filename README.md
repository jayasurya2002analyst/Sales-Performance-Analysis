# Sales-Performance-Analysis
Mini Project 1: Sales Performance Dashboard using MySQL and Excel.
# 🧩 Mini Project 1: Sales Performance Analysis

### 📊 Overview
This project analyzes company sales data using **MySQL** for data exploration and **Excel** for dashboard visualization.  
The goal is to identify key sales trends, profit insights, and regional performance for better business decisions.

---

### 🛠 Tools & Technologies
- **MySQL** – for data cleaning and SQL analysis  
- **Excel 2010** – for KPI dashboard creation and visualization  
- **Pivot Tables & Charts** – for sales and profit trends  
- **Slicers** – for interactivity  

---

### 📁 Project Files
| File | Description |
|------|--------------|
| `day11 - miniproject -1.sql` | MySQL script for sales data analysis (queries for category, region, top products, profit %, etc.) |
| `day11 - miniproject -1.xlsx` | Excel dashboard with KPIs, charts, and slicers |
| `dataset/sales_data.xlsx` *(optional)* | Cleaned dataset used for analysis |

---

### 📈 Dashboard Insights
1. **KPIs:**
   - 💰 Total Sales  
   - 📈 Total Profit  
   - 📊 Average Profit Percentage  

2. **Visualizations:**
   - 🥧 *Category-wise Sales Share (Pie Chart)*  
   - 📦 *Top 5 Products by Sales (Bar Chart)*  
   - 📅 *Monthly Sales Trend (Line Chart)*  
   - 🌎 *Region-wise Profit % (Stacked Column Chart)*  

3. **Filters:**
   - Region and Category slicers for dynamic filtering

---

### 🔍 Key Findings
- **Top Region:** North – highest profit margin.  
- **Weak Region:** South – high sales but low profit.  
- **Best Category:** Electronics and Accessories drive most sales.  
- **Peak Period:** Q3 (July–September) shows highest revenue.  

---

### 📊 Example Metrics
| Metric | Value (Example) |
|--------|----------------|
| Total Sales | ₹ 8,82,429 |
| Total Profit | ₹ 1,72,664 |
| Avg Profit % | 28.57% |

*(Actual values may vary based on dataset used.)*
# 🧮 SQL Analysis – Sales Performance Project

### 📂 File: `day11 - miniproject -1.sql`

---

### 📊 Overview
This SQL script contains all the analytical queries used in the **Sales Performance Analysis** project.  
It focuses on understanding sales and profit trends, top-performing products, weak regions, and profit percentage calculations.

---

### 🧠 Objective
To extract meaningful business insights from the sales dataset using SQL queries such as:
- Category-wise performance  
- Region-wise profit percentage  
- Top and bottom-performing products  
- High-volume low-margin analysis (leak areas)  
- Monthly and quarterly trends  

---

### 🛠 Database Details
**Database Name:** `sales_project`  
**Table Name:** `sales`

**Table Columns:**
| Column | Type | Description |
|--------|------|-------------|
| OrderID | INT | Unique order identifier |
| ProductName | VARCHAR(100) | Product name |
| Category | VARCHAR(50) | Product category |
| Region | VARCHAR(50) | Sales region |
| Quantity | INT | Quantity sold |
| Sales | INT | Total sales value |
| Profit | INT | Profit amount |
| OrderDate | DATE | Date of order |

---

### 🔍 Key SQL Queries
| # | Query Purpose | SQL Feature Used |
|---|----------------|------------------|
| 1 | Calculate total sales and profit by category | `GROUP BY`, `SUM()` |
| 2 | Find top-performing regions by profit % | `ROUND()`, `NULLIF()` |
| 3 | List top 5 products by total sales | `ORDER BY`, `LIMIT` |
| 4 | Detect high-volume, low-margin products | `HAVING`, `AVG()` |
| 5 | Compare sales trends by month | `MONTH()`, `YEAR()` |
| 6 | Rank regions (top vs weak) | `CTE`, `DENSE_RANK()` (MySQL 8+) |

---

### 🧾 Example Insights
- **Top Region:** North – highest overall profit %  
- **Weak Region:** South – high sales but low margin  
- **Top Product:** Electronics items  
- **Peak Season:** July–September (Q3)  

---

### ⚙️ How to Run
```sql
CREATE DATABASE sales_project;
USE sales_project;

-- Create and load the sales table
SOURCE sales_project.sql;  -- or paste table DDL manually

-- Then run analysis queries below
SOURCE "day11 - miniproject -1.sql";


---

### 📘 Learning Highlights
- Practiced writing **aggregate SQL queries** with `GROUP BY`, `HAVING`, and `ORDER BY`.  
- Designed an **interactive Excel dashboard** with KPI cards and slicers.  
- Understood **data storytelling** for business reporting.  

---

### 🧠 Author
**Mamidi Jayasurya**  
📧 [mamidijayasurya1010@gmail.com]


---


