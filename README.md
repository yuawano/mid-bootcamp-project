# Classification project on a imbalanced data 
![Screenshot](classification/data/image2.jpg)

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
Note: For futher details, please refer to the sql file under data folder

- Percentage of offer acceptance (No, Yes)

| offer accepted | ratio |
|----------------|-------|
| Yes            | 6%    |
| No             | 94%   |

- Offer accepted and mailer type

| Offer accepted | Letter | Post card |
|----------------|--------|-----------|
| Yes            | 2%     | 4%        |
| No             | 48%    | 47%       |

- Average balance of all customers: 984

- Average balance per income level

| income level | Avg_bal     |
|--------------|-------------|
| High         | 943         |
| Medium       | 941         |
| Low          | 938         |

- Average number of credit cards held per credit rating

| credit rating | Avg_count |
|---------------|-----------|
| High          | 1.90      |
| Medium        | 1.91      |
| Low           | 1.90      |

- Average number of credit cards held per open bank accounts

| Bank accounts open | avg credit cards held |
|--------------------|-----------------------|
| 1                  | 1.90                  |
| 2                  | 1.90                  |
| 3                  | 1.94                  |

Other findings:
- 6% accepted the offer
- 50% of the customers are in the midium income level 
- 76% of the customer holds 1 bank account
- 78% of the customer owns 1 or 2 creditcards
- 80% of the customers owns 1 house
- 60% of the customers has 3 to 4 household size. 30% of the customers has 2 or 5 household size.
- 65% of the customer owns their home
- Within the customers who accepted the offer, postcard invitation has slighly high chances to get offer accepted
- 4% accepted the offer

## Data exploration and modeling in python
### Procedures:
Please refer to the jupyternote book.

### Findings from data visualization:
1. Findings in categorical columns
- Imbalance data in target variable (column: 'offer_accepted'): 94% (No) vs 6% (Yes)
- Almost equal distrubution on columns: reward, mailer_type, credit_rating
- 50% of the customers are belonging to medium income_level
- 85% of customer have overdraft_protection
- 65% of the customer owns a home

2. Findings in numerical columns
- 76% of the customer owns 1 bank account
- 81% of the customer owns their home
- Average_blanace and q1_balance is skewed to the left

3. Findings in correlation between offer accepted and each features

Customer who accepted the offer are/has:
- Air Miles as rewards
- received credit card offerings in postcard
- do not have overdraft protection
- low credit ratings
- owns a home
- mostly have 1 bank account open
- holds 2 credit cards
- holds 1 owned house
- household size of 3 to 4 people

## Conclusion 
### Model and evaluation:
In this studies, due to the imbalanced data in the target variable,
Smote metrix was used to fixed the imbalanced data.
The studies implemented two different models: Linear regression, KNN Classifier
Since the studies focuses more on obtaining more customers to take the offer rather than spotting the exact customer who will take the offer, we want to see how the result of 'recall' is.
Below are the results of the recall score.

- Linear regression: 0.62
- KNN Classification: 0.37

Linear regression model has ran better than the KNN.
In this particular studies, smote does not function well with KNN classifier.

### Analysis results:
Below are the results of the customers who are more likely to accept the credit card offerings.
- Household_size of 3 to 4 people
- DO NOT have overdraft protection
- Low credit ratings
- Holds 1 bank account
- Holds 1 owned house
In addition, customers who receives the offer invitation via postcards are more likely to accept the offerings..



## Libraries
- [Pandas](https://pandas.pydata.org/)
- [Matplotlib](https://matplotlib.org/stable/contents.html)
- [Seaborn](https://seaborn.pydata.org/)
- [Sklearn](https://scikit-learn.org/stable/)