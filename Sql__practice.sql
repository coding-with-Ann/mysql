SHOW DATABASES;
create database practice;
use practice;
show tables;

create table prac_table(st_id int primary key, st_name varchar(20),
						city varchar(20), st_marks int);
insert into prac_table values(1, "A", 'vegas', 90), (2, 's', 'LA', 95 ), (3, 'An', 'Texas', 99),
							 (4, 'Ay','TExas', 100);
select * from prac_table;
describe prac_table;

select st_name, st_marks from prac_table;	
select day(now());
select curdate();

select distinct st_name from prac_table;
select avg(st_marks) as avg_marks from prac_table;
select count(st_name) from prac_table; 
select length(St_name) from prac_table;
select reverse('city');
select reverse(city) from prac_table;
select replace('orange is a vegetable', 'vegetable', 'fruit');
select repeat("A", 5);
select char_length('Texas');
select upper("texas");
select ascii(1);
select ascii('A');
select length(ltrim('    annnn'));
select trim('     ann    ');
select position("USA" in "LA is in USA");   #**** in
select * from prac_table where city = "Texas";
select * from prac_table where st_marks > 90;
select * from prac_table where city in('Texas', 'LA');
select * from prac_table where st_marks between 90 and 100;
select * from prac_table where st_marks =  99 or st_marks = 100;
select city, count(st_id) as Total_st from prac_table group by city;
Select concat('Apple ', 'is a ', 'Fruit');


select * from prac_table;
select city, avg(st_marks)
from prac_table
group by city
having avg(st_marks) > 90; 

#having along with where
select city, count(*) 
from prac_table 
where city != 'LA'
group by city
having count(*) >1;

#u can also use aggregrate fns in having class that doesnt appear in select class

select * from prac_table;
select city, count(*)
from prac_table 
group by city
having avg(st_marks) > 95;
-- ----------------------------------
#SUBQUERY WITH SELECT STATEMENT

select st_name, city from prac_table where st_marks in(select
st_marks from prac_table where st_marks >90);

#SUBQUERY WITH INSERT STATEMENT
select * from prac_table;

create table st_emp(st_empid int, st_empname varchar(20), st_empcity varchar(20));

insert into st_emp 
select st_empid st_name, city from prac_table where city in(select city from 
prac_table where city = 'Texas');
select * from st_emp;

#SUBQUERY WITH UPDATE STATEMENT


update prac_table set city = 'London' where city in
(select st_empcity from st_emp where st_marks >90 );
select * from prac_table;

#SUBQUERY WITH DELETE STATEMENT
delete from prac_table where st_name in
(select st_name from st_emp where st_empname = 's');

update prac_table set st_name = "s" where st_name = 'So';

select * from prac_table;

delete from prac_table where st_name = "s";
insert into prac_table values(2, 's', 'LA', 95);


create table temp(name varchar(20), id int, salary int, doj date);
show tables;
use practice;
insert into temp values("Harry", 100, 100000, "2021-01-01"),
						("Ron", 101, 100000, "2021-01-01"),
                        ("Hermoyini", 102,150000, "2021-01-01");
select * from temp;
select distinct name from temp;
describe temp;
select count(name) from temp;
select sum(salary) from temp;
select upper(name) from temp;
select reverse(id) from temp;
select char_length(name) from temp;
select salary from temp where name in ("Harry", "Ron");
select replace("canary is a Animal", "Animal", "bird");
show tables;
select * from st_emp;
select * from temp;
show databases;
use practice;
select city, sum(st_marks) as totalmarks from prac_table 
group by city;
select * from st_emp;
select * from prac_table;
select distinct city from prac_table;
select * from prac_table order by st_marks desc;
select curdate();
select day(curdate());
select length("hello");
select repeat(9, 5);
select repeat("hi", 5);
select current_time();
select replace('hello everyone', 'hello', 'bye');

select * from prac_table;
select st_name from prac_table where st_marks=95;
show tables;

#Inner joins
create table bikes(bike_id int, bike_name varchar(15));
insert into bikes values(101, "Tata"), (102, "benz"), (103, "bmw");

create table cars(car_id int auto_increment, name varchar(15), 
				  city varchar(10), primary key(car_id));
		#while auto increment define the primary key
insert into cars(name, city) values ("benz", "LA"), ("Tata", "Vegas"), 
						("Ferrari", "London"), ("Lamborghini", "Tokyo");
select * from bikes inner join cars on bikes.bike_name= cars.name;

#left join
create table herbivorous(animal_id int auto_increment, 
						animal_name varchar(10), primary key(animal_id));
insert into herbivorous(animal_name) values('cow'),('goat'), ('hippo'),
											('buffallo');
select * from herbivorous;

create table carnivorous(animal_id  int, animal_name varchar(10));
insert into carnivorous values(101, "lion"),(102, "Tiger"), (103, "cheetah"),
							  (1, "Leopard");	
select c.animal_id, c.animal_name, h.animal_id, h.animal_name from 
carnivorous as c left join herbivorous as h using(animal_id);

#right join
create table solids(id int auto_increment, name varchar(10), 
					primary key(id));
insert into solids(name) values("rock"), ("Paper"), ("scisor"),("brick");

create table liquids(id int, name varchar(10));
insert into liquids values(101, "Juice"), (102, "petrol"),(103, "water"),
							(104, "rock");
select s.id, s.name, l.id, l.name from solids as s right join liquids
as l on s.name = l.name;

#full join

create table fruits(id int auto_increment, fruit_name varchar(10),
					primary key(id));
