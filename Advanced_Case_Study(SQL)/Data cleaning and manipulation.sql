#Removing null values
create table customer_orders_temp AS
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
FROM pizza_runner.customer_order;
select * from customer_orders_temp;

#Removing null values
create table runner_orders_temp as
select 
  order_id, 
  runner_id,  
  case
	  WHEN pickup_time LIKE 'null' THEN ' '
	  ELSE pickup_time
	  END AS pickup_time,
  CASE
	  WHEN distance LIKE 'null' THEN ' '
	  WHEN distance LIKE '%km' THEN TRIM('km' from distance)
	  ELSE distance 
    END AS distance,
  CASE
	  WHEN duration LIKE 'null' THEN ' '
	  WHEN duration LIKE '%mins' THEN TRIM('mins' from duration)
	  WHEN duration LIKE '%minute' THEN TRIM('minute' from duration)
	  WHEN duration LIKE '%minutes' THEN TRIM('minutes' from duration)
	  ELSE duration
	  END AS duration,
  CASE
	  WHEN cancellation IS NULL or cancellation LIKE 'null' THEN ' '
	  ELSE cancellation
	  END AS cancellation
FROM pizza_runner.runner_order;
select * from runner_orders_temp;

#Altering the datatype
ALTER TABLE runner_orders_temp
modify COLUMN pickup_time datetime,
modify COLUMN distance FLOAT,
modify COLUMN duration INT;

#Setting constraints
alter table customer_orders_temp 
add foreign key(pizza_id) 
references pizza_name(pizza_id);

alter table customer_orders_temp 
add foreign key(order_id)
references runner_orders_temp(order_id);

alter table runner_orders_temp
add primary key(order_id),
add foreign key(runner_id)
references runners(runner_id);
