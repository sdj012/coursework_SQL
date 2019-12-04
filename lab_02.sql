----------------------------------------------------------------
-- Date: Jan 20 2019
-- Purpose: Lab 2 for DBS301
----------------------------------------------------------------

--Question 1-- Display the employee_id, last name and salary of employees earning in the range of $8,000 to $12,000.
--Sort the output by top salaries first and then by last name. 

SELECT employee_id, last_name,salary
   FROM employees
   WHERE salary >=8000 AND salary <=12000
   ORDER BY salary DESC,last_name DESC; 

--Question 2--Modify previous query (#1) so that additional condition is to display only if they work as Programmers or 
--Sales Representatives. Use same sorting as before. 

SELECT employee_id, last_name,salary
   FROM employees
   WHERE salary >=8000 AND salary <=12000 AND upper(job_id)= 'IT_PROG' OR upper(job_id)= 'SA_REP'
   ORDER BY salary DESC,last_name DESC;

--Question 3--Modify previous query (#2) so that it displays the same job titles but for people who earn outside the given 
--salary range from question 1. Use same sorting as before. 

SELECT employee_id, last_name,salary
   FROM employees
   WHERE salary <=8000 OR salary >=12000 AND (upper(job_id)= 'IT_PROG' OR upper(job_id)='SA_REP')
   ORDER BY salary DESC,last_name DESC;

--Question 4--Display the last name, job_id and salary of employees hired before 2018. List by the most recent hire date.

SELECT last_name,job_id,salary,hire_date
   FROM employees
   WHERE hire_date < to_date('2018-01-01','yyyy-dd-mm')
   ORDER BY hire_date DESC;

--Question 5--Modify previous query (#4) so that it displays only employees earning more than $12,000. 
--List the output by job title alphabetically and then by highest paid employees.

SELECT last_name,job_id,salary,hire_date
   FROM employees
   WHERE hire_date < to_date('2018-01-01','yyyy-dd-mm') AND salary >12000 
   ORDER BY job_id ASC, salary DESC;

--Question 6--Display the job titles and full names of employees whose first name contains an ‘e’ or ‘E’ anywhere.

SELECT job_id AS "Job Title", first_name ||' '|| last_name AS "Full name"
   FROM employees
   WHERE lower(first_name) LIKE '%e%';

--Question 7--Create a report to display last name, salary, and commission percent for all employees that earn a commission.

SELECT last_name,salary,commission_pct
   FROM employees
   WHERE commission_pct IS NOT NULL;

--Question 8--Do the same as question 7, but put the report in order of descending salaries.

SELECT last_name,salary,commission_pct
   FROM employees
   WHERE commission_pct IS NOT NULL
   ORDER BY salary DESC;

--Question 9--Do the same as 8, but use a numeric value instead of a column name to do the sorting.


-- END OF FILE --