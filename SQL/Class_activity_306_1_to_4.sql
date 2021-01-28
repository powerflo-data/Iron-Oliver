# Activity 3.06
#examples:

with cte_loan as (
  select * from bank.loan
)
select * from cte_loan
where status = 'B';with cte_transactions as (
  select account_id, sum(amount), sum(balance)
  from bank.trans
  group by account_id
)
select * from cte_transactions ct
join account a
on ct.account_id = a.account_id;create view running_contract_ok_balances as
with cte_running_contract_OK_balances  as (
  select *, amount-payments as Balance
  from bank.loan
  where status = 'C'
  order by Balance
)
select * from cte_running_contract_OK_balances
where Balance > (
  select avg(Balance)
  from cte_running_contract_OK_balances
)
order by Balance desc
limit 20;drop view if exists customer_status_D;create view customer_status_D as
select * from bank.loan
where status = 'D'
with check option;create or replace view customer_status_D as
select * from bank.loan
where status = 'D'
with check option;select * from customer_status_D;insert into customer_status_D values (0000, 00000, 987398, 00000, 60, 00000, 'C');create or replace view customer_status_D as
select * from bank.loan
where status = 'D';select * from customer_status_D;insert into customer_status_D values (0000, 00000, 987398, 00000, 60, 00000, 'C');select * from  bank.loan
order by loan_id;drop view if exists customer_status_D;

# Activity 1
use bank;

with cte_account as 
		(
		select account_id, district_id, date(date) as date, rank() over (partition by district_id order by date(date)) as 'Ranking' from account
		order by district_id, date
		)
select account_id, district_id, date 
from cte_account
where Ranking = 1
order by district_id;

select *, week(date) as Week from trans
order by Week DESC;




# Activity 2
#check last year and week: Year:1998, Week: 52
select year(date) as Year, week(date) as Week from trans
order by Year DESC, Week DESC;

Drop view if exists last_week_withdrawals;
create view last_week_withdrawals as
	select account_id, round(sum(amount),0) as Total_amount_withdraws_last_week
	from trans
	where type = 'VYDAJ' and week(date) = 52 and year(date) = 1998
	group by account_id
    order by Total_amount_withdraws_last_week DESC;
    
select * from last_week_withdrawals;

# Activity 3
#select client_id, birth_number, not isnull(month(birth_number)) as Malebirthsex, isnull(month(birth_number)) as Femalebirthsex
#from client;
      
Drop view if exists client_demographics;
create view client_demographics as
    select client_id, (concat(SUBSTR(birth_number, 1, 2), IF(SUBSTR(birth_number, 3, 2) > 50, LPAD((SUBSTR(birth_number, 3, 2)-50),2,0), SUBSTR(birth_number, 3, 2)), SUBSTR(birth_number, 5, 2))) as date_of_birth, 
	IF(SUBSTR(birth_number, 3, 2) > 50, 'Female', 'Male') AS Gender from client;
    
select * from client_demographics;
   
   
select cd.Gender as Gender, l.status as Status, count(l.loan_id) as Number_of_Loans
from client_demographics cd
join disp d
on d.client_id = cd.client_id
join loan l
on l.account_id = d.account_id
group by l.status, cd.Gender
order by l.status;


    
    