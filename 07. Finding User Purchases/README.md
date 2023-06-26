You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/10322-finding-user-purchases?code_type=1).

# Question

**Write a query that'll identify returning active users. A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.**


````
Table: amazon_transactions
| Column Name   | Column Type |
| ------------- | ----------- |
| id            | int         |
| user_id       | int         |
| item          | varchar     |
| created_at    | datetime    |
| revenue       | int         |
````

## The thinking behind the approach
1. Find all users that made their second purchase. It can be found using **GROUP BY** and **HAVING** functions.
2. Find the difference in days between their first purchase and second purchase, second purchase and third purchase, and so on. It can be found using the window function **LEAD()**.
3. Save the result as a cte.
4. From the cte we saved, output the distinct users.

## Step-by-step Guide
### 1. Find all users that made their second purchase.

````sql
SELECT *
FROM amazon_transactions
WHERE user_id IN (SELECT user_id 
                  FROM amazon_transactions
                  GROUP BY user_id
                  HAVING COUNT(user_id) > 1))
````

### 2. Find the difference in days between their first purchase and second purchase, second purchase and third purchase, and so on.

````sql
SELECT *,
		      LEAD(created_at) OVER (PARTITION BY user_id ORDER BY created_at) - created_at diff_days
FROM amazon_transactions
WHERE user_id IN (SELECT user_id 
                  FROM amazon_transactions
                  GROUP BY user_id
                  HAVING COUNT(user_id) > 1))
````

### 3. Save the result as a cte.

````sql
WITH cte AS (
	SELECT *, 
		      LEAD(created_at) OVER (PARTITION BY user_id ORDER BY created_at) - created_at diff_days
	FROM amazon_transactions
	WHERE user_id IN (SELECT user_id 
			              FROM amazon_transactions
			              GROUP BY user_id
			              HAVING COUNT(user_id) > 1))
SELECT *
FROM cte
WHERE diff_days <= 7

````

### 4. From the cte we saved, output the distinct users.

````sql
WITH cte AS (
	SELECT *, 
		      LEAD(created_at) OVER (PARTITION BY user_id ORDER BY created_at) - created_at diff_days
	FROM amazon_transactions
	WHERE user_id IN (SELECT user_id 
			              FROM amazon_transactions
			              GROUP BY user_id
			              HAVING COUNT(user_id) > 1))
SELECT DISTINCT user_id
FROM cte
WHERE diff_days <= 7;

````

If you have any questions or feedback, please feel free to email me at kohjingyan@gmail.com or at [LinkedIn](https://www.linkedin.com/in/koh-jing-yan/).
