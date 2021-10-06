# Classification project on a imbalanced data 
![Screenshot](image/image2.jpg)

## Objective and hypothesis
### Background
The bank also provides credit card services which is a very important source of revenue for the bank. The bank wants to understand the demographics and other characteristics of its customers that accept a credit card offer and that do not accept a credit card. The bank designs a focused marketing study, with 18,000 current bank customers. This focused approach allows the bank to know who does and does not respond to the offer, and to use existing demographic data that is already available on each customer.

### Objective 
Learn how to clean the data, apply the statistical techniques and visulizations, apply logistic regression on a imbalanced data to find the best model for predicting why some bank customers accept credit card offers. 
In this studies, below programs are used to solve the problem.

- SQL
- Python
- Tableau

### Hypothesis
Customers with below requirements have higher chances to accept the offer
- higher household size (childrens may require credit cards)
- holds 0 or 1 credit card in the household
- holds higher average balance
- holds 2 or more bank accounts (to make separate payments with the credit card)


## Data source
The data set consists of information on 18,000 current bank customers in the study. 
The features consisted as follows:
- Customer Number: A sequential number assigned to the customers (this column is hidden and excluded – this unique identifier will not be used directly).
- Offer Accepted: Did the customer accept (Yes) or reject (No) the offer.
- Reward: The type of reward program offered for the card.
- Mailer Type: Letter or postcard.
- Income Level: Low, Medium or High.
- Bank Accounts Open: How many non-credit-card accounts are held by the customer.
- Overdraft Protection: Does the customer have overdraft protection on their checking account(s) (Yes or No).
- Credit Rating: Low, Medium or High.
- Credit Cards Held: The number of credit cards held at the bank.
- Homes Owned: The number of homes owned by the customer.
- Household Size: Number of individuals in the family.
- Own Your Home: Does the customer own their home? (Yes or No).
- Average Balance: Average account balance (across all accounts over time). Q1, Q2, Q3 and Q4
- Balance: Average balance for each quarter in the last year

## Exploring the data in SQL 
Refer to the 'credit_card_data.sql' under SQL folder.

## Data exploration and modeling in python
### Procedures:
Refer to '2_data_visualization.ipynb'.


## Conclusion 
### Model and evaluation:
In this studies, smote metrix was used to fixed the imbalanced data.
The studies implemented two different models: Logistic regression and KNN Classifier.
Since the studies focuses more on obtaining more customers to take the offer rather than spotting the exact customer who will take the offer the score of 'recall' is on focus.
Below are the results of the recall.

- Logistic regression: 0.62
- KNN Classification: 0.37

Logistic regression model has ran better than the KNN.
In this particular studies, smote metrix did not function well with KNN classifier.

### Analysis results:
Below are the results of the customers who are more likely to accept the credit card offerings.
- Household_size of 3 to 4 people
- DO NOT have overdraft protection
- Low credit ratings
- Holds 1 bank account
- Holds 1 owned house
In addition, customers who receives the offer invitation via postcards are more likely to accept the offerings.
For further information, refer to '2_data_visualization.ipynb'.


## Libraries
- [Pandas](https://pandas.pydata.org/)
- [Matplotlib](https://matplotlib.org/stable/contents.html)
- [Seaborn](https://seaborn.pydata.org/)
- [Sklearn](https://scikit-learn.org/stable/)