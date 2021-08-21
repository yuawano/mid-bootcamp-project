-- 1. Create a database called credit_card_classification.
CREATE DATABASE if not exists credit_card_classification;
use credit_card_classification;

-- 2. Create a table credit_card_data with the same columns as given in the csv file. 
-- Here, I have imported the file in jupyter notebook and then cleaned to column.
-- Saved the new dataframe with new file name (credit_card_data) and then imported via import wizard

-- 3. Import the data from the csv file into the table.
SET SQL_SAFE_UPDATES = 0;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

-- 4. Select all the data from table credit_card_data to check if the data was imported correctly.
SELECT * from credit_card_data;

-- 5. Use the alter table command to drop the column q4_balance from the database, 
-- as we would not use it in the analysis with SQL. 
-- Select all the data from the table to verify if the command worked. Limit your returned results to 10.
ALTER TABLE credit_card_data
DROP COLUMN q4_balance;

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
SELECT average_balance
FROM credit_card_data
ORDER BY average_balance DESC
LIMIT 10;

SELECT * FROM (
SELECT ROUND(average_balance), rank() over (order by average_balance desc) as ranking
FROM credit_card_data) t1
WHERE ranking <= 10;







