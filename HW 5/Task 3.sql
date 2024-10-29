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