You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?code_type=1).

# Question

**You have been asked to find the job titles of the highest-paid employees.<br>
Your output should include the highest-paid title or multiple titles with the same salary.**


````
Table: worker
| Column Name   | Column Type |
| ------------- | ----------- |
| worker_id     | int         |
| first_name    | varchar     |
| last_name     | varchar     |
| salary        | int         |
| joining_date  | datetime    |
| department    | varchar     |
````

````
Table: title
| Column Name   | Column Type |
| ------------- | ----------- |
| worker_ref_id | int         |
| worker_title  | varchar     |
| affected_from | datetime    |
````

## The thinking behind the approach
1. Join both tables on worker's id.
2. Add a filter such that we filter for the row(s) that have the highest salary of all.
3. Select for the worker title only.

## Step-by-step Guide
### 1. Join both tables on worker's id.

````sql
SELECT *
FROM worker w
INNER JOIN title t ON w.worker_id = t.worker_ref_id
````

### 2. Filter for the rows that have the maximum salary.

````sql
SELECT *
FROM worker w
INNER JOIN title t ON w.worker_id = t.worker_ref_id
WHERE w.salary = (
	SELECT MAX(salary) FROM worker
)
````

### 3. Select for the worker title only.

````sql
SELECT worker_title
FROM worker w
INNER JOIN title t ON w.worker_id = t.worker_ref_id
WHERE w.salary = (
	SELECT MAX(salary) FROM worker
);
````

If you have any questions or feedback, please feel free to email me at kohjingyan@gmail.com or at [LinkedIn](https://www.linkedin.com/in/koh-jing-yan/).
