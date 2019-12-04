-----------------------------------------------------------------------------------
-- Date: April 1st 2019
-- Purpose: Submission for Lab 10 DBS301
-- Description: This file includes SQL scripts that apply Transactional SQL 
------------------------------------------------------------------------------------
--Q1.Create table L10Cities from table LOCATIONS, but only for location numbers less than 2000 
--(do NOT create this table from scratch, i.e. create and insert in one statement).
--Q1.Answers--

CREATE TABLE L10Cities AS (
    SELECT location_id,
        street_address,
        postal_code,
        city,
        state_province,
        country_id
        FROM locations
        WHERE location_id < 2000);

--Q2.Create table L10Towns from table LOCATIONS, but only for location numbers less than 1500 
--(do NOT create this table from scratch). This table will have same structure as table L10Cities. 
--Q2.Answers--

CREATE TABLE L10Towns AS (
    SELECT location_id,
        street_address,
        postal_code,
        city,
        state_province,
        country_id
        FROM locations
        WHERE location_id < 1500);

--Q3.Now you will empty your RECYCLE BIN with one powerful command. Then remove your table L10Towns, so that will remain in the recycle bin. Check that it is really there and what time was removed.  Hint: Show RecycleBin,   Purge,  Flashback
--Q3.Answers--
Purge RecycleBin;

DROP TABLE L10TOWNS;

Show RecycleBin;

--Q4.Restore your table L10Towns from recycle bin and describe it. Check what is in your recycle bin now.
--Q4.Answers--
Flashback TABLE L10TOWNS TO BEFORE DROP;

Show RecycleBin;

--Q5.Now remove table L10Towns so that does NOT remain in the recycle bin. 
--Check that is really NOT there and then try to restore it. Explain what happened?
--Q5.Answers--
DROP TABLE L10TOWNS;
Purge RecycleBin;

--Q6.Create simple view called CAN_CITY_VU, based on table L10Cities so that will contain only columns 
--Street_Address, Postal_Code, City and State_Province for locations only in CANADA. Then display all data from this view.
--Q6.Answers--
CREATE VIEW CAN_CITY_VU AS
    SELECT street_address,postal_code,city,state_province
    FROM L10Cities
    WHERE country_id LIKE upper('CA');

SELECT * FROM CAN_CITY_VU;

--Q7.Modify your simple view so that will have following aliases instead of original column names: 
--Str_Adr, P_Code, City and Prov and also will include cities from ITALY as well. Then display all data from this view. 
--Q7.Answers--

CREATE VIEW CAN_CITY_VU AS
    SELECT street_address AS Str_Adr,
        postal_code AS P_Code,
        city AS City,
        state_province AS Prov
    FROM L10Cities
    WHERE country_id LIKE upper('CA') OR country_id LIKE upper('IT');

SELECT * FROM CAN_CITY_VU;


--Q8.Create complex view called vwCity_DName_VU, based on tables LOCATIONS and DEPARTMENTS, so that will contain only columns 
--Department_Name, City and State_Province for locations in ITALY or CANADA. Include situations even when city 
--does NOT have department established yet. Then display all data from this view.
--Q8.Answers--
CREATE VIEW vwCity_DName_VU AS
    SELECT department_name AS "Department Name",
        city AS City,
        state_province AS Prov
    FROM locations LEFT OUTER JOIN departments USING (location_id)
    WHERE country_id LIKE upper('CA')OR country_id LIKE upper('IT');
    
SELECT * FROM vwCity_DName_VU;


--Q9.Modify your complex view so that will have following aliases instead of original column names:
--DName, City and Prov and also will include all cities outside United States
--Include situations even when city does NOT have department established yet. Then display all data from this view.

--Q9.Answers--
ALTER VIEW vwCity_DName_VU AS 
    SELECT department_name AS DName,
        city AS City,
        state_province AS Prov
    FROM locations LEFT OUTER JOIN departments USING (location_id)
    WHERE country_id NOT LIKE upper('US');
    
SELECT * FROM vwCity_DName_VU;

--Q10.Check in the Data Dictionary what Views (their names and definitions) are created so far in your account. 
--Then drop your vwCity_DName_VU and check Data Dictionary again. What is different?
--resource: https://docs.oracle.com/cd/A97630_01/server.920/a96524/c05dicti.htm 

--Q10.Answers--
SELECT object_name, object_type 
    FROM user_objects
    WHERE object_type LIKE upper('VIEW');
    
DROP VIEW vwCity_DName_VU;

--After dropping the view vwCity_DName_VU, it is no longer visible inside the query result
