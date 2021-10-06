-- 1. Create a database called credit_card_classification.
-- CREATE DATABASE if not exists credit_card_classification;
use credit_card_classification;

-- 2. Create a table credit_card_data with the same columns as given in the csv file. 
-- Here, I have imported the file in jupyter notebook and then cleaned to column.
-- Saved the new dataframe with new file name (credit_card_data) and then imported via import wizard

-- 3. Import the data from the csv file into the table.
SET SQL_SAFE_UPDATES = 0;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

-- 4. Select all the data from table credit_card_data to check if the data was imported correctly.
SELECT *
from credit_card_data;

-- 5. Use the alter table command to drop the column q4_balance from the database, 
-- as we would not use it in the analysis with SQL. 
-- Select all the data from the table to verify if the command worked. Limit your returned results to 10.
ALTER TABLE credit_card_data
DROP COLUMN q4_balance;

SELECT * FROM credit_card_data
LIMIT 10;

-- 6. Use sql query to find how many rows of data you have.
SELECT count(customer_number)
FROM credit_card_data;

-- 7. Now we will try to find the unique values in some of the categorical columns:
-- - What are the unique values in the column `Offer_accepted`?
SELECT DISTINCT(offer_accepted)
FROM credit_card_data;
-- - What are the unique values in the column `mailer_type`?
SELECT DISTINCT(mailer_type)
FROM credit_card_data;
-- - What are the unique values in the column `credit_cards_held`?
SELECT DISTINCT(credit_cards_held)
FROM credit_card_data
ORDER BY credit_cards_held;
-- - What are the unique values in the column `household_size`?
SELECT DISTINCT(household_size)
FROM credit_card_data
ORDER BY household_size;

-- 8. Arrange the data in a decreasing order by the average_balance of the house. 
-- Return only the customer_number of the top 10 customers with the highest average_balances in your data.
SELECT customer_number, average_balance
FROM credit_card_data
ORDER BY average_balance DESC
LIMIT 10;

SELECT * FROM (
SELECT customer_number, ROUND(average_balance), rank() over (order by average_balance desc) as ranking
FROM credit_card_data) t1
WHERE ranking <= 10;

-- 9. What is the average balance of all the customers in your data?
-- Since the average_balance in the sheet includes q4_balance, recalculating is necesary.
SELECT * FROM credit_card_data;


WITH cte1 as (
	SELECT customer_number, q1_balance, q2_balance, q3_balance, (q1_balance + q2_balance + q3_balance)/3 as avg_balance_3
    FROM credit_card_data
    )
SELECT ROUND(AVG(avg_balance_3)) as average_balance_all
FROM cte1;


-- 10. In this exercise we will use group by to check the properties of some of the categorical variables in our data. 
-- Note wherever average_balance is asked in the questions below, please take the average of the column average_balance:

-- 10.1: What is the average balance of the customers grouped by `Income Level`? 
-- The returned result should have only two columns, income level and `Average balance` of the customers. 
-- Use an alias to change the name of the second column.

SELECT income_level, ROUND(AVG(average_balance)) as avg_balance
FROM credit_card_data
GROUP BY income_level;

-- 10.2: What is the average balance of the customers grouped by `number_of_bank_accounts_open`? 
-- The returned result should have only two columns, `number_of_bank_accounts_open` and `Average balance` of the customers. 
-- Use an alias to change the name of the second column.
SELECT * FROM credit_card_data;
SELECT bank_accounts_open,  ROUND(AVG(average_balance)) as avg_balance
FROM credit_card_data
GROUP BY bank_accounts_open;


-- 10.3: What is the average number of credit cards held by customers for each of the credit card ratings? 
-- The returned result should have only two columns, rating and average number of credit cards held. 
-- Use an alias to change the name of the second column.
SELECT * FROM credit_card_data;

SELECT credit_rating, CAST(AVG(credit_cards_held) AS DECIMAL(10,2))
FROM credit_card_data
GROUP BY credit_rating;

-- 10.4: Is there any correlation between the columns `credit_cards_held` and `number_of_bank_accounts_open`? 
-- You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
SELECT * FROM credit_card_data;

SELECT bank_accounts_open, CAST(AVG(credit_cards_held) AS DECIMAL(10,2))
FROM credit_card_data
GROUP BY bank_accounts_open;

-- 10.5: Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
-- Findings: There are slight tendency that customer with 3 bank accounts have higher tendency to hold credit cards

-- 10.6: You might also have to check the number of customers in each category 
-- (ie number of credit cards held) to assess if that category is well represented in the dataset to include it in your analysis. 
-- For eg. If the category is under-represented as compared to other categories, ignore that category in this analysis
SELECT * FROM credit_card_data;

-- Ratio of offer acceptance by customers
SELECT offer_accepted, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY offer_accepted;
-- Findings: only 5 % of the customer accepted the credit cards offer

-- Ratio of reward type
SELECT reward, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY reward;
-- findings: almost equal distribution to all rewards

