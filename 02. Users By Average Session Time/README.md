You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=1).

# Question

**Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit, with an obvious restriction that load time event should happen before exit time event . Output the user_id and their average session time.**


````
Table: facebook_web_log
| Column Name   | Column Type |
| ------------- | ----------- |
| user_id       | int         |
| timestamp     | datetime    |
| action        | varchar     |
````

## The thinking behind the approach
1. Use **JOIN** on both tables based on `department id` from `db_employee` and `id` from `db_dept`.
2. Use **WHERE** to filter the data so that it consists of marketing and engineering departments only.
3. Group the result using the **GROUP BY** clause by `department` and find the highest salary for each department.
4. Create a temporary result by creating a Common Table Expression (CTE) named `db_highest_salary`.
5. Find the difference between the two highest salaries based on the CTE.

## Step-by-step Guide
### 1. Join the two tables.
````sql
SELECT 
  d.department, 
  MAX(salary) AS highest_salary
FROM db_employee e 
INNER JOIN db_dept d 
  ON e.department_id = d.id
````
### 2. Filter the data to marketing and engineering departments only.
````sql
SELECT 
  d.department, 
  MAX(salary) AS highest_salary
FROM db_employee e 
INNER JOIN db_dept d 
  ON e.department_id = d.id
WHERE d.department = 'marketing' or d.department = 'engineering'
````

### 3. Group the result by `department` and find the highest salary for each department.
````sql
SELECT 
  d.department, 
  MAX(salary) AS highest_salary
FROM db_employee e 
INNER JOIN db_dept d 
  ON e.department_id = d.id
WHERE d.department = 'marketing' or d.department = 'engineering'
GROUP BY d.department
````

### 4. Create a CTE and,
### 5. Find the difference between the two highest salaries.

````sql
WITH db_highest_salary AS (
  SELECT 
    d.department, 
    MAX(salary) AS highest_salary
  FROM db_employee e 
  INNER JOIN db_dept d 
    ON e.department_id = d.id
  WHERE d.department = 'marketing' OR d.department = 'engineering'
  GROUP BY d.department)
  
SELECT 
  MAX(highest_salary) - MIN(highest_salary) AS salary_difference
FROM db_highest_salary;
````

# Final Output
| user_id | avg    |
| ------- | ------ |
| 0       | 1883.5 |
| 1       | 35     |

If you have any questions or feedback, please feel free to email me at kohjingyan@gmail.com or at [LinkedIn](https://www.linkedin.com/in/koh-jing-yan/).
