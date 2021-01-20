use bank;
SELECT * from card where issued > 980000 and type = 'junior'; #1
SELECT * from trans where type = 'VYDAJ' and operation != 'VYBER' LIMIT 10; #2
SELECT loan_id,account_id, (amount-payments) as debt_value from loan where status = 'B' and (amount-payments) > 1000 order by debt_value DESC; #3
SELECT min(amount) as min_amount, max(amount) as max_amount from trans where amount > 0; #4
SELECT *, SUBSTR(date,1,2) as YEAR from account;