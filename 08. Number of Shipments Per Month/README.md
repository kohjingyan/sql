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
1. 

## Step-by-step Guide
### 1. Create the cte.

````sql
WITH cte AS (
	SELECT shipment_id, 
	       DATE_FORMAT(shipment_date, '%Y-%m') AS date_ym
	FROM amazon_shipment)
````

### 2. Count the number of shipments, group by date_ym.

````sql
WITH cte AS (
	SELECT shipment_id, 
	       DATE_FORMAT(shipment_date, '%Y-%m') AS date_ym
	FROM amazon_shipment)
SELECT date_ym, 
       COUNT(shipment_id) AS no_of_shipments
FROM cte
GROUP BY date_ym;
````

If you have any questions or feedback, please feel free to email me at kohjingyan@gmail.com or at [LinkedIn](https://www.linkedin.com/in/koh-jing-yan/).
