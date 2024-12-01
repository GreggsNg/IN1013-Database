
--1.	List the names of the waiters who have served the customer Tanya Singh.

SELECT s.first_name, s.surname
FROM restStaff s
JOIN restBill b ON s.staff_no = b.waiter_no
WHERE b.cust_name = 'Tanya Singh';

--2.	On which dates in February 2016 did the Headwaiter 'Charles' manage the 'Green' room? The output date should be in the format they are stored.

SELECT rm.room_date
FROM restRoom_management rm
JOIN restStaff s ON rm.headwaiter = s.staff_no
WHERE s.first_name =  'Charles' AND rm.room_name = 'Green' AND rm.room_date  BETWEEN 160201 AND 160230;

--3.	List the names and surnames of the waiters with the same headwaiter as the waiter Zoe Ball.
SELECT s.first_name , s.surname
FROM restStaff s
WHERE s.headwaiter =(
SELECT headwaiter 
FROM restStaff 
WHERE first_name = 'Zoe' AND s.surname = 'Ball');

--4.	List the customer name, the amount they spent and the waiter’s name for all bills. Order the list by the amount spent, highest bill first.
SELECT rb.cust_name , rb.bill_total, s.first_name , s.surname
FROM restBill rb
JOIN restStaff s ON rb.waiter_no = staff_no
ORDER BY rb.bill_total DESC;

--5.	List the names and surnames of the waiters who serve tables that worked in the same team that served bills 00014 and 00017.
SELECT DISTINCT s.first_name, s.surname -- Select unique first and last names of waiters
FROM restStaff s -- From the restStaff table, which contains staff details
WHERE s.headwaiter IN ( -- Find waiters whose headwaiter is one of the following:
    SELECT DISTINCT headwaiter -- Get unique headwaiters
    FROM restStaff -- From the restStaff table
    WHERE staff_no IN ( -- For staff numbers of waiters who served bills 00014 and 00017:
        SELECT waiter_no -- Get the staff number (waiter_no) of waiters
        FROM restBill -- From the restBill table, which links bills to waiters
        WHERE bill_no IN (00014, 00017) -- Only consider bills 00014 and 00017
    )
);

--6.	List the names and surnames of the waiters in the team (including the headwaiter) that served Blue room on 160312.
SELECT DISTINCT s.first_name, s.surname -- Select unique first and last names of staff (waiters and headwaiter)
FROM restStaff s -- From the restStaff table, which contains staff details
WHERE s.staff_no = ( -- Include the headwaiter whose staff number is:
    SELECT headwaiter -- Find the headwaiter responsible
    FROM restRoom_management -- From the restRoom_management table, which records room assignments
    WHERE room_name = 'Blue' -- For the Blue room
    AND room_date = 160312 -- On the date 160312
)
OR s.headwaiter = ( -- Include all waiters who report to the same headwaiter:
    SELECT headwaiter -- Find the headwaiter responsible
    FROM restRoom_management -- From the restRoom_management table
    WHERE room_name = 'Blue' -- For the Blue room
    AND room_date = 160312 -- On the date 160312
);