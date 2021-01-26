# Lab 3.03
use sakila;

#1 Pairs of Actors (based on Ids)
select fa1.actor_id, fa2.actor_id, fa1.film_id from film_actor fa1
join film_actor fa2
on fa1.film_id = fa2.film_id
where fa1.actor_id <> fa2.actor_id and fa2.actor_id > fa1.actor_id;

# Pairs of Actors (based on Names)
drop table temp_pair_actor;
create temporary table temp_pair_actor
select fa1.actor_id as Actor1, fa2.actor_id as Actor2, fa1.film_id from film_actor fa1
join film_actor fa2
on fa1.film_id = fa2.film_id
where fa1.actor_id <> fa2.actor_id and fa2.actor_id > fa1.actor_id;

select a1.first_name, a1.last_name, a2.first_name, a2.last_name, tp.film_id as Film_id from temp_pair_actor tp
join actor a1
on tp.actor1 = a1.actor_id
join actor a2
on tp.actor2 = a2.actor_id;

#2 Get all pairs of customers that have rented the same film more than 3 times.
select c.first_name as Firstname, c.last_name as Lastname,  f.title as Filmtitle ,  count(i.film_id) as Number_of_rentals
from rental r
join rental r2
on r.rental_id <> r2.rental_id
join inventory i
on r.inventory_id = i.inventory_id
join inventory i2
on r2.inventory_id = i2.inventory_id
join film f
on f.film_id = i.film_id
join customer c
on c.customer_id =  r.customer_id
where r.customer_id = r2.customer_id and i.film_id = i2.film_id and r2.rental_id > r.rental_id 
group by r.customer_id
having Number_of_rentals > 3
order by r.customer_id;

#3 all possible pairs of actors?
select * from (select distinct film_id from film_actor)sub1
join (select distinct actor_id from film_actor)sub2;