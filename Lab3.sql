--Michael Read--
--Lab 3--

--Question 1--
select ordnum, totalUSD
from Orders;

--Question 2--
select name, city
from Agents
where name = 'Smith';

--Question 3--
select pid, name, priceUSD
from Products
where quantity > 201000;

--Question 4--
select name, city
from Customers
where city = 'Duluth';

--Question 5--
select name
from Agents
where not (city iN ('New York', 'Duluth'));

--Question 6--
select *
from Products
where not (city in ('Dallas', 'Duluth'))
  and priceUSD >= 1;

--Question 7--
select *
from Orders
where mon in ('feb', 'mar');

--Question 8--
select *
from Orders
where mon = 'feb'
  and totalUSD >= 600;

--Question 9--
select *
from Orders
where cid = 'c005';