insert into fruits(fruit_name) values("Apple"), ("Orange"), ("Berry"), 
										("Tomato");
create table Vegetables(id int, vegetable_name varchar(10));
insert into vegetables values(101, "Tomato"),(102, 'Okra'),(103, "peas"),
								(104, "Spinarch");

select f.id, f.fruit_name, v.id, v.vegetable_name from fruits as f left join vegetables as
v on v.vegetable_name= f.fruit_name 
union
select f.id, f.fruit_name, v.id, v.vegetable_name from fruits as f right join vegetables as v
on v.vegetable_name = f.fruit_name;

create table employees(emp_id int auto_increment, emp_name varchar(10),
						email varchar(20), reports_to int, primary key(emp_id));
insert into employees(emp_name,email,reports_to) values("Amy", "amy@mail.com", null),
														("Benz", "benz@mail.com", 1),
                                                        ("Catherine", "cat@mail.com", 2),
                                                        ("david", "dav@mail.com", 3),
                                                        ("Emily", "emily@mail.com", 4);
select * from employees;
select e.emp_name as manager, m.emp_name as reports_to  from employees as e
inner join employees as m 
on e.emp_id = m.reports_to;

#subqueries
#subquery using insert statement
create table products(product_id int, product_name varchar(10),
						product_sp int);
insert into products values(101, "AC", 50000),
							(102, "Tv", 20000),
                            (103, "Furniture", 30000),
							(104, "bed", 20000),
                            (105, "mi mobile", 20000);
create table orders(product_id int, product_name varchar(10), 
					product_sp int);
insert into orders select product_id, product_name, product_sp
from products where product_sp in(select product_sp from products
									where product_sp>20000);
select * from orders;

#subquery using select stament
select* from products;
select product_id, product_name, product_sp from products where 
			product_sp =(select max(product_sp) from products);

#subqury using update
update products set product_sp = 60000*1 where product_sp in
(select product_sp from orders where product_sp>30000);
select * from products;

#subquery using delete statement
create table apps(app_id int, app_name varchar(20));
insert into apps values(101, 'Playstore'), (102, 'App store'),
						(103, 'game store');
delete from apps where app_id in(select product_id from products where product_id>102);
select * from apps;

#Triggers in sql
#before insert
create table products1(p_id int auto_increment primary key,
 p_name varchar(10),P_sp int);
 
delimiter //
create trigger chk_sp
before insert on products1
for each row 
begin
if new.p_sp>30000 then set new.p_sp = 55000;
end if;
end //
delimiter ;

insert into products1(p_name, p_sp) values("mi", 20000),
			("samsung", 30000),("oneplus", 40000),("iphone", 60000),
            ("ipad", 90000);
select * from products1;

#AFTER INSERT TRIGGER
create table products2(p_id int auto_increment primary key,
 p_name varchar(10),P_sp int);

create table flt(p_name varchar(10), p_sp int);

delimiter //
create trigger new_tble
after insert on products2
for each row 
begin
if new.p_sp > 30000 then
insert into flt values(new.p_name, 000);
end if;
end //
delimiter ;

insert into products2(p_name, p_sp) values("mi", 20000),
			("samsung", 30000),("oneplus", 40000),("iphone", 60000),
            ("ipad", 90000);
select * from flt;

#stored proedures

delimiter $$
create procedure slt_emp()
begin
select emp_id,emp_name from employees order by emp_id desc;
end $$
delimiter ;

call slt_emp();
select * from products;
delimiter //
create procedure top_sp(in var int)
begin
select product_name, product_sp from products
order by product_sp desc limit var;
end //

call top_sp(2);

create view disp_details
as 
select car_id, name from cars;

select * from disp_details;

#after update trigger
#In a after update trigger u can access new and old rows but cant update them.

create table emps(emp_id int auto_increment primary key, emp_name 
					varchar(10), age int, salary float);
insert into emps(emp_name, age, salary) values ('Mark', 24, 60000),
				('Axel', 24, 60000), ('Nathan', 25, 55000),
                ('kevin', 26, 55000), ('Ronald', 27, 55000);
select * from emps;

create table update_emps(emp_id int, emp_name varchar(10),age int);

-- ALTER TABLE emps RENAME column emd_id TO emp_id;

delimiter //
create trigger after_update_emps
after update on emps
for each row 
begin
if new.age >25 then
insert into update_emps(emp_id, emp_name,age) 
			values(old.emp_id, old.emp_name, new.age);
end if;
end //
delimiter ;

update emps set age =26 where emp_id = 4;
select * from update_emps;
update emps set age =26 where emp_id = 5;
select * from emps;

#After delete trigger 
create table medicine(med_id int auto_increment, med_name varchar(10) not null,
						med_cost decimal(5,2), primary key(med_id));
insert into medicine(med_name, med_cost) values('calpol', 200),('dolo', 150),
					('paracet', 220), ('Multivit', 300), ('vitamin', 250);
select * from medicine;
show tables;
select * from medicine;
create table deleted_meds(med_id int, med_name varchar(10), med_cost decimal(5,2));

delimiter $$
create trigger del_med
after delete on medicine
for each row 
begin
insert into deleted_meds(med_id, med_name, med_cost) values(old.med_id, old.med_name,
															old.med_cost);
end $$
delimiter ;

select * from medicine;
delete from medicine where med_id = 3;
delete from medicine where med_id = 4;
delete from medicine where med_id = 5;

select * from deleted_meds;

#view in sql





