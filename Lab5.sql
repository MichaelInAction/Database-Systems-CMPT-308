--Michael Read--
--Lab 5--

--Question 1--
/*Show the cities of agents booking an order for a customer whose id is 'c006'*/
select distinct a.city
from orders o inner join agents a on o.aid = a.aid
where o.cid = 'c006';

--Question 2--
/*Show the ids of products ordered through any agent who makes at least one order
for a customer in kyoto, sorted by pid from highest to lowest*/
select distinct r.pid 
  from customers c inner join orders o on c.cid = o.cid and c.city = 'Kyoto' 
              left outer join orders r on r.aid = o.aid 
       order by r.pid asc;
--Question 3--
/*Show the names of customers who have never placed an order. Use a subquery*/
select name
from customers
where cid not in	(
			select cid
			from orders
			)
;

--Question 4--
/*Show the names of customers who have never placed an order. Use an outer join*/
select c.name
from orders o right outer join customers c on o.cid = c.cid
where o.ordnum is null;

--Question 5--
/*Show the names of customers who placed at least one order through an agent in their
own city, along with those agent(s') names*/
select distinct c.name,
                a.name
from orders o left outer join agents a on o.aid = a.aid
              left outer join customers c on o.cid = c.cid
where c.city = a.city;

--Question 6--
/*Show the names of customers and agents living in the same city, along with the naame
of the shared city, regardless of whether or not the customer has ever placed an order
with that agent*/
select c.name,
       a.name,
       a.city
from customers c inner join agents a on c.city = a.city;

--Question 7--
/*Show the name and city of customers who live in the city that makes the fewest
different kinds of products. (Hint: Use count and group by on the Products table)*/
select name, c.city
from customers c inner join (select city,
                                    count(city)
                             from products 
                             group by city) p on c.city = p.city
where p.count = (select min(p.count) as minimum
                 from (select city,
                              count(city)
                       from products 
                       group by city) p);