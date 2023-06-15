You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced?code_type=1).

# Question

**You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. Find the number of users that made additional in-app purchases due to the success of the marketing campaign.**

**The marketing campaign doesn't start until one day after the initial in-app purchase so users that only made one or multiple purchases on the first day do not count, nor do we count users that over time purchase only the products they purchased on the first day.**


````
Table: marketing_campaign
| Column Name   | Column Type |
| ------------- | ----------- |
| user_id       | int         |
| created_at    | datetime    |
| product_id    | int         |
| quantity      | int         |
| price         | int         |

````

## The thinking behind the approach

We can think of it as **before** marketing campaign and **after** marketing campaign.

If let's say a user purchased product A and B on their first day. For the marketing campaign to succeed:
- The user must buy a new product (i.e. NOT Product A nor B).
- The new product must be bought at least a day after the initial purchase.

We formulate our approach in terms of the date of which a product is bought by a user for the first time. ***If the first purchase date of the product(s) is different from the initial in-app purchase date, then marketing campaign succeeded.*** Else, it does not.

For example, a user bought Product A and Product B as their initial in-app purchases at 2020-01-01. If the same user bought Product C the day after, the first purchase date of Product C is different from the first purchase date of Product A and Product B, therefore we should count this user.

1. Use window function **MIN()** to find each user's first in-app purchase date. This is a new column named as initial_purchase_date
2. Use window function **MIN()** to find the dates at which each user bought a new product for the first time. This is a new column named as initial_product_purchase_date.
3. Filter the result to satisfy the condition ``initial_purchase_date != initial_product_purchase_date``.
4. Count the number of users that made additional in-app purchases due to the success of the marketing campaign.

## Step-by-step Guide
### 1. Find each user's first in-app purchase date.

```` SQL
SELECT user_id,
        created_at,
        product_id,
        MIN(created_at) OVER(PARTITION BY user_id ORDER BY created_at) AS initial_purchase_date,
FROM marketing_campaign

````

### 2. Find the date at which each user bought a new product for the first time.

```` SQL
SELECT user_id,
        created_at,
        product_id,
        MIN(created_at) OVER(PARTITION BY user_id ORDER BY created_at) AS initial_purchase_date,
        MIN(created_at) OVER(PARTITION BY user_id, product_id ORDER BY created_at) AS initial_product_purchase_date
FROM marketing_campaign

````

### 3. Using subquery, filter the result to satisfy the condition ``initial_purchase_date != initial_product_purchase_date``.

```` SQL
SELECT *
FROM (
  SELECT user_id,
        created_at,
        product_id,
        MIN(created_at) OVER(PARTITION BY user_id ORDER BY created_at) AS initial_purchase_date,
        MIN(created_at) OVER(PARTITION BY user_id, product_id ORDER BY created_at) AS initial_product_purchase_date
  FROM marketing_campaign) x
WHERE x.initial_purchase_date != x.initial_product_purchase_date;

````

### 4. Count the number of users.

```` SQL
SELECT COUNT(DISTINCT user_id)
FROM (
  SELECT user_id,
        created_at,
        product_id,
        MIN(created_at) OVER(PARTITION BY user_id ORDER BY created_at) AS initial_purchase_date,
        MIN(created_at) OVER(PARTITION BY user_id, product_id ORDER BY created_at) AS initial_product_purchase_date
  FROM marketing_campaign) x
WHERE x.initial_purchase_date != x.initial_product_purchase_date;

````

If you have any questions or feedback, please feel free to email me at kohjingyan@gmail.com or at [LinkedIn](https://www.linkedin.com/in/koh-jing-yan/).
