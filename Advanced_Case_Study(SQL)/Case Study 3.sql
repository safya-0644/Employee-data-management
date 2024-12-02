#What are the standard ingredients for each pizza?
select p.pizza_id,p.pizza_name, pt.toppings as pizza_ingredients
from pizza_name p
join pizza_recipe pt
on p.pizza_id=pt.pizza_id;

#What was the most commonly added extra?
select 
    pt.topping_id,
    pt.topping_name,
    count(oe.topping_id) as topping_count
from pizza_toppings pt
left join order_extras oe
on pt.topping_id = oe.topping_id
group by pt.topping_id, pt.topping_name;

#What was the most common exclusion?
with exclusions_cte as (
    select 
        order_id,
        cast(trim(substring_index(substring_index(exclusions, ',', numbers.n), ',', -1)) 
        as unsigned) as topping_id
    from customer_orders_temp
    join 
        (select 1 as n union select 2 union select 3 union select 4 union select 5) numbers
        on char_length(exclusions) - char_length(replace(exclusions, ',', '')) + 1 >= numbers.n
    where exclusions is not null
)
select 
    pt.topping_id,
    pt.topping_name,
    count(e.topping_id) as exclusion_count
from exclusions_cte e
join pizza_toppings pt
    on e.topping_id = pt.topping_id
group by pt.topping_id, pt.topping_name
order by exclusion_count desc
limit 1;
