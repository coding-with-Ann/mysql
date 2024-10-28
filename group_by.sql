#GROUP BY STATEMENT IN SQL
#THE GROUP BY STATEMENT GROUPS RECORDS INTO SUMMARY ROWS AND RETURNS ONE RECORD 
#FOR EACH GROUP
#IT GROUPS THE ROWS WITH THE SAME GROUP BY ITEM EXPRESSION AND COMPUTES
# AGREGETTE FUNCTIONS FOR THE RESULTING GROUPS.
#A group by is a part of select statement
#IN EACH GROUP NO TWO ROWS HAVE THE SAME VALUE FOR THE GROUPING COLUMN OR COLUMNS

#SYNTAX
#select column_names
#from table_names
#where condition
#group by column_names
#order by column_names

show databases;
use sql_intro;

create table employees(emp_id int primary key, emp_name varchar(20), age int, gender 
char(1),doj date, dept varchar(10), city varchar(15), salary float );
describe employees;
insert into employees values(1, 'ben', 35,'M', "2005-1-30", "sales", 'hyd', 20000.00),
							(2, 'kevin', 20, 'M', "1999-6-25","marketing", 'mumbai', 30000.00),
                            (3, 'gwen', 28, 'F', "2022-1-3", 'product', 'chennai', 40000),
                            (4, 'max', 37, 'M', "2022-1-4", 'Tech', 'Hyd', 50000),
                            (5, 'paradox', 32, 'M', "2022-1-5", 'IT', 'banglore', 40000);
select * from employees;
select distinct city from employees;
select avg(age) from employees;

#TO FIND AVG AGE IN EACH DEPT USE GROUP BY CLAUSE

select dept, ROUND(avg(age),1) from employees group by dept;
select dept, sum(salary) from employees group by dept;

#ROUND TAKES TWO PARAMETERS AGE, NO OF DECIMAL PLACES TO ROUND

select count(emp_id), city from employees
group by city
order by count(emp_id) desc;

select year(doj), count(emp_id) from employees group by year(doj);

#WE CAN ALSO USE GROUP BY TO JOIN TWO OR MORE TABLES TOGETHER
create table sales(product_id int, selling_price float, 
                   quantity int, state varchar(20));
insert into sales values (121,320.0,3,"california"),
				         (121,320.0,6,"Texas"),
                         (123,290.0,2,"Texas"),
                         (123,290.00,8,"colorodo");
select product_id, sum(selling_price * 3) as revenue from sales
group by product_id;

create table c_product(product_id int, cost_price float);

insert into c_product values(121, 270.0),
							(123, 250.0);
select c.product_id, sum((s.selling_price - c.cost_price)*s.quantity) as profit
from sales as s inner join c_product as c 
where s.product_id = c.product_id 
group by c.product_id;                     


		