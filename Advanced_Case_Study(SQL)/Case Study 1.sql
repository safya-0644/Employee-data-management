#How many pizzas were ordered?
select count(*) as pizza_count
from customer_orders_temp;

#How many unique customer orders were made?
select count(distinct order_id) as order_count 
from customer_orders_temp;

#How many successful orders were delivered by each runner?
select runner_id,
count(order_id) as successful_orders
from runner_orders_temp
where distance !=0
group by runner_id;

#How many of each type of pizza was delivered?
select p.pizza_name, count(c.pizza_id) as delivered_pizza_count
from pizza_name p
join customer_orders_temp c
on p.pizza_id=c.pizza_id
join runner_orders_temp r
on r.order_id=c.order_id
where r.distance !=0
group by p.pizza_name;

#How many Margherita and Pepperoni were ordered by each customer?
select c.customer_id, p.pizza_name, count(p.pizza_name) as order_count
from customer_orders_temp c
join pizza_name p
on c.pizza_id=p.pizza_id
group by c.customer_id,p.pizza_name
order by c.customer_id;

#What was the maximum number of pizzas delivered in a single order?
select c.order_id, count(c.pizza_id) as pizza_count
from customer_orders_temp c
join runner_orders_temp r
on c.order_id=r.runner_id
where distance!=0 
group by c.order_id;

#For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
select 
  c.customer_id,
  sum(
    case when c.exclusions <> ' ' or c.extras <> ' ' then 1
    else 0
    end) as at_least_1_change,
  sum(
    case when c.exclusions = ' ' and c.extras = ' ' then 1 
    else 0
    end) as no_change
from customer_orders_temp  c
join runner_orders_temp  r
  on c.order_id = r.order_id
where r.distance != 0
group by c.customer_id
order by c.customer_id;

#How many pizzas were delivered that had both exclusions and extras?
select 
sum(
case when exclusions is not null and extras is not null then 1
else 0
end) as pizza_count
from customer_orders_temp c
join runner_orders_temp t
on c.order_id=t.order_id
where distance >=1 
and exclusions <> ' '
and extras <> ' ';

#What was the total volume of pizzas ordered for each hour of the day?
select 
 hour(order_date) as hour_of_day, 
  count(order_id) as pizza_count
from customer_orders_temp
group by hour(order_date)
order by hour_of_day;

#What was the volume of orders for each day of the week?
select 
  dayname(date_add(order_date, interval 2 day)) AS day_of_week, 
  COUNT(order_id) AS total_pizzas_ordered
from customer_orders_temp
group by dayname(date_add(order_date, interval 2 day));
