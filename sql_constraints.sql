-- sql constraints

-- not null 
-- unique
-- primary key
-- foreign key
-- check
-- default
-- index

show databases;
create database temp;
use temp;
show tables;
create table students(id int not null primary key auto_increment, name varchar(20) not null,
 age int not null, gender char(1));
alter table students modify gender char(1) not null;
describe students;
insert into students values(3,'ben',20, 'M'),
						(5,'gwen',20,'f');
select * from students;
drop table students;

