#Creating a new database
create database pizza_runner;
use pizza_runner;
set sql_safe_updates=0;

#Creating tables
create table customer_order
(
order_id int ,
customer_id int,
pizza_id int,
exclusions varchar(20),
extras varchar(20),
order_date timestamp
);

create table runner_order
(
order_id int,
runner_id int,
pickup_time varchar(19),
distance varchar(7),
duration varchar(10),
cancellation varchar(23)
);

create table pizza_name
(
pizza_id int primary key,
pizza_name text
);

create table runners
(
runner_id int primary key,
registration_date date
);

create table pizza_recipe
(
pizza_id int,
foreign key(pizza_id) 
references pizza_name(pizza_id),
toppings text
);

create table pizza_toppings
(
topping_id int primary key,
topping_name text
);

#Inserting data
insert into customer_order 
(order_id, customer_id, pizza_id,
exclusions, extras, order_date) 
values
(1, 101, 1, NULL, NULL, '2021-01-01 18:05:02.000'),
(2, 101, 1, NULL, NULL, '2021-01-01 19:00:52.000'),
(3, 102, 1, NULL, NULL, '2021-01-02 23:51:23.000'),
(3, 102, 2, NULL, NULL, '2021-01-02 23:51:23.000'),
(4, 103, 1, '4', NULL, '2021-01-04 13:23:46.000'),
(4, 103, 1, '4', NULL, '2021-01-04 13:23:46.000'),
(4, 103, 2, '4', NULL, '2021-01-04 13:23:46.000'),
(5, 104, 1, NULL, '1', '2021-01-08 21:00:29.000'),
(6, 101, 2, NULL, NULL, '2021-01-08 21:03:13.000'),
(7, 105, 2, NULL, '1', '2021-01-08 21:20:29.000'),
(8, 102, 1, NULL, NULL, '2021-01-09 23:54:33.000'),
(9, 103, 1, '4', '1, 5', '2021-01-10 11:22:59.000'),
(10, 104, 1, NULL, NULL, '2021-01-11 18:34:49.000'),
(10, 104, 2, '2, 6', '1, 4', '2021-01-11 18:34:49.000');

insert into runner_order 
(order_id, runner_id, pickup_time, distance, duration, cancellation) values
(1, 1, '2021-01-01 18:15:34', '20km', '32 minutes', NULL),
(2, 1, '2021-01-01 19:10:54', '20km', '27 minutes', NULL),
(3, 1, '2021-01-03 00:12:37', '13.4km', '20 mins', NULL),
(4, 2, '2021-01-04 13:53:03', '23.4', '40', NULL),
(5, 3, '2021-01-08 21:10:57', '10', '15', NULL),
(6, 3, NULL, NULL, NULL, 'Restaurant Cancellation'),
(7, 2, '2021-01-08 21:30:45', '25km', '25mins', NULL),
(8, 2, '2021-01-10 00:15:02', '23.4 km', '15 minute', NULL),
(9, 2, NULL, NULL, NULL, 'Customer Cancellation'),
(10, 1, '2021-01-11 18:50:20', '10km', '10minutes', NULL);

insert into pizza_name (pizza_id, pizza_name) values
(1, 'Margherita'),
(2, 'Pepperoni'),
(3, 'Hawaiian');

insert into runners 
(runner_id, registration_date) 
values
(1, '2020-12-01'),
(2, '2020-12-03'),
(3, '2020-12-05');

insert into pizza_recipe 
(pizza_id, toppings) values
(1, 'Tomato Sauce, Mozzarella'),
(2, 'Tomato Sauce, Mozzarella, Pepperoni'),
(3, 'Tomato Sauce, Mozzarella, Ham, Pineapple');

insert into pizza_toppings
(topping_id, topping_name) values
(1, 'Tomato Sauce'),
(2, 'Mozzarella'),
(3, 'Pepperoni'),
(4, 'Ham'),
(5, 'Pineapple');

#viewing data
select * from customer_order;
select * from runner_order;
select * from runners;
select * from pizza_name;
select * from pizza_recipe;
select * from pizza_toppings;
