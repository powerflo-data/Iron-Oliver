# Lab 3.05
use sakila;

#1
select f.title as Filmtitle, count(i.inventory_id) as Number_of_Copies
from inventory i
join film f
on f.film_id = i.film_id
where i.film_id = (select film_id as ID from film where title = 'Hunchback Impossible');

#2
select title as Filmtitle, length as Filmlength from film
where length > (select avg(length) from film)
order by Filmlength ASC;

#3
select last_name, first_name  from actor
where actor_id in (
	select actor_id from film_actor
	where film_id = (select film_id from film where title = 'Alone Trip'))
order by last_name, first_name;

#4
select title from film
where film_id in (
	select film_id from film_category
	where category_id = (select category_id from category where name = 'Family'))
order by title;

#5
#using Subqueries:
select last_name, first_name, email from customer
where address_id in (
    #get all the address IDs for the city IDs:
	select address_id from address where city_id in (
		#get all the cities (IDs) of Canada from DB:
		select city_id from city where country_id = (select country_id from country where country = 'Canada')
		))
order by last_name, first_name;

#using joins:
select last_name, first_name, email from customer c
join address a
on c.address_id = a.address_id
join city ci
on ci.city_id = a.city_id
join country co
on co.country_id = ci.country_id
where co.country = 'Canada'
order by last_name, first_name;

#6
select title from film
where film_id in(
	select film_id from film_actor
	where actor_id = (select actor_id from
						(select actor_id, count(film_id) as Number_of_films_played_in, rank() over (order by count(film_id) DESC) as 'Ranking'
							from film_actor
							group by actor_id) sub1
						where Ranking =1)
				)
order by title;

#7
select title as Filmtitle_by_most_profit_Customer from film
where film_id in (
				select distinct(film_id) from inventory
				where inventory_id in (
										select inventory_id from rental
										where customer_id = (select customer_id from
																(select customer_id, sum(amount) as Total_Amount, rank() over (order by sum(amount) DESC) as 'Ranking'
																	from payment
																	group by customer_id) sub1
															where Ranking = 1)
										)
				)
order by title;

#8
select first_name, last_name from customer
where customer_id in (select customer_id from (
						select customer_id, avg(amount) as Average_payment 
                        from payment
						group by customer_id
						having Average_payment > (select avg(amount) as Avgamount from payment)) sub1
                        );

