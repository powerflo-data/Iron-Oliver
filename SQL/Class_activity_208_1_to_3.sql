use bank;
# Activity 1
#1
Select *, rank() over (order by A4) as 'Rank' from district;
Select *, rank() over (order by A9) as 'Rank' from district;
Select *, rank() over (order by A10) as 'Rank' from district;
Select *, rank() over (order by A11) as 'Rank' from district;
Select *, rank() over (order by A12) as 'Rank' from district;
#2
Select *, rank() over (partition by A3 order by A4) as 'Rank' from district;
Select *, rank() over (partition by A3 order by A9) as 'Rank' from district;
Select *, rank() over (partition by A3 order by A10) as 'Rank' from district;
Select *, rank() over (partition by A3 order by A11) as 'Rank' from district;
Select *, rank() over (partition by A3 order by A12) as 'Rank' from district;

select * from district;

#Activity 2
#1
select avg(balance) as Average_Balance, account_id
from trans
group by account_id
order by Average_Balance DESC
limit 20;

#2
#Rank
Select *, rank() over (order by A9) as 'Rank' from district;
#Rank jumps from 1 to 5, since there are 4 regions with the same amount of Cities (A9)
# max(Rank) = 76

#Dense Rank
Select *, dense_rank() over (order by A9) as 'Rank' from district;
#Rank numbers dont jump and continue with the next natural number, even though there are plenty of entries with the same rank before
#  max(Rank) = 11

#Activity 3
#1
select count(cl.client_id) as Number_of_Clients, dis.A2 as District, rank() over (order by count(cl.client_id) DESC) as 'Rank'
from bank.client as cl
inner join bank.district as dis
on cl.district_id = dis.A1
group by dis.A2
order by Number_of_Clients DESC;

#2
select count(cl.client_id) as Number_of_Clients, dis.A3 as Region, rank() over (order by count(cl.client_id) DESC) as 'Rank'
from bank.client as cl
inner join bank.district as dis
on cl.district_id = dis.A1
group by dis.A3
order by Number_of_Clients DESC;

#3 Total Amount and Average Amount for every District:
select sum(loa.amount) as Total_amount, round(avg(loa.amount),0) as Average_Amount, dis.A2 as 'District'#, rank() over (order by sum(loa.amount) DESC) as 'Rank'
from bank.account as acc
inner join bank.district as dis
inner join bank.loan as loa
on acc.account_id = loa.account_id and acc.district_id = dis.A1
group by dis.A2
order by Total_amount DESC;

#Himanshu Solution:
select d.A2 , sum(l.amount) as Total, avg(l.amount) as Average
from account a 
inner join district d on a.`district_id` = d.A1
inner join loan l on l.account_id = a.account_id
group by d.A2
order by Total DESC;


#4 Number of account by district and year:
select count(acc.account_id)  as Number_of_Accounts, year(acc.date) as Year, dis.A2 as District
from bank.account as acc
inner join bank.district as dis
on acc.district_id = dis.A1
group by year(acc.date), dis.A2
order by Year, Number_of_Accounts DESC;