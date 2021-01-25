#Lab 301
use sakila;

#1
select count(f.film_id) as Number_of_films, c.name as Category from film_category f
join category c
on c.category_id = f.category_id
group by c.name
order by Number_of_films DESC;

#2
select s.first_name as First_Name, s.last_name as Last_Name, a.address as Adress from staff s
join address a
on s.address_id = a.address_id
order by First_Name;

#3
select sum(p.amount)  as Total_Amount, s.first_name as First_Name, s.last_name as Last_Name from staff s
right join payment p
on p.staff_id = s.staff_id
group by s.staff_id
order by Total_Amount DESC;

#4
select f.title as Film, count(fa.actor_id) as Number_of_actors from film f
join film_actor fa
on f.film_id = fa.film_id
group by f.title
order by Number_of_actors DESC;

#5
select c.last_name  as Lastname, sum(p.amount) as total_paid from payment p
join customer c
on c.customer_id = p.customer_id
group by c.customer_id
order by Lastname;