--Michael Read--
--Lab 4--

--Question 1--
select city
from Agents
where aid in	(
		select aid
		from Orders
		where cid = 'c006'
		)
;

--Question 2--
select distinct pid
from Orders
where aid in	(
		select aid
		from Orders
		where cid in	(
				select cid
				from Customers
				where city = 'Kyoto'
				)
		)
order by pid desc;

--Question 3--
select cid, name
from Customers
where cid not in	(
			select cid
			from Orders
			where aid = 'a03'
			)
;

--Question 4--
select cid
from Orders
where pid = 'p01'
	intersect
select cid
from Orders
where pid = 'p07';

--Question 5--
select pid
from Products
where pid not in	(
			select pid
			from Orders
			where cid in	(
					select cid
					from Orders
					where aid = 'a08'
					)
			)
order by pid desc;

--Question 6--
select name, discount, city
from Customers
where cid in	(
		select cid
		from Orders
		where aid in	(
				select aid
				from Agents
				where city in ('Dallas', 'New York')
				)
		)
;

--Question 7--
select *
from Customers
where discount in	(
			select discount
			from Customers
			where city in ('London', 'Dallas')
			)
;

--Question 8--
--Check constraints are used to check the data being entered into the column,
--and allowing only certain pieces of data to be entered into that column. This
--means that check constraints are good for defining enumerated domains, or domains
--which have a countable number of possible values. The advantage to using check
--constraints in a database is that you can increase the quality of your data, by
--making sure that only information relevant to the column can be entered if a datatype
--for whet you are looking for does not already exist. Check constraints should only be
--used for domains where the values are easily listed out, and that do not change. One
--good example of a use of check constraints would be for a column which holds what
--day of the week something happened. Since the days of the week are easily listed out, 
--and they do not change, this is a good use of check constraints. Similarly, using
--check constraints for a column which holds what month something happened would also
--be a good use of check constraints, as the months do not change and are easily listed.
--A bad use of check constraints would be for professors that teach a certain course, because
--even if there were a small enough number of professors working at the school to be listed,
--there is always the possibility of professors being hired or fired, so the values that could
--be stored in that column is always changing. Another bad example of using check constraints
--would be for the set a certain card was released in for yu-gi-oh or magic, as the list
--continues to grow as more and more sets are released, meaning that the values change,
--and as time goes on it gets more and more difficult to list the different values.