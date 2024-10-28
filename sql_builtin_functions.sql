show databases; -- shows databases
use mysql;      -- selects a database
show tables;    -- shows the tables present in mysql database
select * from engine_cost; -- displays all the colums in the table
describe engine_cost;  -- to check the structure of the table like field name, data type etc.
create database my_sql; -- to create a datase
drop database my_sql;   -- to delete a database
create database sql_intro;
use sql_intro;


-- data types: int, varchar, float, date, timestamp, blob.


create table emp_details(Name varchar(25), age int, sex char(1),
doj date, city varchar(15), salary float);                        -- creates a table 

-- *** how to change the data types in the table or alter the table

describe emp_details;
insert into emp_details values("Ben", 20, "M", "2022-01-01", "Hyd", 20000.00),
							  ("kevin", 21, "M", "2022-01-02", "Mumbai", 30000),
                              ("gwen", 20, "F", "2022-01-03", "chennai", 40000);
                              -- inserts values into the table we created
                              
select * from emp_details;    -- * is used to see all the columns
select distinct city from emp_details;  -- shows distinct cities from table

select count(Name) from emp_details;  -- shows total no of employ count in the table.
select count(Name) as count_name from emp_details; -- gives alias name to the parameter in count function.

select sum(salary) from emp_details; -- to find sum of salaries
select avg(salary) from emp_details;									 -- to find average use avg function.

select name, age, salary from emp_details;	-- to see the details of specific columns in table
-- -------------------------------------------------------------------------------------------------

--- using where clause ----
#sql has where clause to filter rows based on a particular condition
select * from emp_details where age> 20; 
-- sql has a where clause to filters on a particular condition.
select name, city, sex from emp_details where sex = 'F';

select * from emp_details where city = 'Hyd' or city = 'mumbai';
----- using or operator ----

-- we can also use in operator instead of or
select * from emp_details where city in ('Hyd', 'Mumbai');
-- in operator is used to write multiple conditions.

select * from emp_details where
doj between -2021 and 2022;
--- using between operator, and operator **** ---

select * from emp_details where 
age>20 and sex = 'M';
---- using and operator ----

-- is null and is not null -----
select * from emp_details where age is not null;

---- GROUP BY IN SQL ---
-- The group by statement groups records into summary rows and returns one recored for each group
select sex, sum(salary) as total_salaries from emp_details
group by sex;  
--- *******-------------

----- ORDER BY CLAUSE IN SQL -----
# Order by keyword is used to sort the results in asc or desc order.
select * from emp_details order by salary; --- by default prints salaries in asc order.
select * from emp_details order by salary desc; --- prints salaries in desc order.
-- -------------------------------------------------------------------------------------

--- basic operations using select statement
select (10*20) as multiplication;  --- we can use +, - ,* , /
select length('123'); --- to find length of a  string
select repeat('@', 10); ---- repeats a string n times
select curdate;  -- prints current date
select day(curdate());
select now();  --- gives current date and time
select round(5000.1238,1); #round fn takes two parameters, 
#decimal no and the no of digits you want to see after the decimal point


#String functions

select upper('ben');  -- use lower to convert to lower case.
select character_length('ben') as total_length;

select name, character_length(name) as name_length from emp_details;
-- we can use character_length or char_length, both works
select name, length(name) from emp_details;


select concat("Ben"," is"," a", " anime character");
select reverse('ben');
select reverse(name) from emp_details;
select replace('orange is a vegetable', 'vegetable', 'fruit');
select length(ltrim("    Ben    ")); -- trims the left trailing spaces of string
-- use rtrim to delete right side spaces. use trim to all spaces on left and right
select position("fruit" in "orange is a fruit"); #  returns position of fruit
                                                  #**** in
select ascii('a');


