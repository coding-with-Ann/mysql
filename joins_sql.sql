#JOINS IN SQL
#Joins is used to Fetch data present in multiple tables.
# SQL Join statement is used to combine rows of data from two or more tables based
# on a common column(field) between them.
# Different types of Joins are as follows: 


-- INNER JOIN − returns common records from the both tables.

-- LEFT JOIN − returns all records from the left table and matching rows from the right table.

-- RIGHT JOIN − returns all records from the right table and matching rows from the left table.

-- FULL JOIN − returns all records when there is a match in either left or right tables.

-- SELF JOIN − is used to join a table to itself as if the table were two tables, 
-- temporarily renaming at least one table in the SQL statement.

-- FULL OUTER JOIN - SQL FULL OUTER JOIN STATEMENT RETURNS ALL THE ROWS WHEN 
-- THERE IS A MATCH IN EITHER LEFT OR RIGHT TABLE
#MYSQL WORKBENCH DOES'NT SUPPORT FULL OUTER JOIN BY DEFAULT BUT THERES A
#WAY TO DO IT
----------------------------------------------------------------------------------------
create database sql_joins;
show databases;
use sql_joins;
create table cricket(cricket_id int auto_increment,
name varchar(20), primary key(cricket_id));
#USED AUTO INCREMENT BECAUSE CRICKET_ID IS PRIMARY KEY   *******

create table football(football_id int auto_increment,
name varchar(20), primary key(football_id));

insert into cricket (name) values 
('stuart'), ('michael'), ('johnson'),('Hayden'), ('Fleming');
#inserted only names, id is auto incremented from 1  *******
 
select * from cricket;

insert into football (name) values
('stuart'), ('johnson'),('Hayden'), ('ronaldo'), ('mercy');
select * from football;

#INNER JOINS
#to find players that are part of both cricket and football team use INNER JOIN
select * from cricket as c inner join
football as f on c.name = f.name;      ---- on c.cricket = f.football ----
#RETURNS PLAYERS WITH SAME NAME FROM BOTH TABLES

#You can also write this as 
select c.cricket_id, c.name, f.football_id, f.name
from cricket as c inner join football as f on c.name = f.name;

#You can also write this as 
select c.cricket_id, c.name, f.football_id, f.name
from cricket as c inner join football as f using (name);  #***using()

use classicmodels;
select * from products;
select * from productlines;
#suppose if we want to find product code, product name and 
#text description for each product, u can join two tables 

select productcode, productname, textdescription
from products 
inner join productlines
using(productline);

#to find revenue generated from each product and status of product we hav e to join
# orders, orderdetails and products tables

select * from orders;
select * from orderdetails;

select o.ordernumber, o.status, 
sum(quantityordered * priceeach) as revenue
from orders as o
inner join orderdetails as od on 
o.ordernumber = od.ordernumber inner join
products as p on p.productcode = od.productcode
group by ordernumber;

#LEFT JOINS
#SYNTAX 
#select <field name> from table_A left joins table_B on A.key = B.key
select * from customers;
select * from orders;
select c.customernumber, c.customername, ordernumber, status
from customers as c 
left join orders as o
on c.customernumber = o.customernumber; 

#RIGHT JOINS
#SYNTAX
# slect <field name> from table_A right joins table_B on A.key = B.key
select * from customers;
select * from employees;
select c.customername, c.phone, e.employeenumber, e.email
from customers as c right join employees as e
on e.employeenumber = c.salesrepemployeenumber
order by employeenumber;

#SELFJOIN   #***
select * from employees;
select concat(m.lastname,',', m.firstname)as manager,
concat(e.lastname, ', ', e.firstname) as employee
from employees as e
inner join employees as m on           #INNER JOIN****
m.employeenumber = e.reportsto
order by manager;

#FULL JOIN
#SELECT <FIELD LIST> FROM TABLE A FULL OUTER JOIN TABLE B
#ON A.KEY = B.KEY;
#THIS STATEMENT WORKS ON OTHER SQL DATABASES LIKE MS SQL SERVER 
#BUT WONT WORK ON MYSQL
#TO USE IN MYSQL WE WILL FIRST USE A LEFT JOIN THEN A RIGHT JOIN AND FINAALY
#WE USE A UNION OPERATOR

select c.customername, o.ordernumber
from customers as c left join 
orders as o on
c.customernumber = o.customernumber
union
select c.customername, o.ordernumber
from customers as c right join 
orders as o on
c.customernumber = o.customernumber;


