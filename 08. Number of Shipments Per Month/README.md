You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/2056-number-of-shipments-per-month?code_type=3).

# Question

**Write a query that will calculate the number of shipments per month. The unique key for one shipment is a combination of shipment_id and sub_id. Output the year_month in format YYYY-MM and the number of shipments in that month.**


````
Table: amazon_shipment
| Column Name   | Column Type |
| ------------- | ----------- |
| shipment_id   | int         |
| sub_id        | int         |
| weight        | int         |
| shipment_date | datetime    |
````

## The thinking behind the approach
1. Write a cte that extracts `shipment_date` in the format of YYYY-mm. This can be done using **DATE_FORMAT()** in MySQL.
2. Use **COUNT()** to find the number of shipments, group by year_month.

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
