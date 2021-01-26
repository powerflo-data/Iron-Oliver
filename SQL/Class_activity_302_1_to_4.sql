# Class Activity 302
#examples 1: (temporary table)
create temporary table bank.loan_and_amount
select l.loan_id, l.account_id, a.district_id, l.amount, l.payments, a.frequency
from bank.loan l
join bank.account a
on l.account_id = a.account_id;

select * from bank.loan_and_amount;

create temporary table bank.disp_and_account
select d.disp_id, d.client_id, d.account_id, a.district_id, d.type
from bank.disp d
join bank.account a
on d.account_id = a.account_id;

select * from bank.disp_and_account;

select * from bank.loan_and_amount la
join bank.disp_and_account da
on la.account_id = da.account_id
and la.district_id = da.district_id;



#examples 2:
select t.account_id, t.operation, a.frequency, sum(amount) as TotalAmount, sum(balance) as TotalBalance
from bank.trans t
left join bank.account a
on t.account_id = a.account_id
where t.operation = 'VKLAD' and balance > 1000
group by t.account_id, t.operation, a.frequency
having TotalAmount > 500000
order by TotalAmount desc
limit 10;

# examples 3:
select d.disp_id,d.type,d.client_id,c.birth_number, ca.type
from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.card ca
on d.disp_id = ca.disp_id
where ca.type = "gold";


#Activity 1
#1

use bank;
select da.A2 as District, c.client_id as ClientID, d.account_id as AccountID, d.type as Type from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.district da
on da.A1 = c.district_id
where d.type = 'Owner'
order by District;

#Activity 2
select d.A2 as District, round(avg(l.amount),0) as Avg_Loan, sum(l.amount) as Max_Loan 
from district d
join loan l
join account a
on l.account_id = a.account_id and a.district_id = d.A1
group by d.A2;

#Activity 3
create temporary table district_overview
select d.A2 as District, round(avg(l.amount),0) as Avg_Loan, sum(l.amount) as Max_Loan 
from district d
join loan l
join account a
on l.account_id = a.account_id and a.district_id = d.A1
group by d.A2;

select * from district_overview;

#Activity 4
