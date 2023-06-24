You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/10303-top-percentile-fraud?code_type=1).

# Question

**ABC Corp is a mid-sized insurer in the US and in the recent past their fraudulent claims have increased significantly for their personal auto insurance portfolio. They have developed a ML based predictive model to identify propensity of fraudulent claims. Now, they assign highly experienced claim adjusters for top 5 percentile of claims identified by the model.\
Your objective is to identify the top 5 percentile of claims from each state. Your output should be policy number, state, claim cost, and fraud score.**


````
Table: fraud_score
| Column Name   | Column Type |
| ------------- | ----------- |
| policy_num    | varchar     |
| state         | varchar     |
| claim_cost    | int         |
| fraud_score   | float       |
````

## The thinking behind the approach
1. Create a new column called `percentile_rank` that uses window function **PERCENT_RANK** and save the result as a cte.
2. Filter the cte where `percentile_rank <= 0.05`.

## Step-by-step Guide
### 1. Create a new column called `percentile_rank` that uses window function **PERCENT_RANK** and save the result as a cte.

````sql
WITH cte AS (
	SELECT *, 
		PERCENT_RANK() OVER (PARTITION BY state ORDER BY fraud_score DESC) percentile_rank
	FROM fraud_score)
SELECT *
FROM cte
````

### 2. Filter the cte where `percentile_rank <= 0.05`.

````sql
WITH cte AS (
	SELECT *, 
		PERCENT_RANK() OVER (PARTITION BY state ORDER BY fraud_score DESC) percentile_rank
	FROM fraud_score)
SELECT 
	policy_num, 
	state, 
	claim_cost, 
	fraud_score
FROM cte
WHERE percentile_rank <= 0.05;

````

If you have any questions or feedback, please feel free to email me at kohjingyan@gmail.com or at [LinkedIn](https://www.linkedin.com/in/koh-jing-yan/).
