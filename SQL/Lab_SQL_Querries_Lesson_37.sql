# Lab 3.07

use sakila;
#1 Get number of monthly active customers
create or replace view user_activity as
select customer_id,date_format(rental_date, '%d') as Activity_day,
date_format(rental_date, '%m') as Activity_Month,
date_format(rental_date, '%Y') as Activity_Year
from rental;

create or replace view Monthly_active_users as
select count(distinct customer_id) as Active_users, Activity_Month, Activity_Year
from user_activity
group by Activity_Year, Activity_Month
order by Activity_Year, Activity_Month;

select * from Monthly_active_users;

#2 Active users in the previous month.
with cte_activity as (
  select Active_users, (lag(Active_users,1) over (partition by Activity_year)) as last_month,Activity_year, Activity_month
  from Monthly_active_users
)
select * from cte_activity
where last_month is not null;

#3 Percentage change in the number of active customers
with cte_activity as (
  select Active_users, (lag(Active_users,1) over (partition by Activity_year)) as last_month,
  Active_users*100/(lag(Active_users,1) over (partition by Activity_year)) - 100 as percentage_change_to_last_month,
  Activity_year, Activity_month
  from Monthly_active_users
)
select * from cte_activity
where last_month is not null;

#4 Retained customers every month
create or replace view customer_retaining as
select distinct customer_id,
date_format(rental_date, '%m') as Activity_Month,
date_format(rental_date, '%Y') as Activity_Year
from rental
order by Activity_Year, Activity_Month, customer_id;

with cte_activity as (
  select count(cr.customer_id) as Retained_Customer, cr.Activity_year, cr.Activity_month
  from customer_retaining cr
  where cr.customer_id in (
							select customer_id from customer_retaining cr2
                            where cr.Activity_month = cr2.Activity_month + 1
                            )
 group by Activity_month
)
select * from cte_activity;


