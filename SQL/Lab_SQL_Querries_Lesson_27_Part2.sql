use sakila;
#1
select count(actor_id) as Number_of_actors_with_same_Lastnames, first_name as Firstname, last_name as Lastname from actor
group by last_name
having Number_of_actors_with_same_Lastnames = 1
order by Lastname;

#2
select count(actor_id) as Number_of_actors_with_same_Lastnames, first_name as Firstname, last_name as Lastname from actor
group by last_name
having Number_of_actors_with_same_Lastnames > 1
order by Lastname;

#3
select count(rental_id) as Number_of_rentals, staff_id
from rental
group by staff_id
order by Number_of_rentals DESC;

#4
select count(film_id) as Number_of_films, release_year
from film
group by release_year
order by release_year;

#5
select count(film_id), rating as Rating
from film
group by Rating
order by Rating DESC;

#6
select round(avg(length),2) as Average_lengths_in_min, rating as Rating
from film
group by Rating
order by Rating;

#7
select round(avg(length),2) as Average_lengths_in_min, rating as Rating
from film
group by Rating
having Average_lengths_in_min > 120
order by Rating;