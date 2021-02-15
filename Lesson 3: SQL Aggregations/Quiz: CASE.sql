/* 1. Write a query to display for each order, the account ID, total amount of the order, 
and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000. */
select account_id, total_amt_usd, 
case when total_amt_usd >= 3000 then 'Large' else 'Small'
end as Level_of_order from orders;

/* 2. Write a query to display the number of orders in each of three categories, based on the total number of items in each order. 
The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'. */
select case
when total>=2000 then 'At least 2000'
when total between 1000 and 2000 then 'Btween 1000 and 2000'
when total < 1000 then 'Less than 1000'
end as category, count(*) as count_order
from orders group by 1;

/* 3. We would like to understand 3 different levels of customers based on the amount associated with their purchases. 
The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. 
Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, 
and the level. Order with the top spending customers listed first. */
select a.name, sum(o.total_amt_usd), case
when sum(o.total_amt_usd)>200000 then 'High'
when sum(o.total_amt_usd) between 200000 and 100000 then 'Medium'
else 'Low' end as Level 
from orders o join accounts a on o.account_id=a.id
group by 1 order by 2 desc;

/* 4. We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. 
Keep the same levels as in the previous question. Order with the top spending customers listed first. */
select a.name, sum(o.total_amt_usd), case
when sum(o.total_amt_usd)>200000 then 'High'
when sum(o.total_amt_usd) between 200000 and 100000 then 'Medium'
else 'Low' end as Level 
from orders o join accounts a on o.account_id=a.id where o.occurred_at > '2015-12-31'
group by 1 order by 2 desc;

/* 5. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. 
Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. 
Place the top sales people first in your final table. */
select s.name, count(o.id) as num_ords, case
when count(o.id)>200 then 'Top'
else 'Not' end as sales_rep_level
from orders o join accounts a on o.account_id=a.id
join sales_reps s on a.sales_rep_id=s.id
group by 1 order by 2 desc;

/* 6. The previous didn't account for the middle, nor the dollar amount associated with the sales. 
Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, 
which are sales reps associated with more than 200 orders or more than 750000 in total sales. 
The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, t
he total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. 
Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria! */
select s.name, count(o.id) as num_ords, sum(o.total_amt_usd) as dollar_amt, 
case
when count(o.id)>200 or sum(o.total_amt_usd)>750000 then 'Top'
when count(o.id)>150 or sum(o.total_amt_usd)>500000 then 'Middle'
else 'Not' end as sales_rep_level
from orders o join accounts a on o.account_id=a.id
join sales_reps s on a.sales_rep_id=s.id group by 1 order by 3 desc;

