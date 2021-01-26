# Class Activity 3.03

#Examples:
select * from bank.account a1
join bank.account a2
on a1.account_id <> a2.account_id
and a1.district_id = a2.district_id
order by a1.district_id;select a1.account_id, a2.account_id, a1.district_id
from bank.account a1
join bank.account a2
on a1.account_id <> a2.account_id
and a1.district_id = a2.district_id
order by a1.district_id, a1.account_id;


create temporary table temp1
select d1.account_id, d1.client_id, d2.disp_id, rank() over(partition by d1.account_id order by d1.client_id) as Ranks
from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id
and d1.type <> d2.type
order by Ranks, d1.account_id;

select account_id, client_id, disp_id
from temp1
where Ranks = 1;


select * 
from 
(
  select distinct type from bank.card
)sub1
cross join
(
  select distinct type from bank.disp
)sub2;

SELECT 
    c1.city, 
    c1.customerName, 
    c2.customerName
FROM
    customers c1
INNER JOIN customers c2 ON 
    c1.city = c2.city
    AND c1.customername > c2.customerName
ORDER BY 
    c1.city;


#From Aleksj:
select *
from
(select  in2.film_id, a1.customer_id as First_pair, a2.customer_id as Second_pair , count(*) as number_films, rank() over(partition by a1.customer_id order by a2.customer_id) as Ranks
from sakila.customer a1
inner join rental re1 on re1.customer_id = a1.customer_id
inner join inventory in1 on (re1.inventory_id = in1.inventory_id)
inner join film fa1 on in1.film_id=fa1.film_id
inner join inventory in2 on (fa1.film_id = in2.film_id)
inner join rental re2 on re2.inventory_id=in2.inventory_id
inner join customer a2 on re2.customer_id=a2.customer_id
where a1.customer_id <> a2.customer_id
group by a1.customer_id, a2.customer_id
having count(*)>3
order by number_films desc)tab
where Ranks=1;

#from Brett:
select in2.film_id as FilmID, a1.customer_id as ID1, a2.customer_id as ID2 , count(*) as Count
from sakila.customer a1
inner join rental re1 
on re1.customer_id = a1.customer_id
inner join inventory in1 
on re1.inventory_id = in1.inventory_id
inner join film fa1
on in1.film_id=fa1.film_id
inner join inventory in2
on fa1.film_id = in2.film_id
inner join rental re2
on re2.inventory_id=in2.inventory_id
inner join customer a2
on re2.customer_id=a2.customer_id where a1.customer_id <> a2.customer_id and a2.customer_id>a1.customer_id
group by a1.customer_id, a2.customer_id 
having count(*)>3
order by Count desc;




#Activity 1:
use bank;
select d1.account_id, d1.type,d2.type, rank() over (order by d1.type) as 'Ranking' from disp d1
join disp d2
on d1.account_id = d2.account_id
where d1.type <> d2.type
order by Ranking, d1.account_id;




