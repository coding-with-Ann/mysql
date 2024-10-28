#TRIGGERS IN SQL
#A TRIGGER IS A USER DEFINED SQL COMMAND THAT INVOKED AUTOMATICALLY IN RESPONSE TO AN 
#EVENT SUCH AS INSERT, DELETE OR UPDATE
#IN MYSQL TRIGGERS CAN BE EXECUTED AUTOMATICALLY BY THE ORACLE SERVER.

#SYNTAX
#CREATE TRIGGER 
#TRIGGER_NAME TRIGGER_TIME TRIGGER EVENT ON TABLE NAME FOR EACH ROW
#BEGIN 
#-----
#END

#IN ABOVE SYNTAX, TRIGGER_TIME ----> BEFORE OR AFTER AN EVENT
#				  TRIGGER_EVENT ----> iNSERT UPDATE DELETE

#IN BEFORE INSERT TRIGGER U CAN ACCESS AND CHANGE THE NEW VALUES. HOWEVER U CANT ACCESS 
	#THE OLD VALUES BECAUSE OLD VALUES DOESN'T EXIST.
#IN AN AFTER INSERT TRIGGER U CAN ACCESS NEW VALUES BUT CANT CHANGE THEM. 
	# ALSO U CANT ACCESS THE OLD VALUES BECAUSE THERE IS NO OLD ON INSERT TRIGGERS.
    
#IN A BEFORE UPDATE TRIGGER U CAN UPDATE THE NEW VALUES BUT CAN'T UPDATE THE OLD VALUES.
#IN A AFTER update TRIGGER YOU CAN ACCESS NEW AND OLD ROWS BUT CAN'T UPDATE THEM.

#IN A BEFORE DELETE TRIGGER U CAN ACCESS THE OLD ROW BUT CANT UPDATE IT, ALSO THERE IS NO
	# NEW ROW IN BEFORE DELETE TRIGGER.
#SAME RULE FOR AFTER DELETE TRIGEER(LIKE BEFORE DELETE TRIGGER).

-- --------------------------------------------

create database triggers;
drop database triggers;
use triggers;

#BEFORE INSERT TRIGGER
create table customer
(cust_id int, age int, name varchar(20));

##DROP TRIGGER age_verify;  -- to delete trigger
# delimiter is a marker for end of each command
delimiter //                    
create trigger age_verify
before insert on customer
for each row
if new.age < 0 then set new.age = 0;
end if; //

insert into customer
values('101', 27, 'James'),
(102, -40, 'ammy'), (103, 32, 'Ben'), (103, -39, 'Angella');
select * from customer;

#AFTER INSERT TRIGGER
create table customer1(
id int auto_increment primary key,
 name varchar(40) not null,                     
 email varchar(30), birth_date date);
 
 
 create table message(
 id int auto_increment,
 messageId int, message varchar(300) not null,     # not null ******
primary key(id, messageId));

Delimiter //
create trigger  check_null_dob
after insert on customer1 for each row 
begin
if new.birth_date is null then 
insert into message(messageId, message)
values (new.id, concat('Hi' , new.name, ', please update your dob.'));
end if;
end //
delimiter ;

insert into customer1(name, email, birth_date) 
values("nancy", "nanacy@abc.com", NULL),
("ronald", "ronald@xyz.com", "1998-11-16"),
("krish", "krish@xyz.com", "1997-08-20"),
("Alish", "alish@abc.com", NULL);
select * from message;

#BEFORE UPDATE
create table employees(emp_id int primary key, 
emp_name varchar(20), age int, salary float);
insert into employees values("101", "Jimmy", 35, 70000),
                            ("102", "shane", 30,55000 ),
                            ("103", "marry", 28, 62000),
                            ("104", "dwayne", 37, 57000),
                            ("105", "sara", 32, 72000),
                            ("106", "amy", 35, 80000),
                            ("107", "Jack", 40, 100000);
delimiter //
create trigger upd_trigger
before update
on employees 
for each row 
begin
if new.salary = 10000 then
set new.salary = 85000;
elseif new.salary < 10000 then
set new.salary = 72000;
end if;
end //
delimiter ;

update employees 
set salary = 8000;
select * from employees;

#before delete trigger
create table salary(
eid int primary key,
 validfrom date, amount float);
 
 insert into salary (eid, validfrom, amount) 
values('101','2005-05-01', 55000),
('102','2007-08-01', 68000),
('103','2006-09-01', '75000');
select * from salary;

create table salarydel(id int primary key auto_increment,
eid int, validfrom date not null, amount float not null,
deletedat timestamp default now());  
-- returns the time and date at which the record was deleted
delimiter $$
create trigger salary_delete
before delete 
on salary
for each row
begin
insert into salarydel(eid,validfrom, amount)
values(old.eid, old.validfrom, old.amount);
end$$
delimiter ;
delete from salary
where eid = 103;
select * from salarydel;

