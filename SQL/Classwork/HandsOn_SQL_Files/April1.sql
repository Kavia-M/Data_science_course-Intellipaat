CREATE DATABASE Sales;

USE Sales;

CREATE TABLE salespeople (
snum INT NOT NULL,
sname VARCHAR(30) NOT NULL,
city VARCHAR(30) NOT NULL,
comm DECIMAL(4,2) NOT NULL,
PRIMARY KEY (snum)
);

INSERT INTO salespeople VALUES (1001, 'Peel', 'London', 0.12);

INSERT INTO salespeople VALUES (1002, 'Serres', 'San Jose', 0.13);
INSERT INTO salespeople VALUES (1004, 'Motika', 'London', 0.11);
INSERT INTO salespeople VALUES (1007, 'Rifkin', 'Barcelona', 0.15);
INSERT INTO salespeople VALUES (1003, 'AxelRod', 'New York', 0.10);
INSERT INTO salespeople VALUES (1005, 'Fran', 'London', 0.26);


CREATE TABLE customer (
cnum INT NOT NULL,
cname VARCHAR(30) NOT NULL,
city VARCHAR(30) NOT NULL,
rating int not null,
snum int NOT NULL,
PRIMARY KEY (cnum),
FOREIGN KEY (snum) REFERENCES salespeople(snum)
);

INSERT INTO customer VALUES (2001, 'Hoffman', 'London',100, 1001);

INSERT INTO customer VALUES (2002, 'Hoffman', 'London',100, 1010);

INSERT INTO customer VALUES (2002, 'Giovanni', 'Rome',200, 1003);
INSERT INTO customer VALUES (2003, 'Liu', 'San Jose',200, 1002);
INSERT INTO customer VALUES (2004, 'Grass', 'Berlin',300, 1002);
INSERT INTO customer VALUES (2006, 'Clemens', 'London',100, 1001);
INSERT INTO customer VALUES (2008, 'Cisneros', 'San Jose',300, 1007);
INSERT INTO customer VALUES (2007, 'Pereira', 'Rome',100, 1004);


CREATE TABLE orders (
onum INT NOT NULL,
amt DECIMAL(7,2) NOT NULL,
odate Date NOT NULL,
cnum int NOT NULL,
PRIMARY KEY (onum),
FOREIGN KEY (cnum) REFERENCES customer(cnum)
);
INSERT INTO orders VALUES (3001, 18.69, '1996-03-10', 2008);


INSERT INTO orders VALUES (3003, 767.19, '1996-03-10', 2001);
INSERT INTO orders VALUES (3002, 1900.19, '1996-03-10', 2007);
INSERT INTO orders VALUES (3005, 5160.45, '1996-03-10', 2003);
INSERT INTO orders VALUES (3006, 1098.16, '1996-03-10', 2008);
INSERT INTO orders VALUES (3009, 1713.23, '1996-04-10', 2002);
INSERT INTO orders VALUES (3007, 75.75, '1996-04-10', 2002);
INSERT INTO orders VALUES (3008, 4723.00, '1996-05-10', 2006);
INSERT INTO orders VALUES (3010, 1309.95, '1996-06-10', 2004);
INSERT INTO orders VALUES (3011, 9891.88, '1996-06-10', 2006);

select * from Salespeople;
select * from customer;
select * from orders;


select * from customer join salespeople on customer.snum = salespeople.snum;

select * from customer c join salespeople s on c.snum = s.snum;

select * from customer c right outer join salespeople s on c.snum = s.snum;

select * from salespeople s join customer c on s.snum = c.snum;

select * from Salespeople;
select * from customer;

select * from customer where cnum between 2001 and 2004;

select * from salespeople s left outer join customer c on s.snum = c.snum;

select sname personname from salespeople s;

select c.cnum, cname, sum(amt) as total 
from orders o join customer c
on o.cnum = c.cnum
group by c.cnum, cname
order by total desc;

select * from
salespeople s join customer c
on s.snum = c.snum
join orders o
on o.cnum = c.cnum;

select s.snum, sname, count(onum) as 'Orders count'
from salespeople s left outer join customer c
on s.snum = c.snum
join orders o
on o.cnum = c.cnum
group by s.snum, sname
order by 'Orders count';

-- Queries
-- 1. List all the columns of the Salespeople table.
-- 2. List all customers with a rating of 100.
-- 3. Find all records in the Customer table with NULL values in the city column.
-- 4. Find the largest order taken by each salesperson on each date.
-- 5. Arrange the Orders table by descending customer number.
-- 6. Find which salespeople currently have orders in the Orders table.
-- 7. List names of all customers matched with the salespeople serving them.
-- 8. Find the names and numbers of all salespeople who had more than one customer.
-- 9. Count the orders of each of the salespeople and output the results in descending order.
-- 10. List the Customer table if and only if one or more of the customers in the Customer table are
-- located in San Jose.
-- 11. Match salespeople to customers according to what city they lived in.
-- 12. Find the largest order taken by each salesperson.
-- 13. Find customers in San Jose who have a rating above 200.
-- 14. List the names and commissions of all salespeople in London.
-- 15. List all the orders of salesperson Motika from the Orders table.

select COLUMN_NAME
from information_schema.columns
where table_name = 'salespeople';

select * from customer where rating = 100;

select * from customer where city=NULL;
-- OR
select * from customer where city IS NULL;

select * from orders;

select * from customer;

select * from salespeople;

select o.onum as 'onum of largest order', s.snum, sname, o.odate, max(amt) as 'amount of largest order' 
from orders o join customer c
on o.cnum = c.cnum
join salespeople s
on c.snum = s.snum
group by s.snum, s.sname, o.odate, o.onum
order by s.snum;

-- 5. Arrange the Orders table by descending customer number.
select * from orders group by onum order by cnum desc;

-- 6. Find which salespeople currently have orders in the Orders table.
select s.snum, s.sname
from orders o join customer c
on o.cnum = c.cnum
join salespeople s
on c.snum = s.snum;

-- 7. List names of all customers matched with the salespeople serving them.
select c.cnum, c.cname, s.snum, s.sname
from customer c join salespeople s
on c.snum = s.snum;

-- 8. Find the names and numbers of all salespeople who had more than one customer.
select s.snum, s.sname
from customer c join salespeople s
on c.snum = s.snum
group by s.snum, s.sname
having count(c.cnum) > 1;

-- 9. Count the orders of each of the salespeople and output the results in descending order.
select s.snum, s.sname, count(o.onum)
from orders o join customer c
on o.cnum = c.cnum
join salespeople s
on c.snum = s.snum
group by s.snum, s,sname
order by o.onum desc;

ALTER TABLE CUSTOMER add total_sales decimal(10,2) NULL;

select * from customer;

select * from orders where cnum=2001;

UPDATE customer
SET total_sales = (
    SELECT SUM(o.amt)
    FROM orders o
    WHERE o.cnum = customer.cnum
);

update customer set total_sales = NULL;

update customer set total_sales = (select sum(amt) from orders where cnum=2001)
where cnum=2001;

update customer set total_sales = (select sum(amt) from orders where cnum=2002)
where cnum=2002;