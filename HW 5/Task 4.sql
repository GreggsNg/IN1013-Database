Task 4. Sub-queries.

--1.	List the names of customers who spent more than 450.00 on a single bill on occasions when ‘Charles’ was their Headwaiter.

SELECT b.cust_name -- Select the names of customers
FROM restBill b -- From the restBill table
WHERE b.bill_total > 450.00 -- Where the bill amount is greater than 450.00
AND b.waiter_no IN ( -- And the waiter who served the bill was managed by:
    SELECT s.staff_no -- Get the staff numbers of all waiters
    FROM restStaff s -- From the restStaff table
    WHERE s.headwaiter = ( -- Where their headwaiter is:
        SELECT staff_no -- Get the staff number of the Headwaiter
        FROM restStaff
        WHERE first_name = 'Charles' -- Who has the first name 'Charles'
    )
);

--2.	A customer called Nerida has complained that a waiter was rude to her when she dined at the restaurant on the 11th January 2016. What is the name and surname of the Headwaiter who will have to deal with the matter?

SELECT first_name , surname
FROM restStaff
WHERE staff_no = (
  SELECT headwaiter
  FROM restStaff
  WHERE staff_no =(
    SELECT waiter_no
    FROM restBill
    WHERE cust_name = 'Nerida '
    AND bill_date = 160111
  )
);
--3.	What are the names of customers with the smallest bill?

SELECT rb.cust_name
FROM restBill rb
WHERE rb.bill_total = (
  SELECT Min(bill_total)
  FROM restBill
  );
--4.	List the names of any waiters who have not taken any bills.

SELECT s.first_name, s.surname -- Select the first and last names of waiters
FROM restStaff s -- From the restStaff table
WHERE s.staff_no NOT IN ( -- Where their staff number is not in:
    SELECT DISTINCT waiter_no -- The list of waiters who served bills
    FROM restBill -- From the restBill table
);

--5.	Which customers had the largest single bill? List the customer name, the name and surname of headwaiters, and the room name where they were served on that occasion.

SELECT rb.cust_name, s.first_name AS headwaiter_first, s.surname AS headwaiter_surname, rm.room_name
FROM restBill rb -- From the restBill table
JOIN restStaff w ON rb.waiter_no = w.staff_no -- Join to find the waiter who served the bill
JOIN restStaff s ON w.headwaiter = s.staff_no -- Join again to find the headwaiter of that waiter
JOIN restRoom_management rm ON rm.headwaiter = s.staff_no -- Join to find the room managed by the headwaiter
WHERE rb.bill_total = ( -- Where the bill total equals:
    SELECT MAX(bill_total) -- The largest bill amount
    FROM restBill -- From all bills
);