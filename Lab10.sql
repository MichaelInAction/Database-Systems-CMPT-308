--Michael Read--
--Lab 10--

/*Question 1*/
/*function to find the immediate prerequisites for a certian course*/
create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as
$$
declare
   courseNumber int       := $1;
   resultset REFCURSOR := $2;
begin
   open resultset for
      select c.* 
      from Prerequisites p
      inner join courses c on p.preReqNum = c.num
      where p.courseNum = courseNumber;
   return resultset;
end;
$$
language plpgsql;

/*Question 2*/
/*function to find all the classes for which the certain course is a prerequisite for*/
create or replace function IsPreReqFor(int, REFCURSOR) returns refcursor as
$$
declare
   courseNumber int       := $1;
   resultset REFCURSOR := $2;
begin
   open resultset for
      select c.* 
      from Prerequisites p
      inner join courses c on p.courseNum = c.num
      where p.preReqNum = courseNumber;
   return resultset;
end;
$$
language plpgsql;