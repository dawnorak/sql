create database employeedb

use employeedb

-- Create Table
create table employee
(
empID int,
firstname varchar(50),
lastname varchar(50)
)

-- Display Table
select empID, firstname, lastname from employee

-- Altering Table to Add New Column
alter table employee
add Department varchar(20) null

-- Inserting Values
insert into employee(empID, firstname, lastname, Department)
values(1, 'Arun', 'Chandra', 'Development'),(2,'Sri','Kumar','Development'),(3,'Aparna','Vemuganti','Testing'),
(4,'Sai','Gunavardhan','Design'),(5,'Vaigarai','Sathi','Development'),(6,'Varun','Teja','Design'),
(7, 'Supriya', 'Mallela', 'Testing'),(8, 'Sabahat', 'Shaik', 'Development')

select * from employee

-- Conditional Selection
select * from employee where Department like 'Development'

-- Selecting Distinct Values
select distinct Department from employee

-- Updating Table
update employee set Department = 'Design' where firstname = 'Aparna'

-- New Table
create table student(
empID int,
course varchar(10))

insert into student(empID, course)
values(1, 'AI&DS'),(2,'CSE'),(3,'AI&DS'),
(4,'AI&DS'),(5,'CSE'),(6,'AI&DS'),
(7, 'CSE'),(8, 'CSE')

select * from student

-- JOINS

select a.firstname, b.course from employee a inner join student b on a.empID = b.empID