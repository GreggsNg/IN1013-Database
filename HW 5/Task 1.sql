-- 1.	List the dates and bill totals for customer Bob Crow.
SELECT Bill_date,billtotal,cust_name
FROM restbill  
Where = cust_name = "Bob Crow";
-- 2.	List the names of all customers whose last name is Smith. List each customer only once.
SELECT DISTINCT cust_name
FROM restbill
WHERE cust_name LIKE "% Smith";
-- 3.	List the names of all customers whose second names begin with 'C'. List each customer only once.
SELECT DISTINCT cust_name
FROM restbill
WHERE cust_name LIKE "%C%";
-- 4.	List the names of all the headwaiters.
SELECT first_name, surname
FROM restStaff
WHERE headwaiter IS NULL;
-- 5.	List all the details of bills dated February 2016.
SELECT *
FROM restBill
WHERE bill_date BETWEEN 160201 AND 160231;
-- 6.	List the dates the restaurant took money in 2015. List each date only once
SELECT bill_date
FROM restBill
WHERE bill_date BETWEEN 150101 AND 160000;