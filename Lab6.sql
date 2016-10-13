--Michael Read--
--Lab 6--

--Question 1--
/*Display the name and city of customers who live in any city that makes the most different kinds of products. 
(There are two cities that make the most different products. Return the name and city of customers from either
 one of those.)*/
select name, city
from customers
where city in  (select city
                from products
                group by city
                order by count(city) desc
                limit 1);

--Question 2--
/*Display the names of products whose priceUSD is strictly below the average priceUSD, 
in reverse-alphabetical order.*/
select name
from products
where priceUSD < (select avg(priceUSD)
                  from products)
order by name desc;

--Question 3--
/*Display the customer name, pid ordered, and the total for all orders, 
sorted by total from low to high.*/
select c.name, o.pid, o.totalUSD
from orders o left outer join customers c on o.cid = c.cid
order by o.totalUSD asc;

--Question 4--
/*Display all customer names (in alphabetical order) and their total ordered, 
and nothing more. Use coalesce to avoid showing NULLs.*/
select c.name, coalesce(sum(totalUSD), 0.00)
from orders o right outer join customers c on o.cid = c.cid
group by c.cid
order by c.name asc;

--Question 5--
/*Display the names of all customers who bought products from agents based in 
New York along with the names of the products they ordered, and the names of 
the agents who sold it to them.*/
select c.name, p.name, a.name
from orders o inner join customers c on o.cid = c.cid
              inner join agents a on o.aid = a.aid
              inner join products p on o.pid = p.pid
where o.aid in (select aid
              from agents
              where city = 'New York');

--Question 6--
/*Write a query to check the accuracy of the dollars column in the Orders table. 
This means calculating Orders.totalUSD from data in other tables and comparing 
those values to the values in Orders.totalUSD. Display all rows in Orders where 
Orders.totalUSD is incorrect, if any.*/
select *
from orders o inner join products p on o.pid = p.pid
              inner join customers c on o.cid = c.cid
where not o.totalUSD = o.qty * p.priceUSD * (1 - (c.discount / 100))

--Question 7--
/*What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? 
Give example queries in SQL to demonstrate. (Feel free to use the CAP 
database to make your points here.)*/

/*The difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN is which side has
all of its data shown, and which side gets padded with nulls. With an OUTER JOIN, 
one table has all of its data shown, instead of only data which has a link between the
two tables like an INNER JOIN. The LEFT and RIGHT in front of the OUTER JOIN specifies
which table will show all of its data, whether it will be the table on the left or right
of the OUTER JOIN statement. For an example, if you were to select * from customers c
LEFT OUTER JOIN agents a on c.city = a.city, the results would include every entry in
the customers table paired with the agents who share a city with them, however if an
entry in agents does not share a city with an entry in customers, that entry from agents
will be left out, and if an entry in customers does not share a city as an entry in agents,
then the entry from customers will be shown, but the values from the columns found in agents
will be null.*/
