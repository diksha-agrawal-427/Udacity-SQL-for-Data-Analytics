/* 1. You'll need to use occurred_at and total_amt_usd in the orders table along with LEAD and LAG to do so. 
In your query results, there should be four columns: occurred_at, total_amt_usd, lead, and lead_difference.*/
SELECT account_id,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY total_amt_usd) AS lead,
       LAG(total_amt_usd) OVER (ORDER BY total_amt_usd) AS lag,
       total_amt_usd - LAG(total_amt_usd) OVER (ORDER BY total_amt_usd) AS lag_difference,
       LEAD(total_amt_usd) OVER (ORDER BY total_amt_usd)-total_amt_usd AS lead_difference
FROM (
SELECT account_id,
       SUM(total_amt_usd) AS total_amt_usd
  FROM orders 
 GROUP BY 1
 ) sub
 
/* 2. Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. 
Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased, 
and one of four levels in a standard_quartile column. */
select account_id, occurred_at, standard_qty, NTILE(4) over (partition by account_id order by standard_qty) as standard_quartile from orders;

/* 3. Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders. 
Your resulting table should have the account_id, the occurred_at time for each order, the total amount of gloss_qty paper purchased, 
and one of two levels in a gloss_half column.*/
select account_id, occurred_at, gloss_qty, ntile(2) over (partition by account_id order by gloss_qty) as gloss_half from orders;

/* 4.Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders. 
Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased, 
and one of 100 levels in a total_percentile column.*/
select account_id, occurred_at, total_amt_usd, ntile(100) over (partition by account_id order by total_amt_usd) as total_percentile from orders;
