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
