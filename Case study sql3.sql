create database StudentDB;
use StudentDB;
set sql_safe_updates=0;

create table student
(
s_id int primary key auto_increment,
s_name varchar(100) not null,
s_age int not null,
s_email varchar(100) not null,
unique(s_email)
);

create table course
(
c_id int primary key auto_increment,
c_name varchar(50)  not null
);

create table enrollment
(
student_id int,
foreign key(student_id) references student(s_id),
course_id int,
foreign key(course_id) references course(c_id),
grade char(1),
primary key(student_id,course_id)
);

insert into student
(s_name,s_age,s_email) 
values
('Alice John',21,'alicejohn@gmail.com'),
('Brad',22,'bradjames@gmail.com'),
('Chloie Brown',21,'chloiebrown@gmail.com'),
('Diana Darvin', 22,'dianadarvin@gmail.com'),
('Emma Watson',21,'emmawatson@gmail.com'),
('Franchis',22,'franchis@gmail.com');

insert into course (c_name) 
values
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('Computer Science');

insert into enrollment
(student_id, course_id, grade) 
values
(1,1,'A'), 
(1,2,'B'),
(1,3,'A'),
(2,3,'C'),
(3,1,'B'),
(3,4,'A'),
(4,5,'A'),
(5,1,'C'),
(5,5,'B'),
(6,5,'A'),
(6,3,'C');

select * from student;
select * from course;
select * from enrollment;

select s_id,s_name,c_name
from course c
join enrollment e
on c.c_id=e.course_id
join student s
on s.s_id=e.student_id;


select c_name as Course_name,
Count(student_id) as Count_of_students
from enrollment e
join course c
on e.course_id=c.c_id
group by
c.c_id,c.c_name;



