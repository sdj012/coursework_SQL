-----------------------------------------------------------------------------------
-- Date: March 18 th 2019
-- Purpose: Submission for Lab 8 DBS301
-- Description: This file includes SQL scripts that apply set operator methods
------------------------------------------------------------------------------------

--QUESTION 1--Display the names of the employees whose salary is the same as the lowest salaried employee in any department.

--Q1 Solution-
SELECT first_name||' '||last_name AS Employee
    FROM employees
    WHERE salary = ANY(
            SELECT min(salary)
            FROM employees
            WHERE salary IS NOT NULL
            GROUP BY department_id
        );

--QUESTION 2--Display the names of the employee(s) whose salary is the lowest in each department.

--Q2 Solution-
SELECT first_name||' '||last_name AS Employee
    FROM employees
    WHERE salary IN(
        SELECT min(salary)
        FROM employees
        WHERE salary IS NOT NULL
        GROUP BY department_id
    );

--QUESTION 3--Give each of the employees in question 2 a $120 bonus.

--Q3 Solution--
UPDATE employees
    SET salary=salary+120
    WHERE salary IN(
        SELECT min(salary)
        FROM employees
        WHERE salary IS NOT NULL
        GROUP BY department_id
    );

--QUESTION 4--Create a view named vwAllEmps that consists of all employees includes employee_id, last_name, salary, 
--department_id, department_name, city and country (if applicable)

--Q4 Solution--

CREATE VIEW vwAllEmps AS
SELECT employee_id,last_name,salary,employees.department_id,departments.department_name,locations.city,locations.country_id
    FROM employees LEFT JOIN departments ON employees.department_id=departments.department_id
            LEFT JOIN locations ON departments.location_id=locations.location_id
    ORDER BY department_name;

--QUESTION 5--Use the vwAllEmps view to:

--a.Display the employee_id, last_name, salary and city for all employees

--Q5.a Solution--
SELECT employee_id,last_name,salary,city
    FROM vwAllEmps;

--b.Display the total salary of all employees by city

--Q5.b Solution--
SELECT city,sum(salary)
    FROM vwAllEmps
    GROUP BY city;
    
--c.Increase the salary of the lowest paid employee(s) in each department by 120
--Q5.c Solution--
UPDATE vwAllEmps
    SET salary=salary+120
    WHERE salary IN(
        SELECT min(salary)
            FROM vwAllEmps
            WHERE salary IS NOT NULL
            GROUP BY department_id
    );

--d.What happens if you try to insert an employee by providing values for all columns in this view?

--Q5.d Solution--
--The below code generates an error. It says it is unable to modifiy more than one base table through a join view.

--INSERT INTO vwAllEmps 
--VALUES (123,'abc',4560,10,'newDept','Toronto','CA');

--e.Delete the employee named Vargas. Did it work? Show proof.

--Q5.e Solution--

--The below code removed employee with last name 'Vargas' from table 'employees'.

DELETE FROM vwAllEmps
    WHERE last_name LIKE upper('VARGAS');

--QUESTION 6--Create a view named vwAllDepts that consists of all departments and includes department_id,
--department_name, city and country (if applicable)

--Q6 Solution--
CREATE VIEW vwAllDepts AS
    SELECT department_id,department_name,locations.city,locations.country_id
        FROM departments JOIN locations 
            ON departments.location_id=locations.location_id
        ORDER BY department_name;

--QUESTION 7--Use the vwAllDepts view to:
--a.For all departments display the department_id, name and city

--Q7.a Solution--

SELECT department_id,department_name,city
    FROM vwAllDepts;

--Q7.b Solution--For each city that has departments located in it display the number of departments by city

SELECT city,count(department_id) AS "Number of Departments"
    FROM vwAllDepts
    GROUP BY city;

--QUESTION 8--Create a view called vwAllDeptSumm that consists of all departments
--and includes for each department: department_id, department_name, 
--number of employees, number of salaried employees, total salary of all employees. 
--Number of Salaried must be different from number of employees. 
--The difference is some get commission.

--Q8 Solution--
CREATE VIEW vwAllDeptSumm AS
    SELECT departments.department_id,department_name,count(employee_id) AS NumOfEmps,sum(salary) AS TotalSalary
    FROM departments JOIN employees ON departments.department_id=employees.department_id
    GROUP BY departments.department_id, departments.department_name;
    
--QUESTION 9--Use the vwAllDeptSumm view to display department name and number of employees for departments that 
--have more than the average number of employees 

--Q9 Solution--
SELECT department_name,NumOfEmps
    FROM vwAllDeptSumm
    WHERE NumOfEmps > (
        SELECT avg(NumOfEmps)
        FROM vwAllDeptSumm
        );

--QUESTION 10.A--Use the GRANT statement to allow another student (Neptune account) to retrieve data for your
--employees table and to allow them to retrieve,insert and update data in your departments table. Show proof

--Question 10.A Solutions--
GRANT SELECT ON employees TO PUBLIC;
GRANT INSERT ON departments TO PUBLIC;
GRANT UPDATE ON departments TO PUBLIC;

--QUESTION 10.B-- Use the REVOKE statement to remove permission for that student to insert and update data 
--in your departments table

--Question 10.B Solutions--
REVOKE INSERT ON departments FROM PUBLIC;
REVOKE UPDATE ON departments FROM PUBLIC;