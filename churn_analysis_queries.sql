-- =====================================================
-- Customer Churn Analysis | MySQL
-- Database: churndb | Table: customer_churn
-- Table is loaded from Clean_Churn_Data via Python (pandas to_sql)
-- =====================================================

USE churndb;

-- 1. Total customers
SELECT COUNT(*) AS total_customers
FROM customer_churn;

-- 2. Total churned customers
SELECT COUNT(*) AS churned_customers
FROM customer_churn
WHERE Churn = 'Yes';

-- 3. Overall churn rate (%)
SELECT ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn;

-- 4. Average monthly charges
SELECT ROUND(AVG(Monthly_Charges), 2) AS avg_monthly_charges
FROM customer_churn;

-- 5. Average tenure (months)
SELECT ROUND(AVG(Tenure_Months), 1) AS avg_tenure_months
FROM customer_churn;

-- 6. Customers and churn rate by contract type
SELECT Contract_Type,
       COUNT(*) AS customers,
       SUM(Churn = 'Yes') AS churned,
       ROUND(SUM(Churn = 'Yes') * 100 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Contract_Type
ORDER BY churn_rate_pct DESC;

-- 7. Customers and churn rate by internet service
SELECT Internet_Service,
       COUNT(*) AS customers,
       SUM(Churn = 'Yes') AS churned,
       ROUND(SUM(Churn = 'Yes') * 100 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Internet_Service
ORDER BY churn_rate_pct DESC;

-- 8. Churned customers by state
SELECT State,
       COUNT(*) AS churned_customers
FROM customer_churn
WHERE Churn = 'Yes'
GROUP BY State
ORDER BY churned_customers DESC;

-- 9. Customers and churn rate by payment method
SELECT Payment_Method,
       COUNT(*) AS customers,
       SUM(Churn = 'Yes') AS churned,
       ROUND(SUM(Churn = 'Yes') * 100 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Payment_Method
ORDER BY churn_rate_pct DESC;

-- 10. Customers and churn rate by subscription type
SELECT Subscription_Type,
       COUNT(*) AS customers,
       SUM(Churn = 'Yes') AS churned,
       ROUND(SUM(Churn = 'Yes') * 100 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Subscription_Type
ORDER BY churn_rate_pct DESC;

-- 11. Highest revenue states
SELECT State,
       ROUND(SUM(Total_Charges), 2) AS total_revenue
FROM customer_churn
GROUP BY State
ORDER BY total_revenue DESC;

-- 12. Average monthly charges by contract type
SELECT Contract_Type,
       ROUND(AVG(Monthly_Charges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY Contract_Type;

-- 13. Churned customers by senior citizen status
SELECT Senior_Citizen,
       COUNT(*) AS churned_customers
FROM customer_churn
WHERE Churn = 'Yes'
GROUP BY Senior_Citizen;

-- 14. Top 10 high value customers
SELECT Customer_Name,
       Customer_Value
FROM customer_churn
ORDER BY Customer_Value DESC
LIMIT 10;

-- 15. Customers without tech support
SELECT *
FROM customer_churn
WHERE Tech_Support = 'No';

-- BONUS: churn rate by tenure group
SELECT Tenure_Group,
       COUNT(*) AS customers,
       ROUND(SUM(Churn = 'Yes') * 100 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Tenure_Group
ORDER BY Tenure_Group;
