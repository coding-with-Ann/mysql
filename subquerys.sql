#SUBQUERYS IN MYSQL
#A subquery is a select query that is enclosed inside another query. The inner select query
#is usually used to determine the results of the outer select query.
#whatever is present inside the brackets is called inner query and whatever is present 
#outside the brackets is called outer query
#First inner query is executed and return results to the outer query then, the outer query
#is executed

#TYPES OF SUBQUERYS
#SUBQUERYS WITH SELECT STATEMENT
#SUBQUERYS WITH UPDATE STATEMENT
#SUBQUERY WITH DELETE STATEMENT
#SUBQUERY WITH INSERT STATEMENT
-- ----------------------------------------------------------------------------
#SUBQUERY WITH SELECT STATEMENT
#SYNTAX
#select column_name from table where column_name operator(select column_name 
#															from table where)

# Write a sql query to display the max salary from employees table. 
show databases;
use sql_intro;
show tables;
select * from employees;
select dept from employees where salary = (select max(salary) from employees);

#find name of the employee with max salary
select emp_name from employees where salary = (select max(salary) from employees);
-- -----------------------------
#SUBQUERY WITH INSERT STATEMENT
#The insert statement uses the data returned from the subquery to insert into another table
#SYNTAX
#INSERT INTO TABLE_NAME SELECT * FROM TABLE WHERE VALUE OPERATOR (INNER QUERY)
#update subquery

 create table products (product_id int, item varchar(20), 
                        sell_price float, product_type varchar(20));
insert into products values(101, 'Jewellary', '1000', 'Luxury'),
						   (102, 'T-shirt', 100, 'non luxury'),
                           (103, 'Laptop', 1300, 'luxury'),
                           (104, 'Table', 400, 'non luxury');
select * from products;
create table orders
(order_id int,product_sold varchar(30), selling_price float);

insert into orders select product_id, item, sell_price
from products where product_id in 
(select product_id from products where sell_price > 1000);    #******
select * from orders;
--------------------------

#SUBQUERY WITH UPDATE STATEMENT
#THE SUBQUERY CAN BE USED IN CONJUCTION WITH UPDATE STATEMENT 
#EITHER A SINGLE OR MULTIPLE COLUMNS IN THE TABLE CAN BE UPDATED WHEN 
#USING A SUB QUERY WITH THE UPDATE STATEMENT
#SYNTAX
#UPDATE TABLE SET column_name = new_value 
#WHERE OPERATOR value(SELECT COLUMN_NAME FROM TABLE_NAME)WHERE)

select * from employees;
create table employees_b(emp_id int, emp_name varchar(20), age int, gender 
char(1),doj date, dept varchar(10), city varchar(15), salary float );


insert into employees_b values(101, "jimmy", 35, "m", "2005-05-30", "sales", 'chicago', 70000.0),
							  (102, "shane", 30, "m", '2005-06-30', "IT", "seattle", 55000);

update employees 
set salary = salary * 0.35
where age in (select age from employees_b where age >=31 );
select * from employees;
-- -------------------------------------------------------
#SUBQUERY WITH DELETE STATEMENT
#SYNTAX
#DELETE FROM TABLE_NAME WHERE OPERATOR VALUE(INNER QUERY)

delete from employees
where age in(select age from employees_b where age <=32);
select * from employees;

#we have to use two tables for update and insert using subqueries.