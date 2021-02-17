use sakila;

#Lab 604
#1
select c.first_name, c.last_name, c.email 
from customer c
join rental r
on c.customer_id = r.customer_id
group by r.customer_id
order by c.last_name, c.first_name;

#2 
-- What is the average payment made by each customer 
-- (display the customer id, customer name (concatenated), and the average payment made).
select c.customer_id, CONCAT(c.last_name,' ',c.first_name)  as Name, avg(p.amount) as AVG_Payment
from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by c.customer_id;


#3
-- Select the name and email address of all the customers 
-- who have rented the "Action" movies.

#using joins:
select CONCAT(c.last_name,' ',c.first_name)  as Name, c.email as email
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
join film_category fc
on i.film_id = fc.film_id
join category cat
on fc.category_id = cat.category_id
where cat.name = 'Action'
group by c.customer_id
order by Name;

#using subquerries:
select CONCAT(last_name,' ',first_name)  as Name, email as email
from customer
where customer_id in (
						select customer_id 
                        from rental
                        where inventory_id in (
												select inventory_id
                                                from inventory
                                                where film_id in (
																	select film_id
                                                                    from film_category
                                                                    where category_id in (
																							select category_id
                                                                                            from category
                                                                                            where name = 'Action'
                                                                                            )
																	)
												)
						)
group by customer_id
order by Name;                


#4
-- Use the case statement to create a new column classifying existing columns as 
-- either or high value transactions based on the amount of payment. If the amount 
-- is between 0 and 2, label should be low and if the amount is between 2 and 4, 
-- the label should be medium, and if it is more than 4, then it should be high.
select *, (case when amount < 2 Then 'Low' when amount > 4 Then 'High' ELSE 'medium' end) as Payment_class
from payment;
