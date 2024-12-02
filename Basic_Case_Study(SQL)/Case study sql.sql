#CREATING A DATABASE
create database EmployeeManagement;
use EmployeeManagement;
set sql_safe_updates=0;

#CREATING TABLES
create table Department
(d_id int primary key auto_increment,
d_name varchar(100) not null);

create table Employees (
e_id int primary key auto_increment,
e_name varchar(100) not null,
e_age int not null,
e_gender varchar(10) not null,
e_salary int not null check (e_salary>30000),
e_dept int, foreign key(e_dept) references Department(d_id)
);

create table Projects (
p_id int primary key auto_increment,
p_name varchar(100) not null,
p_budget int not null check (p_budget>10000));

create table Employee_Projects (
e_id int primary key auto_increment,
p_id int, foreign key(p_id) references Projects(p_id)
);

create table Attendance (
a_id int primary key auto_increment,
e_id int, foreign key(e_id) references Employees(e_id),
a_date date not null,
a_status enum('Present','Absent','On Leave')
);

#INSERTING VALUES TO THE TABLES
insert into Department (d_name) 
values
('HR'),('Marketing and Sales'),('Finance'),('Production/Operations'),
('R&D'),('Customer Service'),('IT');

insert into Employees
(e_name,e_age,e_gender,e_salary,e_dept)
values
('Sumith',21,'Male',32000,2),
('Janani', 24,'Female',41000,1),
('Devyanth',29,'Male',68660,4),
('Frello',30,'Male',43450,5),
('Harry',28,'Male',68750,3),
('Hermoine',27,'Female',34540,1),
('Ron',29,'Male',48750,6),
('Malfoy',29,'Male',32000,7),
('Skies',23,'Male',32000,7),
('Dumbledore',32,'Male',45000,7),
('Sanya',23,'Female',45000,1),
('Courtney',26,'Female',45000,1),
('Sam',22,'Male',45000,1);

insert into Projects values(101,'Project A',11000);
insert into Projects
(p_name,p_budget)
values
('Social Circle',21000),('Local Link',67000),('Unity Hub',75000),
('Project B',82500),('Project C',58000);

insert into Employee_Projects values
(1,102),(2,106),(3,103),(4,101),(5,105),(6,104),(7,106),
(8,101),(9,102),(10,104),(11,105),(12,106),(13,103);

insert into Attendance
(e_id,a_date,a_status)
values
(1,'2023-12-12',1),
(2,'2023-12-12',1),
(3,'2023-12-12',2),
(4,'2023-12-12',3),
(5,'2023-12-12',1),
(6,'2023-12-12',3),
(7,'2023-12-12',1),
(8,'2023-12-12',2),
(9,'2023-12-12',1),
(10,'2023-12-12',2),
(11,'2023-12-12',1),
(12,'2023-12-12',2),
(13,'2023-12-12',1),
(1,'2024-06-12',1),
(2,'2024-06-12',2),
(3,'2024-06-12',1),
(3,'2024-07-12',2),
(3,'2024-08-12',3),
(3,'2024-09-12',1);

#VIEWING THE TABLES
select * from Department;
select * from Employees;
select * from Projects;
select * from Employee_Projects order by e_id asc;
select * from Attendance;

#QUERIES
#Retrieve all employees in the 'IT' department.
select * from Employees
join
Department On Employees.e_dept=Department.d_id
where d_name ='IT';
#(or)
select e_id,e_name from Employees
join
Department On Employees.e_dept=Department.d_id
where d_name ='IT';

#LIST ALL PROJECTS WITH A BUDGET GREATER THAN 50000.
select * from Projects 
where p_budget>50000;
#(or)
select p_id,p_name from Projects 
where p_budget>50000;

#SHOW THE NAMES OF EMPLOYEES AND THE PROJECTS THEY ARE WORKING ON.
select e_name as Employee_Name,
p_name as Project_name
from Employees 
join Employee_Projects
on Employees.e_id=Employee_Projects.e_id
join Projects
on Projects.p_id=Employee_Projects.p_id;

