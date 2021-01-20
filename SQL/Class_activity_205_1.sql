use bank;
DESCRIBE district;
SELECT * from district;
SELECT A2 as district_name, A11 as average_salary from district
where A11 > 10000; #1
SELECT * from loan where status = 'B'; #2
SELECT * from card where type = 'junior' limit 10; #3
SELECT loan_id,account_id, (amount-payments) as debt_value from loan where status = 'B'; #4
SELECT A2 as district_name, round(A4*A10/100) as urban_population from district; #5
SELECT A2 as district_name, round(A4*A10/100) as urban_pop from district where A10>50; #6