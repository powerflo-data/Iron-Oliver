# Lab 3.06

use sakila;

#1 List each pair of actors that have worked together.
select fa1.actor_id as Act1, fa2.actor_id as Act2, fa1.film_id as FilmID
from film_actor fa1
join film_actor fa2
on fa1.actor_id <> fa2.actor_id
where fa1.film_id = fa2.film_id and fa2.actor_id > fa1.actor_id;

#2 For each film, list actor that has acted in more films.

#get actors who played in more than one film:
create or replace view actors_with_more_films as
select actor_id, count(film_id) as Number_of_films 
from film_actor
group by actor_id
having Number_of_films > 1;

#show movies and only actors in it, who played in more than one film:
select film_id, actor_id from film_actor
where actor_id in (select actor_id from actors_with_more_films)
order by film_id, actor_id;

