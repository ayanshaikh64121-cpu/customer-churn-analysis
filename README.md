# Customer Churn Analysis

An end-to-end data analysis project that cleans raw customer data, analyzes churn in MySQL, and presents the findings in an interactive Power BI dashboard.

**Tools:** Python (Pandas, NumPy, SQLAlchemy) | MySQL | Excel | Power BI (DAX)

---

## Business Problem
Customer churn directly hurts recurring revenue. This project answers:
- What is the overall churn rate?
- Which customer segments (contract, subscription, internet service, payment method, tenure, state) churn the most?
- How much revenue is tied to customers who leave?

## Project Workflow
```
Excel (raw, dirty data)
   -> Python / Pandas (cleaning + feature engineering)
   -> Clean CSV export
   -> MySQL (customer_churn table)
   -> SQL analysis (15+ queries)
   -> Power BI dashboard
```

## Dataset
| Item | Detail |
|---|---|
| Raw records | 542 rows, 18 columns |
| Clean records | 492 rows, 23 columns |
| Key fields | Customer ID, demographics, state/city, tenure, subscription, contract, payment method, internet service, tech support, monthly/total charges, churn |

## Data Cleaning (Python)
- Removed 7 duplicate records
- Replaced dirty placeholders ("N/A", "NULL", blanks) with proper nulls
- Trimmed whitespace and standardized text casing
- Standardized the `Churn` column (YES / Yes / yes -> Yes)
- Converted numeric and date columns to correct types
- Removed invalid ages (outside 18-100) and negative charges
- Filled missing values (Tech Support = "No", Payment Method = "Unknown", mean imputation for numeric fields)

## Feature Engineering
| Feature | Description |
|---|---|
| `Customer_Value` | Monthly charges x tenure months |
| `Monthly_Revenue` | Monthly charges per customer |
| `Tenure_Group` | 0-12, 13-24, 25-48, 49-72 months |
| `Senior_Flag` | Senior (60+) vs Adult |
| `Churn_Flag` | 1 = churned, 0 = retained |

## SQL Analysis
All queries are in [`sql/churn_analysis_queries.sql`](sql/churn_analysis_queries.sql). They cover total customers, churn rate, churn by contract / internet service / payment method / subscription / tenure, state-wise revenue and churn, top high-value customers, and customers without tech support.

## Power BI Dashboard
KPI cards: Total Customers, Churn Customers, Retained Customers, Churn Rate, Total Revenue, Average Monthly Charges, Average Tenure.
Visuals: churn by contract, subscription and tenure, state map, internet service and payment method donuts, monthly charges vs churn scatter.

![Dashboard](dashboard/dashboard_screenshot.png)

## Key Insights
- Overall churn rate is **23.7%**.
- Customers with **49-72 months tenure churn the least (14%)**, versus 25-29% for shorter tenures.
- **Cable** has the highest churn among internet services (29.9%); **DSL** has the lowest (16.8%).
- **Basic** subscribers churn the least (16.3%); Premium (26.6%) and Standard (27.8%) churn more.
- **UPI and Debit Card** payers show the highest churn (about 28-29%); **Cash** payers the lowest (15%).
- Contract type shows only a small spread in churn (21-27%), and two-year contracts did not have the lowest churn in this sample.

## Recommendations
- Focus retention offers on customers in their first 4 years, where churn is highest.
- Investigate service quality for Cable customers.
- Review pricing and value for Standard and Premium plans.

## Limitations
- Small dataset (492 clean records), so segment-level differences may not be statistically significant.
- Missing numeric values were filled with the mean, which can slightly flatten variation.

## Repository Structure
```
customer-churn-analysis/
├── data/
│   ├── Churn_Unclean_Project.xlsx
│   └── Clean_Churn_Data.csv
├── notebooks/
│   └── churn_dataset_cleaning.ipynb
├── sql/
│   └── churn_analysis_queries.sql
├── dashboard/
│   ├── Customer_Churn_Analysis_Dashboard.pbix
│   └── dashboard_screenshot.png
└── README.md
```

## How to Run
1. Run `notebooks/churn_dataset_cleaning.ipynb` to clean the raw data.
2. Load the cleaned data into MySQL as table `customer_churn` (database `churndb`).
3. Run the queries in `sql/churn_analysis_queries.sql`.
4. Open the `.pbix` file in Power BI Desktop to explore the dashboard.

## Author
**[Your Name]** | [LinkedIn](https://linkedin.com/in/your-profile) | [Email](mailto:your-email)
