-----------------------------------------------------------------------------------
-- Name: Salley Jeong
-- ID: 111894150
-- Date: Feb 11th 2019
-- Purpose: Submission for Lab 5 DBS301
-- Description: This file includes SQL scripts that apply simple and advanced joins
------------------------------------------------------------------------------------
    
--QUESTION 1-- Display the department name, city, street address and postal code for departments sorted by city and department name.

--Q1 SOLUTION--
SELECT department_name, city, street_Address, postal_code

    FROM departments,locations

    ORDER BY city, department_name;
    
--QUESTION 2-- Display full name of employees as a single field using format of Last, First, their hire date, salary, 
--department name and city, only for departments with names starting with an A or S sorted by department name and employee name.  

SELECT last_name||' ' ||first_name AS FullName,hire_date,salary,departments.department_name,locations.city
   
    FROM employees JOIN departments 
    
        ON employees.department_id=departments.department_id
   
        JOIN locations
    
        ON departments.location_id=locations.location_id
        
    WHERE department_name LIKE upper('A%') OR department_name LIKE upper('S%')
        
    ORDER BY department_name,FullName;

--QUESTION 3--Display the full name of the manager of each department in states/provinces of Ontario, New Jersey and Washington along with the department name, city, postal code and province name. 
--Sort the output by city and then by department name. 

--Q3 SOLUTION--

SELECT last_name || ' ' || first_name AS FullName,department_name,city,postal_code,state_province
    FROM Employees JOIN Departments
        
        ON employees.employee_id=departments.manager_id
    
        JOIN locations 
        
        ON departments.location_id=locations.location_id
        
    WHERE state_province LIKE ('Ontario') OR state_province LIKE ('New Jersey') OR state_province LIKE ('Washington')
   
    ORDER BY city, department_name;


--QUESTION 4--Display employee's last name and employee number along with their manager’s last name and manager number. 
--Label the columns Employee, Emp#, Manager, and Mgr# respectively.

--Q4 SOLUTION-

SELECT e1.last_name AS Employee, e1.employee_id AS Emp#,e1.manager_id AS Mgr#, e2.last_name AS Manager

    FROM employees e1 JOIN employees e2
    
        ON e1.manager_id=e2.employee_id;
    

--QUESTION 5--Display the department name, city, street address, postal code and country name for all Departments.
--Use the JOIN and USING form of syntax. Sort the output by department name descending.
    
--Q5 SOLUTION--

SELECT department_name,city,street_address,postal_code,country_name

    FROM departments JOIN locations 
    
    USING (location_id)
    
    JOIN countries
    
    USING (country_id)
    
ORDER BY department_name DESC;
    
--QUESTION 6--Display full name of the employees, their hire date and salary together with their department name, 
--but only for departments which names start with A or S.Use the JOIN and ON form of syntax.
--Sort the output by department name and then by last name.

--Q6 SOLUTION--
    
SELECT first_name||' ' ||last_name AS FullName,hire_date,salary,Departments.department_name
    
    FROM employees JOIN departments
    
        ON employees.department_id=departments.department_id
    
    WHERE department_name LIKE upper('A%') OR department_name LIKE upper('S%')
    
    ORDER BY department_name,last_name;
    
--QUESTION 7-- Display full name of the manager of each department in provinces Ontario, New Jersey and Washington plus department name, city, postal code and province name. 
--Use the JOIN and ON form of syntax.Sort the output by city and then by department name. 

--Q7 Solution--
SELECT last_name || ' ' || first_name AS FullName,department_name,city,postal_code,state_province
   
    FROM Employees JOIN Departments
        
        ON employees.employee_id=departments.manager_id
    
        JOIN Locations 
        
        ON departments.location_id=locations.location_id
        
    WHERE state_province LIKE ('Ontario') OR state_province LIKE ('New Jersey') OR state_province LIKE ('Washington')
   
    ORDER BY city, department_name;


--QUESTION 8--Display the department name and Highest, Lowest and Average pay per each department. 
--Name these results High, Low and Avg. Use JOIN and ON form of the syntax.
--Sort the output so that department with highest average salary are shown first.

--Q8 SOLUTION--

SELECT department_name, MAX(salary) AS High, MIN(salary) AS Low, round(AVG(salary)) AS Avg

    FROM employees JOIN departments
    
        ON employees.department_id=departments.department_id
    
    GROUP BY department_name
    
ORDER BY AVG(salary);

--QUESTION 9--Display the employee last name and employee number along with their manager’s last name and manager number. 
--Label the columns Employee, Emp#, Manager, and Mgr#, respectively.
--Include also employees who do NOT have a manager and also employees who do NOT supervise anyone 

--Q9 SOLUTION--

SELECT e1.last_name AS Employee, e1.employee_id AS Emp#,e1.manager_id AS Mgr#, e2.last_name AS Manager

    FROM employees e1 FULL JOIN employees e2
    
        ON e1.manager_id=e2.employee_id;

----------------------------------------------------------------
-- END OF FILE
----------------------------------------------------------------