-- Ratio of mailer type
SELECT mailer_type, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY mailer_type;
-- findings: equal distribution to letter and Postcard

-- Check offer acceptance of letter and postcard
SELECT offer_accepted, mailer_type, count(mailer_type), ROUND(count(mailer_type) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY offer_accepted, mailer_type;
-- findings: out of the customer who accepted the offer, postcard invitation has slighly high chances to get offer accepted

-- Ratio of income_level
SELECT income_level, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY income_level;
-- Findings: 50% of the customers are in the midium income level 

-- Ratio of opened bank accounts 
SELECT bank_accounts_open, count(customer_number), count(customer_number) * 100.0/(SELECT count(*) from credit_card_data) AS customer_percent
FROM credit_card_data
GROUP BY bank_accounts_open;
-- 76% of the customer holds 1 bank account

-- Ratio of number of credit cards held
SELECT credit_cards_held, count(customer_number) , ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY credit_cards_held
ORDER BY credit_cards_held;
-- 78% of the customer owns 1 or 2 creditcards

-- Ratio of homes_owned
SELECT homes_owned, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY homes_owned;
-- Findings: 80% of the customers owns 1 house

-- Ratio of household size
SELECT household_size, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY household_size
ORDER BY household_size ASC;
-- Findings: 60% of the customers has 3 to 4 household size. 30% of the customers has 2 or 5 household size.

-- Ratio of owning their house
SELECT own_your_home, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY own_your_home;
-- findings: 65% of the customer owns their home


-- 11. Your managers are only interested in the customers with the following properties:

-- - Credit rating medium or high
-- - Credit cards held 2 or less
-- - Owns their own home
-- - Household size 3 or more
-- For the rest of the things, they are not too concerned. 

-- 11.1: Write a simple query to find what are the options available for them? 
-- WHAT DOES THIS MEAN??? CHECK IN CLASS

-- 11.2: Can you filter the customers who accepted the offers here?

SELECT customer_number, offer_accepted, credit_rating, credit_cards_held, own_your_home, household_size
FROM credit_card_data
WHERE (offer_accepted = 'yes') 
AND (credit_rating =  'High' or credit_rating = 'Medium')
AND (credit_cards_held <=2)
AND (own_your_home = 'Yes') 
AND (household_size >= 3);

-- 12. Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. 
-- Write a query to show them the list of such customers. You might need to use a subquery for this problem.

WITH cte1 as (
	SELECT *, ROUND((q1_balance + q2_balance + q3_balance)/3) as avg_balance_3
    FROM credit_card_data
    )
SELECT * -- customer_number, ROUND(avg_balance_3) 
FROM cte1
WHERE avg_balance_3 <= (SELECT ROUND(AVG(avg_balance_3)) as average_balance_all FROM cte1);
    
    
-- 13. Since this is something that the senior management is regularly interested in, create a view called Customers__Balance_View1 of the same query.
CREATE VIEW Customers__Balance_View1 AS
WITH cte1 as (
	SELECT *, ROUND((q1_balance + q2_balance + q3_balance)/3) as avg_balance_3
    FROM credit_card_data
    )
SELECT * -- customer_number, ROUND(avg_balance_3) 
FROM cte1
WHERE avg_balance_3 <= (SELECT ROUND(AVG(avg_balance_3)) as average_balance_all FROM cte1);

SELECT * FROM Customers__Balance_View1;


-- 14. What is the number of people who accepted the offer vs number of people who did not?

SELECT offer_accepted, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY offer_accepted;
-- Findings: 1021 customers accepted the offer and 16955 did not.
-- in ratio: only 5 % of the customer accepted the credit cards offer.

-- 15. Your managers are more interested in customers with a credit rating of high or medium. 
-- What is the difference in average balances of the customers with high credit card rating and low credit card rating?

-- Note: The average_balance below is used from the original data (including q4)

WITH cte1 AS (
SELECT credit_rating, ROUND(AVG(average_balance)) as avg_balance
FROM credit_card_data
GROUP BY credit_rating
),
cte2 AS (
SELECT *, LAG(avg_balance) OVER (ORDER BY credit_rating) AS lag_balance
FROM cte1
WHERE (credit_rating = 'High' OR credit_rating = 'Low')
)
SELECT *, (avg_balance - lag_balance) AS difference
FROM cte2;


-- 16. In the database, which all types of communication (mailer_type) were used and with how many customers?
SELECT mailer_type, count(customer_number), ROUND(count(customer_number) * 100.0/(SELECT count(*) from credit_card_data)) AS customer_percent
FROM credit_card_data
GROUP BY mailer_type;
-- findings: Letter was used for 8842 (49% of overall) customers and postcards were used for 9134 (51% of overall customers) customers.

-- 17. Provide the details of the customer that is the 11th least Q1_balance in your database.
SELECT * FROM (
SELECT customer_number, q1_balance, DENSE_RANK() over (order by q1_balance) AS ranking 
FROM credit_card_data
ORDER BY q1_balance) t1
WHERE ranking = 11;







