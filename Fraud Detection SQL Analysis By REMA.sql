create database fraud_detection_dataset;
use fraud_detection_dataset;
-- Q & A --
-- 1. What is the total amount of transactions in the dataset?
select sum(amount)  total_transactions from fraud_detection_dataset;
--  156911.05999999994  --
-- 2. Which location has the highest average transaction amount?
select location,avg(amount) average_transaction_amount from fraud_detection_dataset
group by location
order by average_transaction_amount desc limit 1;
--  Grantfurt	 998.99  --
-- 3. How does the distribution of device types vary among users?
select device_type, count(*) device_count from fraud_detection_dataset
group by device_type;
--   Mobile	93 ,   Tablet	102 ,   Desktop	88   --
-- 4. What percentage of transactions are flagged as fraudulent?
select sum(case when  is_fraud = 1 then 1 else 0 end)  fraudulent_transactions,count(*)  total_transactions,
(sum(case when  is_fraud = 1 then 1 else 0 end) / COUNT(*)) * 100  percentage_fraudulent from fraud_detection_dataset;
--  fraudulent_transactions  0	  total_transactions  283	  percentage_fraudulent  0.0000  --
-- 5. Is there a correlation between user age and income?
select age, sum(income) total_income from fraud_detection_dataset
group by age;
--  No Correlation   --
-- 6. How many users have a debt greater than a certain threshold?
select count(distinct user_id)  users_with_debt_above_threshold from fraud_detection_dataset
where debt > 1000;
--  277  --
-- 7. What is the average credit score among users?
select avg(credit_score)  average_credit_score from fraud_detection_dataset;
--   576.8269  --
-- 8. Is there a difference in the average transaction amount between fraudulent and non-fraudulent transactions?
select is_fraud,avg(amount)  average_transaction_amount from fraud_detection_dataset
group by is_fraud;
--   is_fraud  0     average_transaction_amount    554.4560424028266   --
-- 9. Which location has the highest number of fraudulent transactions?
select location,count(*)  fraudulent_transaction_count from fraud_detection_dataset
where is_fraud = 1
group by location
order by fraudulent_transaction_count desc limit 1;
--   in this data is_fraud = 0 in all row --
-- 10. Are users with higher incomes less likely to commit fraud? 
select 
    ( case 
        when income <5000 then 'Low Income'
        when income >=5000 then 'High Income'
        else 'Unknown'
    end ) income_group ,
COUNT(*)  total_transactions,sum(case when  is_fraud = 1 then 1 else 0 end)  fraudulent_transactions,
(sum(case when  is_fraud = 1 then 1 else 0 end) /count(*)) * 100  percentage_fraudulent from fraud_detection_dataset
group by income_group;
-- income_group   High Income 	 total_transactions   283  	fraudulent_transactions   0     percentage_fraudulent	  0.0000  --