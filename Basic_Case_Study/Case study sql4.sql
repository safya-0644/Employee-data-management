#CREATING A NEW DATABASE
create database retaildb;
use retaildb;
set sql_safe_updates=0;

#CREATING TABLES
create table products
(
p_id int primary key auto_increment,
p_name varchar(100) not null,
p_price decimal(10,2) not null, check (p_price>0),
p_stock int not null, check (p_stock >=0)
);

create table supplier
(
s_id int primary key auto_increment,
s_name varchar(100) not null,
s_contact varchar(100)
);

create table sales
(
sl_id int primary key auto_increment,
product_id int, foreign key(product_id) references products(p_id),
s_date date not null,
s_quantity int not null check (s_quantity>0),
total_price decimal(10,2) not null
);

#INSERTING VALUES
insert into products (p_name, p_price, p_stock) 
values
('Laptop', 800.00, 50),
('Smartphone', 500.00, 100),
('Headphones', 50.00, 200),
('Keyboard', 25.00, 150),
('Mouse', 15.00, 300);

insert into supplier (s_name, s_contact) 
values
('Tech Distributors Inc.', 'tech_distributors@example.com'),
('Gadget World', 'contact@gadgetworld.com'),
('Accessories Co.', 'sales@accessoriesco.com'),
('Electro Supplies', 'info@electrosupplies.com'),
('Global Gadgets', 'support@globalgadgets.com');

insert into sales (product_id, s_date, s_quantity, total_price) 
values
(1, '2024-11-01', 2, 1600.00),
(2, '2024-11-02', 3, 1500.00),
(3, '2024-11-03', 5, 250.00),
(4, '2024-11-04', 4, 100.00),
(5, '2024-11-05', 10, 150.00);

#VIEWING TABLES
select * from products;
select * from supplier;
select * from sales;

#PRODUCTS STOCK LESS THAN 100
select * from products where p_stock<100;

#SALES OF PRODUCT AND TOTAL PRICES 
select p_name, s_quantity, sum(s_quantity*price) as Total_price 
from products p
join sales s
on p.p_id = s.product_id;

#TOTAL SALES FOR EACH PRODUCT
select p_name, sum(s_quantity) as Total_sales
from products p
join sales s
on p.p_id = s.product_id
group by p.p_name;