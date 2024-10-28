#HAVING CLAUSE IN SQL
#Having clause in sql operates on grouped records and returns 
#rows where aggregate function results matched with given conditions only
#having and where clause are kind of simillar but where clause can't be used with agregette functions

#AGGREGATE FUNCTION
#An aggregate function performs a calculation on a set of values and 
#returns a single value

#SYNTAX
#SELECT COLUMN_NAME FROM TABLE_NAME WHERE CONDITION GROUP BY COLUMN_NAMES
# HAVING CONDITION ORDER BY COLUMN_NAME
 -- -------------------------------------------------------------------------
 
 show databases;
 use sql_intro;
 show tables;
 select * from employees;
 
 # find the depts whose avg salary greater than 70000
 select dept, avg(salary) as avg_salary 
 from employees group by dept having avg(salary) > 70000;
 
 #find cities where total salary is greater than 40000
 select city, sum(salary) as total from employees group by city 
 having sum(salary) > 40000;
 
 #find the cities having more than one employee
 select city, count(*) as emp_count from employees group by city
 having count(*) > 1;
 
 #We can use where clause along with having clause
 #find cities having more than 1 employees apart from mumbai
 select city, count(*) as emp_count from employees where city != 'mumbai' group by city
  having count(*) >1;

#We can also use aggregete fumctions in the having class 
#that doesn't appear in the select clause.
#find total no of employees of each dept that have an avg salary greater than 20000

select dept, count(*) as emp_count from employees group by dept
having avg(salary) > 20000;   -- selected column that is not present in select statement



 
 
 