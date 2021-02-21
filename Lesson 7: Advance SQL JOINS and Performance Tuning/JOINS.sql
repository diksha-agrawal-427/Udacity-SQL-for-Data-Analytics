/* 1. write a query with FULL OUTER JOIN to fit the above described Parch & Posey scenario (selecting all of the columns in both of the relevant tables, 
accounts and sales_reps)*/
select * from accounts full join sales_reps on accounts.sales_rep_id =  sales_reps.id;

/* 2. Inequality oprater: write a query that left joins the accounts table and the sales_reps tables on each sale rep's ID number and 
joins it using the < comparison operator on accounts.primary_poc and sales_reps.name,*/
select * from accounts a left join sales_reps s on a.sales_rep_id = s.id and a.primary_poc < s.name;

/* 3. SELF JOIN: Modify the query from the previous video, which is pre-populated in the SQL Explorer below, 
to perform the same interval analysis except for the web_events table. Also:
change the interval to 1 day to find those web events that occurred after, but not more than 1 day after, another web event
add a column for the channel variable in both instances of the table in your query*/
SELECT o1.id AS o1_id,
       o1.account_id AS o1_account_id,
       o1.occurred_at AS o1_occurred_at,
       o2.id AS o2_id,
       o2.account_id AS o2_account_id,
       o2.occurred_at AS o2_occurred_at
  FROM orders o1
 LEFT JOIN orders o2
   ON o1.account_id = o2.account_id
  AND o2.occurred_at > o1.occurred_at
  AND o2.occurred_at <= o1.occurred_at + INTERVAL '1 day'
ORDER BY o1.account_id, o1.occurred_at

/* 4. UNION / UNION ALL: Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table. */
select * from accounts
union all
select * from accounts

/* 5. Add a WHERE clause to each of the tables that you unioned in the query above, 
filtering the first table where name equals Walmart and filtering the second table where name equals Disney. */
select * from accounts where name='Walmart'
union all
select * from accounts where name='Disney'

/* 6. Perform the union in your first query (under the Appending Data via UNION header) in a common table expression and name it double_accounts. 
Then do a COUNT the number of times a name appears in the double_accounts table.*/
With double_accounts as (
select * from accounts
union all
select * from accounts)
select name, count(*) from double_accounts group by 1;
