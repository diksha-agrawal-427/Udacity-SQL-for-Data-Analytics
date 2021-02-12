## 1. Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.
select left(primary_poc,position(' ' IN primary_poc)-1) as Fname, 
right(primary_poc, length(primary_poc)-strpos(primary_poc,' ')) as Lname 
from accounts;

## 2. Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
select left(name, strpos(name,' ')-1) as Fname, 
right(name, length(name)-position(' ' in name)) as Lname
from sales_reps;
