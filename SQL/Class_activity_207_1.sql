use bank;
alter table loan
add status_desc varchar(30);
select * from loan;
update loan set status_desc = 
case
when status = 'A' then 'Good - Contract Finished'
when status = 'B' then 'Defaulter - Contract Finished'
when status = 'C' then 'Good - Contract Running'
when status = 'D' then 'In Debt - Contract Running'
end;
select * from loan;

select avg(amount) as Average, status from bank.loan
group by Status
order by Average asc;
#Objektiv: Max/Min for each status
select max(amount) as Maximum, min(amount) as Minimum, status from bank.loan
group by Status
order by Maximum asc;


