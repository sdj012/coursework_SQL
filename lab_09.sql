-----------------------------------------------------------------------------------
-- Date: March 25th 2019
-- Purpose: Submission for Lab 9 DBS301
-- Description: This file includes SQL scripts that apply Data Definitional Language 
--(Create and Alter) and DML (Data Manipulation Language).
------------------------------------------------------------------------------------

--QUESTION 1--Create table L09SalesRep and load it with data from table EMPLOYEES table. 
--Use only the equivalent columns from EMPLOYEE as shown below and only for people in department 80.

--Q1 Solution--

CREATE TABLE L09SalesRep AS (
    SELECT employee_id AS RepId,
        first_name AS FName,
        last_name AS LName,
        phone_number AS Phone#,
        salary AS Salary,
        commission_pct AS Commission
        FROM employees
        WHERE department_id = 80);
        
--QUESTION 2--Create L09Cust table

--Q2 Solution--

CREATE TABLE L09Cust (

    Cust# number(6),
    CustName varchar2(30),
    City varchar2(20),
    Rating char(1),
    Comments varchar2(200),
    SalesRep# number(7)
);

INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) 
    VALUES (501, 'ABC LTD.','Montreal','C',201);
    
INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) 
    VALUES (502, 'Black Giant','Ottawa','B',202);

INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) 
    VALUES (503, 'Mother Goose','London','B',202);

INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) 
    VALUES (701, 'BLUE SKY LTD','Vancouver ','B',102);

INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) 
    VALUES (702, 'MIKE and SAM Inc.','Kingston','A',107);

INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) 
    VALUES (703, 'RED PLANET ','Mississauga','C',107);

INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) 
    VALUES (717, 'BLUE SKY LTD ','Regina','D',102);


--QUESTION 3--Create L09GoodCust

--Q3 Solution--

CREATE TABLE L09GoodCust AS (
    SELECT Cust# AS CustID,
    CustName AS Name,
    City AS Location,
    SalesRep# AS RepId
    FROM L09Cust
    WHERE rating LIKE ('A') OR rating LIKE ('B')
);

INSERT INTO L09GoodCust (custid, name, location, repid)
    VALUES (502, 'Black Giant','Ottawa',202);

INSERT INTO L09GoodCust (custid, name, location, repid)
    VALUES (503, 'Mother Goose','London',202);

INSERT INTO L09GoodCust (custid, name, location, repid)
    VALUES (504, 'BLUE SKY LTD','Vancouver',202);

INSERT INTO L09GoodCust (custid, name, location, repid)
    VALUES (701, 'MIKE and SAM inc.','Kingston',10);

--QUESTION 4-- Now add new column to table L09SalesRep called JobCode that will be of variable character type with max length 
--of 12. Do a DESCRIBE L09SalesRep to ensure it execute

--Q4 Solution--

ALTER TABLE L09SalesRep
ADD JobCode varchar2(12);

--QUESTION 5.1--Declare column Salary in table L09SalesRep as mandatory one and Column Location in table L09GoodCust as optional
--one. You can see location is already optional.

--Q5.1 Solution--

ALTER TABLE L09SalesRep
MODIFY Salary NOT NULL;

--QUESTION 5.2--Lengthen FNAME in L09SalesRep to 37. The result of a DESCRIBE should show it happening
--ALTER TABLE L09SalesRep
--MODIFY COLUMN FName varchar2(37);
 
--You can only decrease the size or length of Name in L09GoodCust to the maximum length of data already stored.
--Do it by using SQL and not by looking at each entry and counting the characters. May take two SQL statements

--QUESTION 6--Now get rid of the column JobCode in table L09SalesRep in a way that will not affect daily performance. 
--Q6 Solution--

ALTER TABLE L09SalesRep
DROP COLUMN JobCode;

--QUESTION 7--Declare PK constraints in both new tables, RepId and CustId--
--Q7 Solution--

ALTER TABLE L09SalesRep ADD CONSTRAINT pk_repId PRIMARY KEY (RepId);
ALTER TABLE L09Cust ADD CONSTRAINT pk_custId PRIMARY KEY (cust#);

--QUESTION 8--Declare UK constraints in both new tables, Phone# and Name--

ALTER TABLE L09SalesRep ADD CONSTRAINT uk_phone# UNIQUE (phone#);
ALTER TABLE L09Cust ADD CONSTRAINT uk_name UNIQUE (custname);

--QUESTION 9--Restrict amount of Salary column to be in the range [6000, 12000] and Commission to be not more than 50%.--

ALTER TABLE L09SalesRep
ADD CONSTRAINT CHK_Salary CHECK (Salary>=6000 AND Salary <=12000 AND Commission <=0.5);

--QUESTION 10--Ensure that only valid RepId numbers from table L09SalesRep may be entered in the table L09GoodCust.--
--Why this statement has failed?





--QUESTION 11--Firstly write down the values for RepId column in table L09GoodCust and then make all these values blank. 
--Now redo the question 10. Was it successful? 




--QUESTION 12--Disable this FK constraint now and enter old values for RepId in table L09GoodCust and save them. 
--Then try to enable your FK constraint. What happened? 




--QUESTION 13--Get rid of this FK constraint.
--Then modify your CK constraint from question 9 to allow Salary amounts from 5000 to 15000.




--QUESTION 14--Describe both new tables L09SalesRep and L09GoodCust and then show all constraints for these two tables by 
--running the following query:

--SELECT  constraint_name, constraint_type, search_condition, table_name
--    FROM     user_constraints
--    WHERE table_name IN (' L09SalesRep',' L09GoodCust')
--    ORDER  BY  4 , 2


