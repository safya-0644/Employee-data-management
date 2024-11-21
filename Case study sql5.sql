
use hospitaldb;
set sql_safe_updates=0;


create table patients
(
p_id int primary key auto_increment,
p_name varchar(100) not null,
p_age int not null,
p_gender varchar(10),
p_contact varchar(50)
);

create table doctors
(
d_id int primary key auto_increment,
d_name varchar(100) not null,
specialization varchar(100) not null
);

create table appointments
(
id int primary key auto_increment,
patient_id int,
foreign key(patient_id) references patients(p_id),
doctor_id int,
foreign key(doctor_id) references doctors(d_id),
appointment_date date not null,
status enum('Scheduled','Completed','Cancelled')
);

Insert into patients 
(p_name, p_age, p_gender, p_contact) 
values
('John Doe',30,'Male','john.doe@gmail.com'),
('Jane Smith',25,'Female','jane.smith@gmail.com'),
('Robert Brown',40,'Male','robert.brown@gmail.com'),
('Emily White',35,'Female','emily.white@gmail.com'),
('Daniel Frenis',34,'Male','danielfrenis@gmail.com'),
('Elfin Robert',39,'Female','elfinreobert@gmail.com'),
('Suman Green',45,'Female','sumangreen@gmail.com'),
('Monica Geller',48,'Female','monicageller@gmail.com'),
('Chandler Bing',58,'Male','chandlerbing@gmail.com'),
('Pheobe Buffay',49,'Female','pheobebuffay@gmail.com');


insert into doctors 
(d_name, specialization) 
values
('Dr. Alice Green', 'Cardiology'),
('Dr. Bob Grey', 'Neurology'),
('Dr. Charlie Black', 'Dermatology'),
('Dr. Diana Blue', 'Pediatrics');

insert into appointments
(patient_id, doctor_id, appointment_date, status) 
values
(1,2,'2024-11-20',1),
(2,3,'2024-11-21',2),
(3,1,'2024-11-22',3),
(4,4,'2024-11-23',1),
(5,1,'2024-11-24',1),
(6,2,'2024-11-23',3),
(7,4,'2024-11-21',1),
(8,2,'2024-11-22',3),
(9,4,'2024-11-24',1),
(10,4,'2024-11-20',2);

select * from patients;
select * from doctors;
select * from appointments;

select * from patients;
select * from doctors;

select p_name, d_name, appointment_date
from patients p
join appointments a
on p.p_id=a.patient_id
join doctors d
on d.d_id=a.doctor_id;

select d_name as Doctor_name,
count(id) as Appointment_count
from doctors d
join appointments a
on d.d_id=a.doctor_id
group by d.d_name;



