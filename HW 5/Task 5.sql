Task 5. Groups.

--1.	Which waiters have taken 2 or more bills on a single date? List the waiter names and surnames, the dates and the number of bills they have taken.

SELECT s.first_name, s.surname, rb.bill_date, COUNT(rb.bill_no) AS num_bills -- Select waiter details, date, and count of bills
FROM restBill rb -- From the restBill table
JOIN restStaff s ON rb.waiter_no = s.staff_no -- Join with restStaff to get waiter names
GROUP BY s.first_name, s.surname, rb.bill_date -- Group by waiter name and date
HAVING COUNT(rb.bill_no) >= 2; -- Only include groups where the waiter took 2 or more bills

--2.	List the rooms with tables that can server more than 6 people and how many of such tables they have.

SELECT rb.room_name, COUNT(rb.table_no) AS num_tables -- Select room names and count of tables
FROM restRest_table rb -- From the restRest_table table
WHERE rb.no_of_seats > 6 -- Only consider tables that can serve more than 6 people
GROUP BY rb.room_name; -- Group by room name

--3.	List the names of the rooms and the total amount of bills in each room

SELECT rm.room_name, SUM(rb.bill_total) AS total_bill
FROM restBill rb
JOIN restRest_table rt ON rb.table_no = rt.table_no
JOIN restRoom_management rm ON rt.room_name = rm.room_name
GROUP BY rm.room_name;


--4.	List the headwaiter’s name and surname and the total bill amount their waiters have taken. Order the list by total bill amount, largest first.


SELECT h.first_name, h.surname, SUM(rb.bill_total) AS total_bill_amount -- Select headwaiter details and total bill amount
FROM restBill rb -- From the restBill table
JOIN restStaff w ON rb.waiter_no = w.staff_no -- Join with restStaff to find the waiters who served the bills
JOIN restStaff h ON w.headwaiter = h.staff_no -- Join again to find the headwaiter for each waiter
GROUP BY h.first_name, h.surname -- Group by headwaiter name
ORDER BY total_bill_amount DESC; -- Order by total bill amount in descending order

--5.	List any customers who have spent more than £400 on average.

SELECT rb.cust_name, AVG(rb.bill_total) AS avg_bill -- Select customer names and their average bill
FROM restBill rb -- From the restBill table
GROUP BY rb.cust_name -- Group by customer name
HAVING AVG(rb.bill_total) > 400; -- Only include customers with an average bill above 400

--6.	Which waiters have taken 3 or more bills on a single date? List the waiter names, surnames, and the number of bills they have taken.

SELECT s.first_name, s.surname, rb.bill_date, COUNT(rb.bill_no) AS num_bills -- Select waiter details, date, and count of bills
FROM restBill rb -- From the restBill table
JOIN restStaff s ON rb.waiter_no = s.staff_no -- Join with restStaff to get waiter names
GROUP BY s.first_name, s.surname, rb.bill_date -- Group by waiter name and date
HAVING COUNT(rb.bill_no) >= 3; -- Only include groups where the waiter took 3 or more bills