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
There are two ways to think of the expected output:

**Expected Output 1**
| pclass   | non_survivors | survivors |
| -------- | ------------- | --------- |
| 1        |               |           |
| 2        |               |           |
| 3        |               |           |

**Expected Output 2**
| survived   | first_class | second_class | third_class |
| ---------- | ----------- | ------------ | ----------- |
| 0          |             |              |             |
| 1          |             |              |             |

We will look at how to derive at **Expected Output 1**. The same method can be applied for **Expected Output 2**.
1. Group the result by `pclass`.
2. For each non-survivor, `survived = 0`. We count the number of non-survivor by using **CASE WHEN** statement. We utilize the concept of an indicator function. The pseudocode is as follows:
````
SUM(
  IF survived = 0,
     1
  ELSE 0)
````

3. Repeat the process of step 2 for survivor.


## Step-by-step Guide
### 1. Group the result by `pclass`.

````sql
SELECT *
FROM titanic
GROUP BY pclass
````

### 2. For each pclass, count the number of non-survivors.

````sql
SELECT pclass, 
  SUM(CASE WHEN survived = 0 THEN 1 ELSE 0 END) AS non_survivors
FROM titanic
GROUP BY pclass

````

### 3. For each pclass, count the number of survivors.

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
