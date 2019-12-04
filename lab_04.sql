----------------------------------------------------------------
-- Date: Feb 4th 2019
-- Purpose: Submission for Lab 4 DBS301
-- Description: This file includes SQL scripts that apply multi-row functions, aggregate functions, and grouping to retrieve specific data

----------------------------------------------------------------

--Question 1--Display the difference between the Average pay and Lowest pay in the company.  Name this result Real Amount.  Format the output as currency with 2 decimal places.

--Q1 SOLUTION--
SELECT to_char(AVG(salary)-MIN(salary),'$999,999.00') AS Real_Amount
    
    FROM Employees;

--Question 2--Display the department number and Highest, Lowest and Average pay per each department. Name these results High, Low and Avg.  Sort the output so that the department with highest average salary is shown first.  Format the output as currency where appropriate.

--Q1 SOLUTION--

SELECT department_id, to_char(MAX(salary),'$999,999.00') AS High,to_char(MIN(salary),'$999,999.00')AS Low,
    to_char(AVG(salary),'$999,999.00') AS Avg
    FROM Employees
    GROUP BY department_id
    ORDER BY High DESC;

--Question 3 -- Display how many people work the same job in the same department. Name these results Dept#, Job and How Many. Include only jobs that involve more than one person.  Sort the output so that jobs with the most people involved are shown first.

--Q3 SOLUTION--
SELECT department_id,job_id,count(employee_id) AS HowMany
    FROM Employees
    GROUP BY department_id,job_id
    ORDER BY HowMany DESC;

--Question 4--For each job title display the job title and total amount paid each month for this type of the job. Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $11,000.  Sort the output so that top paid jobs are shown first.

--Q4 SOlUTION--
SELECT job_id, SUM(salary)
    FROM Employees
    WHERE job_id NOT LIKE 'AD_PRES' AND job_id NOT LIKE 'AD_VP'
    GROUP BY job_id
    HAVING SUM(salary) >11000
    ORDER BY SUM(salary)DESC;
    
--Question 5--For each manager number display how many persons he / she supervises. Exclude managers with numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.  Sort the output so that manager numbers with the most supervised persons are shown first.     

--Q5 SOlUTION--
SELECT manager_id,count(employee_id) AS HowMany
    FROM Employees
    WHERE manager_id NOT LIKE 100 AND manager_id NOT LIKE 101 AND manager_id NOT LIKE 102
    GROUP BY manager_id
    HAVING count(employee_id)>2
    ORDER BY HowMany DESC;
    
----------------------------------------------------------------
-- END OF FILE
----------------------------------------------------------------
    