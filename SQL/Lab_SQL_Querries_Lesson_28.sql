use sakila;

# Lab 2.08

#1
select title as Title, length as Length, rank() over (order by length DESC) as 'Rank'
from film
having length <> '0s' or length <> '';

#2
select title as Title, length as Length, rating as Rating, rank() over (partition by rating order by length DESC) as 'Rank'
from film
having length <> '0s' or length <> '';

#3
select count(fil.film_id) as Number_of_films, cat.name as Category
from film as fil
inner join film_category as filcat
right join category as cat
on filcat.film_id = fil.film_id and cat.category_id = filcat.category_id
group by cat.category_id
order by Category;

#4 actor with most films
Select act.actor_id, act.first_name, act.last_name, count(act.actor_id) as film_count
from sakila.actor as act
join sakila.film_actor as fil_act
on act.actor_id = fil_act.actor_id
Group by actor_id
Order by film_count desc
Limit 1;

#or use "using" clause:
Select actor.actor_id, actor.first_name, actor.last_name, count(actor_id) as film_count
from sakila.actor join sakila.film_actor using (actor_id)
Group by actor_id
Order by film_count desc
Limit 1;

#5 customer with most rentals
Select cus.*, count(rent.rental_id) as rental_count
From sakila.customer as cus
join sakila.rental as rent
on cus.customer_id = rent.customer_id
Group by customer_id
Order by rental_count desc
Limit 1;

#or use "using" clause:
Select customer.*, count(rental_id) as rental_count
From sakila.customer join sakila.rental using (customer_id)
Group by customer_id
Order by rental_count desc
Limit 1;

#Bonus
Select fil.title, count(rent.rental_id) as rental_count
From sakila.film as fil
inner join sakila.inventory as inv
Inner join sakila.rental as rent 
on fil.film_id = inv.film_id and inv.inventory_id = rent.inventory_id
Group by fil.film_id
Order by rental_count desc
Limit 1;

#or use "using" clause:
Select film.title, count(rental_id) as rental_count
From sakila.film inner join sakila.inventory using (film_id)
Inner join sakila.rental using (inventory_id)
Group by film_id
Order by rental_count desc
Limit 1;