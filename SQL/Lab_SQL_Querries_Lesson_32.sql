# Lab 302
use sakila;
#1
select s.store_id as StoreID, c.city as City, co.country as Country 
from store s
join city c
join country co
join address ad
on s.address_id = ad.address_id and ad.city_id = c.city_id and c.country_id = co.country_id;

#2
select sto.store_id as StoreID, sum(p.amount) as Total_Revenue_in_US$
from store sto
join payment p
join staff sta
on sto.store_id = sta.store_id and sta.staff_id = p.staff_id
group by sto.store_id
order by Total_Revenue_in_US$ DESC;

#3
select avg(f.length) as Average_length, c.name as Category
from film f
join film_category fc
on f.film_id = fc.film_id
right join category c
on fc.category_id = c.category_id
group by c.name
order by Average_length DESC;

#4
create temporary table categorymaximum_running_by_category1
select f.length as Runningtime, c.name as Category, rank() over (order by f.length DESC) as 'Ranking'
from film f
join film_category fc
on f.film_id = fc.film_id
right join category c
on fc.category_id = c.category_id;

# Maximum Running time per category is:
select * from categorymaximum_running_by_category1
where Ranking = 1;

#5
select f.title as Most_frequently_rented_films, count(f.film_id) as Total_Rentals , rank() over (order by count(f.film_id) DESC) as 'Ranking'
from rental r
join inventory i
join film f
on r.inventory_id = i.inventory_id and i.film_id = f.film_id
group by f.film_id;

#6
select c.name as Category, sum(p.amount) as Total_Revenue , rank() over (order by sum(p.amount) DESC) as 'Ranking'
from rental r
join payment p
join inventory i
on r.rental_id = p.rental_id and r.inventory_id = i.inventory_id
join film f
join film_category fc
on i.film_id = f.film_id and f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
group by c.name
limit 5;