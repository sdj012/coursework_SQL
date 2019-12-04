-----------------------------------------------------------------------------------
-- Name: Salley Jeong
-- ID: 111894150
-- Date: Feb 17th 2019
-- Purpose: Submission for Lab 6 DBS301
-- Description: This file includes SQL scripts that apply the sub-query method
------------------------------------------------------------------------------------
--Question 1--
--Add yourself as an employee with a NULL salary, 0.21 commission_pct, in department 90,and Manager 100. You started TODAY.  

--Q1 SOLUTION--

INSERT INTO employees (employee_id,first_name,last_name,email,commission_pct, department_id,manager_id,hire_date,job_id)
    VALUES (0,'Salley','Jeong','abc',0.21,90,100,to_date('17022019','ddmmyyyy'),0);
    
--Question 2--
--Create an Update statement to: Change the salary of the employees with a last name of Matos and Whalen to be 2500.

--Q2 SOLUTION--

UPDATE employees
    SET salary = 2500
    WHERE last_name LIKE ('Matos') OR last_name LIKE ('Whalen');
    
--Question 3--
--Display the last names of all employees who are in the same department as the employee named Abel.

--Q3 SOLUTION--

SELECT last_name
    FROM employees
    WHERE department_id IN(
    
        SELECT department_id
        FROM employees
        WHERE last_name LIKE ('Abel')
);

--Question 4--Display the last name of the lowest paid employee(s)

--Q4 SOLUTION--

SELECT last_name
    FROM employees
    WHERE salary IN(
    
        SELECT min(salary)
        FROM employees
        );
        
--Question 5--Display the city that the lowest paid employee(s) are located in.

--Q5 SOLUTION--

SELECT city
    FROM locations
    WHERE location_id IN(

    SELECT location_id
        FROM departments
        WHERE department_id IN(
        
        SELECT department_id
            FROM employees
            WHERE last_name IN(
        
            SELECT last_name
                FROM employees
                WHERE salary IN(
            
                SELECT min(salary)
                    FROM employees)
            )
        )
    );
            
--Question 6--Display the last name, department_id, and salary of the lowest paid employee(s) in each department.  Sort by Department_ID. (HINT: careful with department 60)

--Q6 SOLUTION--

SELECT last_name,department_id,salary
    FROM employees
    WHERE salary IN(
    
        SELECT min(salary)
            FROM employees
            GROUP BY department_id
        );
       
--Question 7--Display the last name of the lowest paid employee(s) in each city

--Q7 SOLUTION--

SELECT last_name
    FROM employees
    WHERE salary in(

        SELECT min(salary)
        FROM employees JOIN departments USING (department_id)
        JOIN locations USING (location_id)
        GROUP BY city
        );

--Question 8--Display last name and salary for all employees who earn less than the lowest salary in ANY department.  Sort the output by top salaries first and then by last name.

--Q8 SOLUTION--

SELECT last_name, salary
    FROM employees
    WHERE salary < ANY(

            SELECT min(salary)
            FROM employees
            WHERE salary IS NOT NULL
            GROUP BY department_id
        )
        
    ORDER BY salary DESC, last_name;
            
--Question 9--Display last name, job title and salary for all employees whose salary matches any of the salaries from the IT Department. Do NOT use Join method.  Sort the output by salary ascending first and then by last_name

--Q9 SOLUTION--
SELECT last_name AS "Last Name",
        job_id AS "Job Title",
        salary AS Salary
    FROM employees
    WHERE salary IN (
    
        SELECT salary
            FROM employees
            WHERE job_id LIKE upper('IT%')
    )
    
    ORDER BY salary ASC, last_name;
    
--END OF FILE --