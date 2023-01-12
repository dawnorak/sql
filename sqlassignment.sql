create table Employee(
Empno int, Empname varchar(30), Job varchar(20), Mgr int,
HireDate date, Salary int, Comm int, Deptno int)

insert into Employee
values (325, 'Smith','Clerk',433, '1995-01-11',3500, 1400, 20)

insert into Employee
values (825, 'James','Clerk',466, '1981-09-02', 2975, null, 20),
(433, 'James','Analyst',466, '1989-12-03', 3500, null, 40),
(466, 'Mike','President', null, '1997-11-18', 7000, null, 30),
(889, 'Adams','Manager', 433, '1987-05-23', 3250, 0, 10),
(435, 'Blake',	'Analyst', 889, '1989-12-03', 4500, 0, 40)

create table Department(
DeptNo int, Dname varchar(20), Loc varchar(20))

insert into Department
values(10,'Accounting','Chicago'),(20,'Research','Dallas'),
(30,'Sales','NewYork'),(40,'Operations','Boston'),(50,'Purchase','Los Angeles')

-- Simple SQL Queries to demonstrate DQL Command

-- Display details of all Employees
select * from Employee

-- Details of Department table
select * from Department


-- Display Empno, Name and job of all Employees
select Empno, Empname, Job from Employee

-- Display Deptno, Name of Department
select DeptNo, Dname from Department

-- Find all Job of Employees and Remove Duplicates
select Empno, Empname, Job from Employee

select Empno, Count(*) as cnt from Employee
group by Empno having count(*)>1 -- no duplicates

-- SQL QUERIES TO DEMONSTRATE DQL USING OPERATORS

-- Names of Employees Analyst and drawing salary of over 2000
select * from Employee where Job = 'Analyst' and Salary > 2000

-- Names of Employees with Empno of those who do not earn commission
select Empno, Empname from Employee where Comm is null or Comm = 0

-- Names of Employees who are working as Clerk, Analyst or Manager and Drawing Salary over 3000
select Empname from Employee where Job IN('Clerk','Analyst','Manager') and Salary > 3000

-- Names of Employees working in Department 10, or 20 or 40 or working as Clerk, Analyst
select Empname from Employee where Job in('Clerk','Analyst') or Deptno in(10,20,40)

-- Display Employee name, Deptno, and Dept names of all employees working  in department reaserch
select empname, employee.deptno, dname from employee 
full join Department on Employee.Deptno = Department.Deptno
where dname = 'Research'

-- Display names of Employees whose names start with alphabet 'B' & ends with 'E'
select Empname from Employee where Empname like 'B%e'



-- QUERIES ON EMP TABLE

-- Display common jobs between Department 10 and 20
select job from employee where Deptno=10 intersect select job from employee where Deptno=20

-- Display jobs which are unique to dept no 10
select distinct job from Employee where Deptno = 10

-- Display names of employees whose salary is over 3000 after 20% raise 
select Empname from Employee where (1.2*Salary) > 3000

-- Display those employees who are not working under any manager
select empno, empname from employee where mgr is null




-- SQL QUERIES TO DEMONSTRATE DQL COMMAND USING AGGREGATE AND CHARACTER FUNCTIONS

-- Find number of rows in employee table 
select count(*) as cnt from employee

-- Find number of employees in department accounting
select count(*) from Employee
full join Department on Employee.Deptno = Department.Deptno where Department.Dname = 'Accounting'

-- Find total pay for all employees in organization
select sum(Salary) from Employee

-- Get the department ID, average, max and min pay of all departments
select Deptno, avg(Salary), max(salary), min(salary) from Employee group by Deptno

-- Above info for all departments having more than two employees
select Deptno, avg(Salary), max(salary), min(salary) from Employee group by Deptno 
having Deptno in (select Deptno from Employee group by Deptno having count(*)>1)

-- Display current date
select getdate()

-- Display name and annual salary for all employees
select Empname, Salary from Employee


-- WRITE SQL QUERIES USING CLAUSES

