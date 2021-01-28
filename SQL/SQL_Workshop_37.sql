# SQL Workshop
# Bank DB
use bank;

#1
with cte_gendersplit as(
	with cte_birthtable as (
		select *, (concat(SUBSTR(birth_number, 1, 2), IF(SUBSTR(birth_number, 3, 2) > 50, LPAD((SUBSTR(birth_number, 3, 2)-50),2,0), SUBSTR(birth_number, 3, 2)), SUBSTR(birth_number, 5, 2))) as DOB, 
		IF(SUBSTR(birth_number, 3, 2) > 50, 'Female', 'Male') as Sex
        from client
	)
	select sex, count(sex) as gender_split from cte_birthtable
	group by sex)
select sex as Sex, gender_split/(select sum(gender_split) from cte_gendersplit) as Gender_split from cte_gendersplit;

#alternative using case clause:
select Gender, count(Gender)/(select count(*) from client) from (
	select *, case
	when SUBSTR(birth_number, 3, 2) > 50 then 'Female'
	else 'Male'
	end as Gender
	from client) sub1
group by Gender;


#2
# check accounts with more than 2 linked clients:
select count(disp_id) as Number_of_clients, account_id from disp
group by account_id
having Number_of_clients > 2;
#there are no accounts with more than 2 linked clients!

#3
select round(avg(t.amount),0) as Average_Trans_Amount, d.A2 as District, a.district_id from trans t
join account a
on a.account_id = t.account_id
join district d
on a.district_id = d.A1
group by a.district_id
order by a.district_id;

#4
select bank, 100*sum(amount)/(select sum(amount) from trans) as Percentage_of_total_transactions from trans
group by bank
order by bank;

select 100*sum(amount)/(select sum(amount) from trans) as Percentage_sent_to_another_bank from trans
where operation = 'PREVOD NA UCET';

#5
#whether district_id of accounts matters:
#get district ids and names:
select d.A2 as District, d.A1 as DistrictID, count(a.district_id) as Number_of_clients from account a
join district d
on d.A1 = a.district_id
where a.account_id in (
	#get account_ids with status B or D:
	select account_id from loan
	where status in ('B','D') and account_id in (
		# get owners:
		select account_id from disp where type = 'Owner'
		)
	)
group by a.district_id
order by Number_of_clients DESC
limit 10;

#wheter district id of clients matter:
select a.A3, count(*) as no_of_clients_owner
from district as a
join account as b
on a.A1 = b.district_id
where account_id in (select account_id from disp
					where type = 'OWNER'
					and account_id in (select account_id from loan
					where status in ('D','B')))
group by a.A3
order by count(*) desc;


#publications DB:
use publications;

#Challange 1
Drop view if exists total_royalty_by_title;
create view total_royalty_by_title as
with cte_royalty as(
	select s.stor_id, s.title_id, ta.au_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty
    from titles t
    join sales s
    on s.title_id = t.title_id
    join titleauthor ta
    on ta.title_id = t.title_id
    )
select title_id, au_id, sum(sales_royalty) as Aggregated_royalties
from cte_royalty
group by au_id, title_id
order by au_id;

select au_id, sum(Aggregated_royalties) as Profits
from total_royalty_by_title
group by au_id
order by Profits DESC
limit 3;


#Challenge 2
#done and understood the difference between cte (query avaiable) 
# / view (avaiable during session but updating and performing calc again when refering to)
# / temp table ( avaiable during session and will remain the same as long as updating/inserting data)

#Challenge 3
drop temporary table if exists profits_by_author;
create temporary table profits_by_author as
select au_id, sum(Aggregated_royalties) as Profits
from total_royalty_by_title
group by au_id
order by Profits DESC;

select * from profits_by_author;