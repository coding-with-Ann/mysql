#SUBQUERIES
#A subquery is a query in another sql query that is embedded in where clause,
# from clause or having clause
use sql_intro;
select * from employees;
select emp_name, dept, salary from employees where salary >
(select avg(salary) from employees);

use classicmodels;       #classic models database
show tables;
select * from products;
-- ------------------------------
#STORED PROCEDURES
#A STORED PROCEDURE IS AN SQL CODE THAT YOU CAN SAVE AND CAN BE USED AGAIN AND AGAIN
#IF YOU WANT TO USE A CODE AGAIN AND AGAIN STORE IT AS A STORED PROCEDURE AND CALL IT TO REUSE 
use sql_intro;
select * from employees;
delimiter &&
create procedure top_salaries()
begin
select emp_name from employees where salary > 40000;
end &&
delimiter ;
call top_salaries();

#THERE ARE OTHER METHODS THAT YOU CAN USE WHILE CREATING A STORED PROCEDURE

 #USING IN PARAMETER
# WHEN YOU DEFINE IN PARAMETER INSIDE A STORED PROCEDURE THE CALLING PROGRAM
# HAS TO PASS THE ARGUMENT TO THE STORED PROCEDURE

delimiter //
create procedure sp_sortBySalary(in var int)
begin
select emp_name, age salary from employees
order by salary desc limit var;           
end //
delimiter ;
 #limit - to selcet only n no of records
 
call sp_sortBySalary(3);

delimiter //
create procedure update_salary(in temp_name varchar(20), in new_salary float)
begin
update employees set
salary = new_salary where emp_name = temp_name;
end; //

call update_salary('gwen', 50000);
select * from employees;

#SP USING OUT PARAMETER
delimiter //
create procedure sp_CountEmployees(out Total_Emps int)
        #out - output total_emps is returened from the stored procedure 
begin
select count(emp_name) into Total_Emps from employees  #into ****
      # into total_emps -- to link total_emps so that it will be returned to stored procedure
where gender = 'F';
end //
delimiter ;

call sp_CountEmployees(@F);
select @F as female_emps;

-- -----------------------------------------
#TRIGGERS IN SQL
-- -----------------------------------------
#THERE ARE THREE TYPES OF TRIGGERS 
#DATA MANIPULATION TRIGGERS 
#DATA DEFINITION TRIGGERS 
#LOGON TRIGGERS

#drop trigger trigger_name; to delete a trigger
-- ------------------------------------------------

#VIEWS IN SQL
#VIEWS ARE VIRTUAL TABLES THAT DO NOT STORE ANY DATA OF THEIR
# OWN BUT DISPlAY DATA STORED IN OTHER TABLES

USE sql_intro;
select * from employees;

create view employ_details
as                                #as *****
select emp_name, age, city
from employees;
select * from employ_details;

#VIEWS USING JOINS
#WE JOIN TWO DIFFERENT TABLES USING JOINS AND CREATE A VIEW.
show tables;
select * from employees;
create table productlines(productLine varchar(20), 
                          textdescription varchar(20), city varchar(20));
insert into productlines values('classic cars', 'for car enthusiast', 'hyd'),
							  ('Motorcycles', 'our motorCycles','mumbai'),
                              ('planes', 'unique, diecast','chennai'),
                              ('ship', 'Large shps','Hyd'),
                              ('spaceship', 'unique to travel', 'bangalore');
select * from productlines;

create view emp_description
as 
select emp_name,age,gender,textdescription from employees as e
inner join productlines as pl
on e.city = pl.city;

select * from emp_description;

#TO RENAME VIEW
rename table emp_description 
to employ_description;
select * from employ_description;

#TO SEE ALL VIEWS
show full tables where table_type = 'VIEW';    # view in capitals *****
#TO Delete A VIEW 
#drop view view_name ;
---------------------------------------------------------------

#WINDOWS FUNCTIONS
#Windows functions in mysql are useful applications
#in solving analytical problems
#Windows functions were incorporated in mysql in 8.0 version

use sql_intro;
select * from employees;

#we are going to find the combined salary of all employes in each dept
#we will partition our table by departments and print the total salary
#and this we are going to do using some windows functions

select emp_name, age, dept,
sum(salary) over (partition by dept) as total_salary
from employees;

#ROW NUMBER
#ROW NUMBER FUNVTION GIVES A SEQUENTIAL INTEGER 
#TO EVERY ROW WITHIN ITS PARTITION 

select row_number() over(order by salary) as row_num,
emp_name, salary from employees order by salary;

#Row number function can also be used to find duplicate values in a table

create table demo(st_id int, st_name varchar(20)); 
insert into demo values(101, 'shane'),
					   (102, 'bradly'),
					   (103,'Herath'),
					   (103,'Herath'),
                       (104,'Nathan'),
                       (105,'kevin');
select * from demo;

SELECT st_id, st_name, row_number()
over (partition by st_id, st_name order by st_id) as rownum
from demo;

#RANK FUNCTION
#The rank function assigns a rank to a particular column
#There are gaps in the sequence of rankvalues
#when two or more rows have the same rank

create table demo1(var_a int);

insert into demo1 
values(101),(102),(103),(103),(104),(105),(106),(106),(107);
select var_a, rank() over(order by var_a) as test_rank
from demo1; 

#

#FIRST VALUE()
#This function returns the value of the spectified expression
# with respect to the first row in the window frame

select emp_name, age, salary, first_value(emp_name)
over (order by salary desc) as highest_salary
from employees;  

#you can also use first_value function over the partition
#to display employ name who has the highest salary in each department 
select emp_name, dept, salary, first_value(emp_name)
 over(partition by dept order by salary desc) as highest_salary 
from employees;  
