/* 1. create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. 
Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.*/
select standard_amt_usd, sum(standard_amt_usd) over (order by occurred_at) as running_total from orders;

/* 2. create a running total of standard_amt_usd (in the orders table) over order time, but this time, 
date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. 
Your final table should have three columns: One with the amount being added for each row, one for the truncated date, 
and a final column with the running total within each year.*/
select standard_amt_usd, 
date_trunc('year', occurred_at) as years,
sum(standard_amt_usd) over (partition by date_trunc('year', occurred_at) order by occurred_at) as running_total
from orders;

/* 3. Select the id, account_id, and total variable from the orders table, 
then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. 
Your final table should have these four columns.*/
select id, account_id, total, rank() over (partition by account_id order by total desc) as total_rank from orders;

/* 4. create and use an alias to shorten the following query that has multiple window functions. 
Name the alias account_year_window, which is more descriptive than main_window in the example above.*/
SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
window account_year_window as (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at));
