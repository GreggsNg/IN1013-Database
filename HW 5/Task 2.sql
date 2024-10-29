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
