-----------------------------------------------------------------------------------
-- Date: March 11 th 2019
-- Purpose: Submission for Lab 7 DBS301
-- Description: This file includes SQL scripts that apply set operator methods
------------------------------------------------------------------------------------
--QUESTION 1--The HR department needs a list of Department IDs for departments that do not contain the job ID of ST_CLERK

--QUESTION 1 SOL--
SELECT department_id
    FROM departments
MINUS
    (SELECT department_id
    FROM employees
        WHERE upper(department_id) LIKE 'ST_CLERK');

--QUESTION 2--Same department requests a list of countries that have no departments located in them. 
--Display country ID and the country name. Use SET operators.

--QUESTION 2 SOL--
SELECT country_id   
    FROM countries
MINUS
    SELECT country_id 
    FROM countries
        WHERE country_id IN(
        SELECT country_id 
        FROM locations JOIN departments
        ON locations.location_id=departments.location_id);

--QUESTION 3--The Vice President needs very quickly a list of departments 10, 50, 20 in that order. job and department ID are
--to be displayed.

--QUESTION 3 SOL--
SELECT job_id AS "job",
        department_id
    FROM employees
    WHERE department_id =10 OR department_id=50 OR department_id=20
    ORDER BY(
      CASE department_id WHEN 10 THEN 0 
            WHEN 50 THEN 1
            WHEN 20 THEN 2
            END
    );

--QUESTION 4--Create a statement that lists the employeeIDs and JobIDs of those employees who currently have a 
--job title that is the same as their job title when they were initially hired by the company (that is, they changed jobs 
--but have now gone back to doing their original job).

--QUESTION 4 SOL--

SELECT employees.employee_id,job_id
    FROM employees JOIN job_history
    USING (job_id);


--QUESTION 5--The HR department needs a SINGLE report with the following specifications:
--Last name and department ID of all employees regardless of whether they belong to a department or not.
--Department ID and department name of all departments regardless of whether they have employees in them or not.

--QUESTION 5 SOL--
SELECT * FROM (
SELECT last_name,department_id,d.department_name
    FROM employees e FUll JOIN departments d
    USING (department_id)
UNION
SELECT last_name,department_id,d.department_name
    FROM departments d LEFT JOIN  employees e
    USING (department_id)
);

