You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=1).

# Question

**Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.**

Table: db_employee
| Column Name   | Column Type |
| ------------- |:-----------:|
| id            | int         |
| first_name    | varchar     |
| last_name     | varchar     |
| salary        | int         |
| department_id | int         |

Table: db_dept
| Column Name   | Column Type |
| ------------- |:-----------:|
| id            | int         |
| department    | varchar     |

### Logical approach

### Step by step
1. Bla bla
Code
2. Bla bla
Code 
Etc.

`
with db_highest_salary AS (
SELECT d.department, MAX(salary) AS highest_salary
FROM db_employee e INNER JOIN
db_dept d ON e.department_id = d.id
WHERE d.department = 'marketing' or d.department = 'engineering'
GROUP BY d.department)
SELECT MAX(highest_salary) - MIN(highest_salary)
FROM db_highest_salary;
`

Please feel free to email me at kohjingyan@gmail.com for …
