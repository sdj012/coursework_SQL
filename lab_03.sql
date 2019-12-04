
-- Date: Jan 28 2019
-- Description: 

--Question 1--
--Write a query to display the tomorrow’s date in the following format:January 10th of year 2019

--Q1 SOLUTION--

SELECT to_char(sysdate+1, 'Mon" "dd" of year "yyyy') AS "Tomorrow"
FROM dual;

--Question 2--
--For each employee in departments 20, 50 and 60 display last name,first name, salary, and salary increased by 4% and expressed
--as a whole number.  Label the column “Good Salary”. Also add a column that subtracts the old salary from the new salary and
--multiplies by 12. Label the column "Annual Pay Increase".

--Q2 SOLUTION-- 

SELECT last_name,first_name,round(salary*1.04,0) AS "Good Salary", (salary*1.04-salary)*12 AS "Annual Pay Increase"
    FROM employees
    WHERE department_id=20 OR department_id=50 OR department_id=60;

--Question 3--   
--Write a query that displays the employee’s Full Name and Job Title in the following format:DAVIES, CURTIS is ST_CLERK. 
--Only employees whose last name ends with S and first name starts with C or K.  
--Give this column an appropriate label like Person and Job.  Sort the result by the employees’ last names.

--Q3 SOLUTION-- 

SELECT (last_name|| ', ' || first_name ||' is '||job_id) AS "Person and Job"
FROM employees
WHERE first_name LIKE upper('K%') OR first_name LIKE upper('C%') AND last_name LIKE upper('%S') 
ORDER BY last_name ASC;

--Question4--
--For each employee hired before 2012, display the employee’s last name, 
--hire date and calculate the number of YEARS between TODAY and the date the employee was hired.
--Label the column Years worked.Order your results by the number of years employed. 
--Round the number of years employed up to the closest whole number.

--Q4 SOLUTION-- 

SELECT last_name, hire_date, round(((sysdate-hire_date)/365),0) AS "Years Worked"
FROM employees
ORDER BY "Years Worked";

--Question5--
--Create a query that displays the city names, country codes and state province names, 
--but only for those cities that starts with S and has at least 8 characters in their name.
--If city does not have a province name assigned, then put Unknown Province.  
--Be cautious of case sensitivity! 

--Q5 SOLUTION-- 

SELECT city ,country_id, CASE WHEN state_province IS NULL THEN 'Unknown Province' ELSE state_province END AS state_province
FROM Locations
WHERE city LIKE upper('S_%_%__%_%_%_%_');

--Question 6--
--Display each employee’s last name, hire date, and salary review date, which is the first Thursday after a year of service, 
--but only for those hired after 2017. Label the column REVIEW DAY. 
--Format the dates to appear in the format like:     THURSDAY, August the Thirty-First of year 2018
--Sort by review date

--Q6 SOLUTION-- 

SELECT last_name, hire_date, to_char(next_day((hire_date+365),'Thursday'),'DAY", "Month" the "dd" of year "yyyy')AS "Review Day"
FROM employees
WHERE hire_date >= to_date('2017-01-01','yyyy-mm-dd')
ORDER BY "Review Day";


--END OF FILE--