-- Display various jobs and total number of employees in each job group
select job, count(*) from Employee group by Job

-- Display various jobs along with total salary for each job group where total salary is greater than 5000
select job, sum(salary) from Employee group by Job having sum(salary)>5000

-- Display empno, name, deptno and salary, Sort the rows on name and within name by deptno and within deptno by salary
select empno, empname, deptno, salary from employee order by empname, deptno, salary

-- Display names of employees along with their annual salary, employee with highest salary comes first 
select empname, salary from employee order by salary desc

-- Find name of employee who gets maximum pay
select empname from employee where salary = (select max(salary) from employee)

-- Find names of all employees whose salary is greater than atleast one employee in dept 30
select empname from employee where salary > any (select salary from employee where deptno = 30)

-- Find names of all employees whose salary is greater than that of each employee working in dept sales
select empname from employee 
full join Department on Employee.Deptno = Department.Deptno 
where salary > all (select salary from employee where dname = 'Sales')

-- Display those employees whose manager name is James
select empname from employee where mgr = 825

-- Display names of those manager whose salary is greater than average salary or equal to it
select empname from employee where salary >= (select avg(salary) from employee)




-- WRITE SQL QUERIES USING JOINS


-- Get empno, name, deptno and department name of all employees
select empno, empname, employee.empno, dname from employee
full join Department on Employee.Deptno = Department.Deptno


-- Display employee names along with their manager names
select e1.empname as en, e2.empname as mn from employee e1
left join employee e2 on e1.mgr = e2.empno

-- Display those employees who are working in the same department where his manager works
select e1.empname from employee e1
inner join employee e2 on e1.deptno = cast(e2.mgr as integer)
inner join department d on e1.deptno = d.deptno
where e1.deptno = e2.deptno

-- Display employee details along with their department details using full outer join, left outer join and right outer join
select employee.empno, employee.empname, department.dname, department.loc from employee
full outer join department on employee.deptno = department.deptno

-- WRITE SQL QUERIES ON INTEGRITY CONSTRAINS

-- Create a table Cust_dtls such that the content of the column Cust_no is unique and not notnull
-- Cust_name should be in upper case, cust_city starts with alphabet 'H'
create table Cust_dtls(
Cust_no int not null unique,
Cust_name varchar(30) not null,
Cust_city varchar(30) not null, check (upper(Cust_name) = Cust_name),
check (substr(Cust_city, 1, 1) = 'H')
)

-- Add constrains to employee tableL empno primary key, empname - shouldn't be null, comm - set default 0, 
-- deptno - is foreign key, mgr - foreign key referencing empno of employee table 
alter table employee
add primary key (empno),
alter column empname set not null,
alter column comm set default 0

alter table employee
add constraint fk_deptno foreign key (deptno) references department(deptno),
add constraint fk_mgr foreign key (mgr) references employee(empno);

-- Add and drop the constraints on the Loc column of Department table to ensure it has only unique values
alter table Department
add constraint unl unique(Loc)

alter table Department
drop constraint unl

-- Disable the check constraint on Cust_name column from Cust_dtls table
alter table cust_dtls
drop constraint cust_dtls_cust_name_check



-- WRITE SQL QUERIES TO DEMONSTRATE DDL COMMAND


-- Add a new column to the Department table called budget of size 10
alter table Department
add Budget int(10)

-- Modify the size of the budget field to size 12 and add a default value of 5000
alter table Department
modify Budget int(12) default 5000

-- Drop the employee table
drop table employee


-- WRITE SQL QUERIES TO DEMONSTRATE DML COMMAND


-- Rename the department table as dept_details
alter table Department
rename table Department to dept_details

-- Delete the department with location NewYork
delete from dept_details
where loc = 'NewYork'

-- Delete the records of all employees whose salary is below the average salary at the organization
delete from employee
where salary < (select avg(salary) from employee)

-- Update the deptno and dname of dept table with values 70 and 'Distribution' where Dname is 'Sales'
update dept_details
set deptno = 70, dname = 'Distribution'
where dname = 'Sales'
