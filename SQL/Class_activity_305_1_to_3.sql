# Activity 305

use bank;

# Activity 1
select a.account_id as ID, count(t.trans_id) as number_of_Trans
from account a
left join trans t
on t.account_id = a.account_id
group by a.account_id
having number_of_Trans > (select count(trans_id) / count(distinct(account_id)) as Average_number_of_Trans_per_Account from trans)
order by number_of_Trans ASC;

# Activity 2
#1
select * from account
where district_id in (
	select A1 from district
    where A3 = 'central Bohemia'
    );

#2
select a.* from account a
inner join district d
on d.A1 = a.district_id
where d.A3 = 'central Bohemia';

#3 Using Subquery is faster

# Activity 3
select account_id, count(trans_id) as activity
from trans
where account_id in 
(select account_id from account
where district_id in
(select distinct A1 from district
where A3 = 'Central Bohemia'))
group by account_id
order by activity desc
limit 1;
