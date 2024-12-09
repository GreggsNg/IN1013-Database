--1)	Create a view with the name samsBills to allow the waiter Sam Pitt to see the bills he has taken. It should have columns in that order: first_name, surname, bill_date, cust_name, and bill_total.

CREATE VIEW samsBills AS
SELECT 
    rs.first_name,
    rs.surname,
    rb.bill_date,
    rb.cust_name,
    rb.bill_total
FROM 
    restBill rb
JOIN 
    restStaff rs ON rb.waiter_no = rs.staff_no
WHERE 
    rs.first_name = 'Sam' AND rs.surname = 'Pitt';


--2)	Suppose Sam knows a bit of SQL. Write a query using the samsBills view so he can see only bills over £400.

SELECT 
    first_name,
    surname,
    bill_date,
    cust_name,
    bill_total
FROM 
    samsBills
WHERE 
    bill_total > 400;

--3)	Create a view with the name roomTotals to allow management to see how much each room has taken. The columns should be named: room_name and total_sum.

CREATE VIEW roomTotals AS
SELECT 
    rr.room_name,
    SUM(rb.bill_total) AS total_sum
FROM 
    restBill rb
JOIN 
    restRest_table rrt ON rb.table_no = rrt.table_no
JOIN 
    restRoom_management rr ON rrt.room_name = rr.room_name
GROUP BY 
    rr.room_name;

--4)	Create a view with the name teamTotals to allow management to see how much each team has taken. Please concatenate the first name and the surname of the waiter with the space in between. The columns should be named: headwaiter_name and total_sum.

CREATE VIEW roomTotals AS
SELECT 
    rr.room_name,
    SUM(rb.bill_total) AS total_sum
FROM 
    restBill rb
JOIN 
    restRest_table rrt ON rb.table_no = rrt.table_no
JOIN 
    restRoom_management rr ON rrt.room_name = rr.room_name
GROUP BY 
    rr.room_name;
