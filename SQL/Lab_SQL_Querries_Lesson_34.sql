#Lab 3.04
use test; # As DB for this lab

select * from customer;

# Query 1
select ID, LAST_NAME, FIRST_NAME,  (CHAR_LENGTH(LAST_NAME) + CHAR_LENGTH(FIRST_NAME)) as Name_lengths from customer
where CHAR_LENGTH(LAST_NAME) + CHAR_LENGTH(FIRST_NAME) < 12
order by Name_lengths, LAST_NAME, FIRST_NAME, ID ASC;

# Query 2
select d.name as Department, count(e.id) as Number_of_Employes 
from department d
left join employee e
on d.id = e.dept_id
group by d.id
order by Number_of_Employes DESC, Department;

# Query 3
select eu.uin as UIN, e.name as Name, e.id as ID,  e.age as Age 
from employee e
join employee_uin eu
on e.id = eu.id
where e.age < 25
order by Name, ID ASC; 

# Query 4
select e1.name as Name_lower_salary, e2.name as Name_higher_salary
from employee e1
cross join employee e2
on e1.id <> e2.id 
where e1.salary < e2.salary
order by e1.id, e2.salary ASC;
