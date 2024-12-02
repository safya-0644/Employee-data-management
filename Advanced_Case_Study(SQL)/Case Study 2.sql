#How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
select
week(registration_date) as registered_week,
count(runner_id) as runner_signup
from runners
group by registered_week
order by registered_week;

#What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pick up the order?
with time_taken_cte AS
(
  select 
    c.order_id, 
    c.order_date, 
    r.pickup_time, 
    timestampdiff(minute, c.order_date, r.pickup_time) as pickup_minutes
  from customer_orders_temp c
  join runner_orders_temp r
    on c.order_id = r.order_id
  where r.distance != 0
  group by c.order_id, c.order_date, r.pickup_time
)
select 
  avg(pickup_minutes) as avg_pickup_minutes
from time_taken_cte
where pickup_minutes > 1;

#Is there any relationship between the number of pizzas and how long the order takes to prepare?
with prep_time_cte as
(
  select
    c.order_id, 
    count(c.order_id) as pizza_order, 
    c.order_date, 
    r.pickup_time, 
    timestampdiff(MINUTE, c.order_date, r.pickup_time) AS prep_time_minutes
  from customer_orders_temp as c
  join runner_orders_temp as r
    on c.order_id = r.order_id
  where r.distance != 0
  group by c.order_id, c.order_date, r.pickup_time
)
select 
  pizza_order, 
  avg(prep_time_minutes) as avg_prep_time_minutes
from prep_time_cte
where prep_time_minutes > 1
group by pizza_order;

#Is there any relationship between the number of pizzas and how long the order takes to prepare?
select 
  c.customer_id, 
  avg(r.distance) aS avg_distance
from customer_orders_temp c
join runner_orders_temp r
  on c.order_id = r.order_id
where r.duration != 0
group by c.customer_id;

#What was the difference between the longest and shortest delivery times for all orders?
select 
  order_id, duration
from runner_orders_temp
where duration not like ' ';

select 
  max(cast(duration as unsigned)) - min(cast(duration as unsigned)) as delivery_time_difference
from runner_orders_temp
where duration != '' and duration is not null;

#What was the average speed for each runner for each delivery and do you notice any trend for these values?
select 
  r.runner_id, 
  c.customer_id, 
  c.order_id, 
  count(c.order_id) as pizza_count, 
  r.distance, (r.duration / 60) as duration_hr , 
  round((r.distance/r.duration * 60), 2) as avg_speed
from runner_orders_temp r
join customer_orders_temp c
  on r.order_id = c.order_id
where distance != 0
group by r.runner_id, c.customer_id, c.order_id, r.distance, r.duration
order by c.order_id;

#What is the successful delivery percentage for each runner?
select 
  runner_id, 
  round(100 * sum(
    case when distance = 0 then 0
    else 1 end) / COUNT(*), 0) as success_perc
from runner_orders_temp
group by runner_id;


