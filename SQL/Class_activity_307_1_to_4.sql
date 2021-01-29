# Class Activity 3.07

use bank;

create or replace view user_activity as
select account_id, convert(date, date) as Activity_date,
date_format(date, '%m') as Activity_Month,
date_format(convert(date,date), '%Y') as Activity_year
from bank.trans;

create or replace view Monthly_active_users as
select count(distinct account_id) as Active_users, Activity_year, Activity_Month
from user_activity
group by Activity_year, Activity_Month
order by Activity_year, Activity_Month;

#Activity 1
-- edit query:
with cte_activity as (
  select Active_users, 100*Active_users/(lag(Active_users,1) over (partition by Activity_year))-100 as percentage_of_variation_to_prev_month, (lag(Active_users,1) over (partition by Activity_year)) as last_month,Activity_year, Activity_month
  from Monthly_active_users
)
select * from cte_activity
where last_month is not null;

#Activity 2
create or replace view Monthly_lost_users as
select account_id as Active_Account_id, Activity_year, Activity_Month
from user_activity
group by Activity_year, Activity_Month, account_id
order by Activity_year, Activity_Month, account_id;

#get lost customers if there are any:
-- with cte_activity as (
--   select MAU1.Active_Account_id, MAU2.Active_Account_id, MAU1.Activity_year, MAU1.Activity_month, MAU2.Activity_year, MAU2.Activity_month
--   from Monthly_lost_users MAU1
--   join Monthly_lost_users MAU2
--   on MAU1.Activity_year = MAU2.Activity_year and MAU1.Activity_month = MAU2.Activity_month + 1
--   where MAU1.Active_Account_id <> MAU2.Active_Account_id
-- )
-- select * from cte_activity
-- where last_month is not null;

# get number of gains/lost customers
with cte_activity as (
  select Active_users, Active_users - (lag(Active_users,1) over (partition by Activity_year)) as Customer_gained, (lag(Active_users,1) over (partition by Activity_year)) as last_month,Activity_year, Activity_month
  from Monthly_active_users
)
select * from cte_activity
where last_month is not null;

#Activity 3
create or replace view trans_activity as
select account_id, convert(date, date) as Activity_date,
date_format(date, '%m') as Activity_Month,
date_format(convert(date,date), '%Y') as Activity_year,
amount as Amount
from trans;

create or replace view Monthly_trans_activity as
select activity_year, activity_month, account_id, round(sum(Amount),2) as Monthly_Transaction
FROM trans_activity
group by 1, 2, 3
order by 1, 2, 3;

with cte_trans_activity as (
  select Monthly_Transaction, round(Monthly_Transaction - (lag(Monthly_Transaction,1) over (partition by Activity_year)),2) as Trans_difference_to_prev_month, (lag(Monthly_Transaction,1) over (partition by Activity_year)) as last_month_trans ,Activity_year, Activity_month
  from Monthly_trans_activity
)
select * from cte_trans_activity
where last_month_trans is not null;


