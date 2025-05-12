# 🧠 Marketing Campaign Analysis SQL Project

## 📌 Project Overview

This project focuses on analyzing customer transactions, sales trends, and marketing campaign effectiveness for a paint products company. Using SQL, I performed extensive data exploration, cleaning, and aggregation to derive meaningful insights that support decision-making in areas like product strategy, customer acquisition, campaign optimization, and business growth.

---

## 📂 Dataset Tables Used

- **Customer** – Contains customer information.
- **Item** – Holds product details like `Item_Category`.
- **CustomerTransactionData** – Records transactions including purchase date, quantity, amount, order type, etc.
- **CouponMapping** – Provides coupon types and mappings.
- **Campaign** – Includes campaign types and campaign IDs.
- **CityData** – Contains data on city tier and state.

---

## 📊 Key Business Insights & What I Learned

### 1. **Product Portfolio**
- Identified **5 unique product categories** (e.g., Oil paint, Synthetic paint).
- Oil Paint has the **highest sales**, Synthetic Paint the **lowest**.

### 2. **Coupon & Campaign Effectiveness**
- **2 different coupon types** used in promotions.
- Transactions with coupons (186) were **significantly higher** than those without (114).
- **Campaign coupons led to more first purchases**, suggesting successful customer acquisition.
- Customers using **campaign coupons** spent the most, followed by those with no coupons, and lastly normal coupons.

### 3. **Geographic Insights**
- Company operates across **21 states**.
- **City Tier 2** customers generated the **highest revenue**.

### 4. **Order Type Analysis**
- Identified **3 distinct order types** (Household, etc.).
- **Household orders** contributed the **highest sales volume**.

### 5. **Time-based Sales Trends**
- Highest transactions occurred in **2020**, with a steady **decline in 2023**.
- **Quarter 4** consistently outperformed others across years.
- **December 2020** recorded the **most transactions** (48).

### 6. **Customer Growth & Retention**
- Tracked **year-over-year** new and repeat customers.
- Customer count peaked in **2020** (71), declined thereafter.

### 7. **Campaign Recommendations**
- Based on declining sales, launching **Brand Awareness** and **Seasonal Campaigns** is advisable.
- Yearly comparisons of sales amount per campaign type helped quantify **decline patterns** and suggest **intervention strategies**.

### 8. **Market Basket Analysis**
- Identified common product combinations purchased together at least **3 times**.
- Proposed **bundled promotions** for these combinations to **boost cross-selling** and **average transaction value**.

---

## 🔧 SQL Skills Practiced

- **Aggregations** (`SUM`, `COUNT`, `GROUP BY`)
- **Window Functions** (`FIRST_VALUE`, `LAG`)
- **Joins** (INNER JOIN, LEFT JOIN)
- **Subqueries** and **Nested Queries**
- **Date Functions** (`EXTRACT`, `DATE_FORMAT`)
- **Conditional Logic** (`CASE WHEN`)
- **Union and Set Operations**

---

## 💡 Business Use-Cases Demonstrated

- Marketing Campaign Impact Evaluation
- Customer Segmentation
- Time-Series Sales Forecasting
- Market Basket Analysis
- Growth & Decline Detection
- Location-based Strategy Formulation

---

## 📈 Possible Extensions

- Build a **dashboard using Tableau or Power BI** to visualize KPIs.
- Use Python for **predictive modeling** (e.g., customer churn, campaign response).
- Integrate with a **CRM tool** to automate campaign triggers.

---

## 👨‍💻 Tools Used

- SQL (MySQL / PostgreSQL compatible syntax)
- DBMS or SQL IDE (e.g., MySQL Workbench, DBeaver, or BigQuery)
- Spreadsheet tools (for result interpretation, optional)

---

## 🙋‍♀️ What I Gained

- Real-world experience in analyzing **transactional and marketing data**.
- Deep understanding of how **campaigns influence customer behavior**.
- Confidence in writing **intermediate-to-advan
---


---

## ✅ Conclusion

This project simulated a **data-driven marketing team collaboration**, where SQL helped uncover patterns and strategies to **retain customers**, **optimize campaigns**, and **maximize revenue**.




