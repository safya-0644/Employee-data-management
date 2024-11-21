create database learningDB;
use learningDB;
set sql_safe_updates=0;

create table courses
(
c_id int primary key auto_increment,
c_title varchar(100) not null,
description text
);

create table instructor
(
i_id int primary key auto_increment,
i_name varchar(100) not null,
expertise varchar(100) not null
);

create table students
(
s_id int primary key auto_increment,
s_name varchar(100) not null,
s_email varchar(100) not null,
unique(s_email)
);

create table enrollments
(
student_id int,
foreign key(student_id) references students(s_id),
course_id int,
foreign key(course_id) references courses(c_id),
enrollment_date date not null,
primary key(student_id,course_id)
);


insert into courses
(c_title, description) 
values
('Introduction to Python', 'Learn the basics of Python programming.'),
('Data Science with R', 'An in-depth guide to data science using R.'),
('Web Development', 'Comprehensive course on building modern web applications.'),
('Machine Learning', 'Explore machine learning concepts and algorithms.');

insert into instructor
(i_name, expertise)
values
('Alice Johnson', 'Python and Data Science'),
('Bob Smith', 'Web Development'),
('Catherine Lee', 'Machine Learning'),
('David Brown', 'Statistics and R');

insert into students
(s_name,s_email)
values
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Robert Brown', 'robert.brown@example.com'),
('Emily White', 'emily.white@example.com');

insert into enrollments
(student_id, course_id, enrollment_date) 
values
(1, 1, '2024-11-15'),
(2, 2, '2024-11-16'),
(3, 3, '2024-11-17'),
(4, 4, '2024-11-18'),
(1, 3, '2024-11-19'), 
(2, 4, '2024-11-20');

select * from courses;
select* from instructor;
select * from students;
select * from enrollments;

select * from courses;
select* from instructor;

select s_name, c_title,enrollment_date
from students s
join enrollments e
on s.s_id=e.student_id
join courses c
on c.c_id=e.course_id;

select c_title as Course_title,
count(student_id) as Student_count
from enrollments e
join courses c
on e.course_id=c.c_id
group by c.c_title;


