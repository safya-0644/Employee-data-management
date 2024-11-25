create database pizza_metric;
use pizza_metric;
set sql_safe_updates=0;

create table customer_order
(
order_id int ,
customer_id int,
pizza_id int,
exclusions varchar(20),
extras varchar(20),
order_date timestamp
);

insert into customer_order 
(order_id, customer_id, pizza_id, exclusions, extras, order_date) values
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

select * from customer_order;

CREATE TABLE customer_orders_temp AS
SELECT 
  order_id, 
  customer_id, 
  pizza_id, 
  CASE
	  WHEN exclusions IS null OR exclusions LIKE 'null' THEN ' '
	  ELSE exclusions
	  END AS exclusions,
  CASE
	  WHEN extras IS NULL or extras LIKE 'null' THEN ' '
	  ELSE extras
	  END AS extras,
	order_date
FROM pizza_metric.customer_order;