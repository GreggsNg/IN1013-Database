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
-- 7.	How much money has the restaurant taken? Change the name of the output column to 'Income'.
SELECT SUM(bill_total) AS "Income"
FROM restBill;
-- 8.	How much money did the restaurant take in February 2016? Change the name of the output column to 'Feb Income'.
SELECT SUM(bill_total) AS Feb Income
FROM restbill
WHERE bill_date BETWEEN 160201 AND 160300;
-- 9.	List the names of the waiters who have served the customer Tanya Singh.
SELECT waiter_no, first_name, surname
FROM restBill
JOIN reststaff ON restRoom_management.headwaiter = restStaff.staff_no
WHERE cust_name = "Tany Singh"
-- 10.	On which dates in February 2016 did the Headwaiter 'Charles' manage the 'Green' room? You may output dates in the format they are stored.
SELECT room_date
FROM restRoom_management
JOIN restStaff ON restRoom_management.headwaiter = restStaff.staff_no
WHERE first_name = "Charles" AND room_name = "Green" and room_date BETWEEN 160201 AND 160300;
-- 11.	List the names of the waiters who serve tables in the same team as the waiter Zoe Ball.
SELECT first_name, surname
FROM restStaff AS p
JOIN reststaff AS l p.headwaiter = l.headwaiter
WHERE l.first_name = "Zoe" AND l.surename = "Ball" AND p.staff_no <> l.staff_no;
-- 12.	List the customer name, the amount they spent and the waiter’s name for all bills. Order the list by the amount spent, highest bill first.
SELECT cust_name, bill_total, s.first_name  ||' '||  s.surname AS waiter_name
FROM restBill
JOIN restStaff AS s ON restBill.waiter_no = s.staff_no
ORDER BY bill_total DESC;
-- 13.	List the names of customers who spent more than 450.00 on a single bill on occasions when ‘Charles’ was their Headwaiter.
SELECT cust_name
FROM restBill AS b
JOIN restRoom_management AS rm ON b.bill_date = rm.room_date
JOIN restStaff AS hs ON rm.headwaiter = hs.staff_no
WHERE b.bill_total > 450.00 AND hs.first_name = 'Charles';
-- 14.	A customer called Nerida has complained that a waiter was rude to her when she dined at the restaurant on the 11th January 2016. What is the name of the Headwaiter who will have to deal with the matter?
SELECT hs.first_name, hs.surname
FROM restRoom_management AS rm
JOIN restStaff AS hs ON rm.headwaiter = hs.staff_no
WHERE rm.room_name = 'Green' AND rm.room_date = 160111;
-- 15.	What is the name of the customer with the smallest bill? List only one name in your answer.
SELECT cust_name
FROM restBill
ORDER BY bill_total ASC
LIMIT 1;
-- 16.	Which waiters have taken 2 or more bills on a single date? List the waiter names, the dates and the number of bills they have taken.
SELECT s.first_name, s.surname, b.bill_date, COUNT(b.bill_no) AS bill_count
FROM restBill AS b
JOIN restStaff AS s ON b.waiter_no = s.staff_no
GROUP BY s.staff_no, b.bill_date
HAVING COUNT(b.bill_no) >= 2;
-- 17.	List the rooms with tables that sit more than 6 people and how many of such tables they have.
SELECT room_name, COUNT(*) AS num_tables
FROM restRest_table
WHERE no_of_seats > 6
GROUP BY room_name;
-- 18.	List the names of the rooms and the total amount taken on bills in each room.
SELECT rt.room_name, SUM(b.bill_total) AS total_amount
FROM restBill AS b
JOIN restRest_table AS rt ON b.table_no = rt.table_no
GROUP BY rt.room_name;
-- 19.	List the headwaiter’s name sequence and the total bill amount their waiters have taken. Order the list by total bill amount.
SELECT hs.first_name, hs.surname, SUM(b.bill_total) AS total_bill
FROM restRoom_management AS rm
JOIN restStaff AS hs ON rm.headwaiter = hs.staff_no
JOIN restBill AS b ON b.bill_date = rm.room_date
JOIN restStaff AS s ON b.waiter_no = s.staff_no
WHERE s.headwaiter = hs.staff_no
GROUP BY hs.staff_no
ORDER BY total_bill DESC;
-- 20.	List any customers who have spent, on average, more than £400 each time they have visited the restaurant.
SELECT cust_name
FROM restBill
GROUP BY cust_name
HAVING AVG(bill_total) > 400;
-- 21.	Which waiters have taken 3 or more bills on a single date? List the waiter names and the number of bills they have taken.
SELECT s.first_name, s.surname, b.bill_date, COUNT(b.bill_no) AS bill_count
FROM restBill AS b
JOIN restStaff AS s ON b.waiter_no = s.staff_no
GROUP BY s.staff_no, b.bill_date
HAVING COUNT(b.bill_no) >= 3;
-- 22.	List the names of any waiters who have not taken any bills.
SELECT first_name, surname
FROM restStaff
WHERE staff_no NOT IN (SELECT waiter_no FROM restBill);
-- 23.	Which customer has had the largest single bill? List the customer name, and the headwaiter and room name where they were served on that occasion.
SELECT b.cust_name, hs.first_name AS headwaiter_fname, hs.surname AS headwaiter_sname, rt.room_name
FROM restBill AS b
JOIN restRest_table AS rt ON b.table_no = rt.table_no
JOIN restRoom_management AS rm ON rm.room_name = rt.room_name AND b.bill_date = rm.room_date
JOIN restStaff AS hs ON rm.headwaiter = hs.staff_no
WHERE b.bill_total = (SELECT MAX(bill_total) FROM restBill);