#COUNT THE NUMBER OF EMPLOYEES IN EACH DEPARTMENT.
select d_name as Department,
count(e_id) as Employee_count
from Department
join Employees
on Department.d_id=Employees.e_dept
group by Department.d_name;

#FIND EMPLOYEES WITH A SALARY GREATER THAN 50000.
select * from Employees where e_salary>50000;

#GET ATTENDANCE RECORDS FOR A SPECIFIC EMPLOYEE.
select * from Attendance where e_id=3;

#INCREASE THE SALARY OF EMPLOYEES IN THE 'HR' DEPARTMENT BY 10%.
select * from Attendance 
join Employees
on
Employees.e_id=Attendance.e_id
where e_name='Devyanth';

#CHANGE THE DEPARTMENT OF AN EMPLOYEE.
update Employees
set e_salary=e_salary*1.10
where e_dept=1;
#(or)
update Employees
set e_salary=e_salary*1.10
where e_dept=
(select d_id from Department
where d_name='HR');

#VIEWING THE CHANGES MADE IN THE TABLE
select * from Employees;

#CHANGE THE DEPARTMENT OF AN EMPLOYEE.
update Employees
set e_dept=5 where e_id =11;
#(or)
update Employees
set e_dept=
(select d_id from Department where d_name='R&D')
where e_id=11;

select * from Employees;

#REMOVE AN EMPLOYEE WHO HAS RESIGNED.
delete from Attendance
where e_id=10;
delete from Employees
where e_id=10;
delete from Employee_Projects
where e_id=10;

#VIEWING CHANGES
select * from Department;
select * from Employees;
select * from Projects;
select * from Employee_Projects order by e_id asc;
select * from Attendance;

#DELETE A PROJECT THAT IS COMPLETED.
delete from Employee_Projects
where p_id=101;
delete from Projects
where
p_name = 'Project A';

#VIEWING TABLE
select * from Projects;
select * from Employee_Projects order by e_id asc;

#ADD A UNIQUE CONSTRAINT TO THE `EMAIL` COLUMN IN `EMPLOYEES` TABLE.
alter table Employees add column 
e_email varchar(100);
#(OR)
alter table Employees add constraint 
u_eemail unique(e_email);

#VIEWING TABLE
select * from Employees;

#ADDING THE VALUES
update Employees
set e_email=case
when e_name='Sumith' then 'sumithverma@gmail.com'
when e_name='Janani' then 'jananisubash@gmail.com'
when e_name='Devyanth' then 'devyanthprakash@gmail.com'
when e_name='Frello' then 'frellojames@gmail.com'
when e_name='Harry' then 'harrypotter@gmail.com'
when e_name='Hermoine' then 'hermoinegranger@gmail.com'
when e_name='Ron' then 'ronweasly@gmail.com'
when e_name='Malfoy' then 'dracomalfoy@gmail.com'
when e_name='Skies' then 'skiesfred@gmail.com'
when e_name='Sanya' then 'sanyareanu@gmail.com'
when e_name='Courtney' then 'courtneythomas@gmail.com'
when e_name='Sam' then 'sammealuse@gmail.com'
end;

#VIEWING TABLE
select * from Employees;

#CONSTRAINT VIOLATION
insert into Employees #email
(e_name,e_age,e_gender,e_salary,e_dept,e_email)
values
('Sumanth',21,'Male',32000,'3','sumithverma@gmail.com');

#ENSURE `AGE` IS ALWAYS GREATER THAN 18.
alter table Employees
add constraint
chk_age check (e_age>18);
select * from Employees;

#CONSTRAINT VIOLATION
insert into Employees #age
(e_name,e_age,e_gender,e_salary,e_dept,e_email)
values
('Sumanth',11,'Male',32000,'3','sumanth@gmail.com');

#ADD A DEFAULT VALUE 'UNKNOWN' TO `GENDER` IF NOT SPECIFIED.
alter table Employees
modify e_gender varchar(10) 
not null default 'Unknown';

#CONSTRAINT USE
insert into Employees # Gender
(e_name,e_age,e_salary,e_dept,e_email)
values
('Sumanth',21,32000,'3','sumanth@gmail.com');

select * from Employees;
