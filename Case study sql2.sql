#CREATING A DATABASE
create database LibraryDB;
use LibraryDB;
set sql_safe_updates=0;

#CREATING TABLES
create table books
(
b_id int primary key auto_increment,
b_title varchar(100) not null,
b_author varchar(100) not null,
published_year year not null,
b_genre varchar(50)
);

create table members_table
(
m_id int primary key auto_increment,
m_name varchar(100) not null,
membership_date date not null
);

create table borrowing_table
(
id int primary key auto_increment,
book_id int,
foreign key (book_id) references
books(b_id),
member_id int,
foreign key (member_id) references
members_table(m_id),
borrow_date date not null,
return_date date
);

#INSERTING VALUES
insert into books 
(b_title,b_author, published_year,b_genre)
values
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction'),
('1984', 'George Orwell', 1949, 'Dystopian'),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic'),
('The Catcher in the Rye', 'J.D. Salinger', 1951, 'Classic'),
('The Road', 'Cormac McCarthy', 2006, 'Post-apocalyptic'),
('The Shining', 'Stephen King', 1977, 'Horror'),
('The Alchemist', 'Paulo Coelho', 1988, 'Philosophical Fiction'),
('The Kite Runner', 'Khaled Hosseini', 2003, 'Drama'),
('The Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasy'),
('Dune', 'Frank Herbert', 1965, 'Science Fiction');

insert into members_table
(m_name, membership_date) values
('Liam', '2023-01-15'),
('Olivia', '2023-02-20'),
('Emma', '2023-03-10'),
('Sophia', '2023-04-05'),
('Lucas', '2023-05-18'),
('Noah','2024-01-15'),
('Hazel','2024-02-11'),
('Eden','2024-03-12'),
('Jude','2024-04-04'),
('Rory','2024-05-05');

insert into borrowing_table
(book_id, member_id, borrow_date, return_date)
values
(1, 1, '2023-10-01', '2023-10-15'),
(2, 2, '2023-10-03', NULL),
(3, 3, '2023-10-05', '2023-10-12'),
(4, 4, '2023-10-07', NULL),
(5, 5, '2023-10-10', '2023-10-20'),
(6,6,'2024-01-20',NULL),
(7,7,'2024-02-18','2024-03-12'),
(8,8,'2024-03-12',NULL),
(9,9,'2024-03-12','2024-04-04'),
(10,10,'2024-05-05','2024-06-12'),
(4, 2, '2023-11-03', NULL),
(5, 3, '2023-10-05', '2023-10-12');

#VIEWING TABLES
select * from books;
select * from members_table;
select * from borrowing_table;

#SHOW BORROWING RECORDS WITH MEMBER NAMES AND BOOK TITLES
select book_id,
b_title as Book_title,
member_id,
m_name as Member_name,
borrow_date,
return_date
 from books 
join borrowing_table b
on books.b_id=b.book_id
join members_table m
on m.m_id=b.member_id;

#COUNT NUMBER OF BOOKS BORROWED BY EACH MEMBER
select member_id,
m_name as Member_name,
Count(id)
 from borrowing_table b
join members_table m
on m.m_id=b.member_id
group by(b.member_id);


