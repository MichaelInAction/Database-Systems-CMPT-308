/*Create the tables for the movies, directors and actors database*/

/*Create the main person table which hold the basic info shared between actors and directors*/
CREATE TABLE Person (
  PersonID serial not null,
  Name text not null,
  Address text,
  SpouseName text,
 primary key(PersonID)
);

/*Create the two subtypes of the Person table, Actors and Directors*/
CREATE TABLE Actors (
  ActorID int not null references Person(PersonID),
  BirthDate date not null,
  HairColor text,
  EyeColor text,
  HeightInInches decimal,
  Weight decimal,
  FavoriteColor text,
  ScreenActorsGuildAnnDate date,
 primary key(ActorID)
);

CREATE TABLE Directors (
  DirectorID int not null references Person(PersonID),
  FilmSchoolAttended text,
  DirectorsGuildAnnDate date,
  FavoriteLensMaker text,
 primary key(DirectorID)
);

/*Create the movies table*/
CREATE TABLE Movies (
  MPAANumber int not null,
  Name text not null,
  YearReleased int not null,
  DomesticBOSales money,
  ForeignBOSales money,
  DVDBluRaySales money,
 primary key(MPAANumber)
);

/*Create the table which links movies and directors*/
CREATE TABLE Projects (
  DirectorID int not null references Directors(DirectorID),
  MPAANumber int not null references Movies(MPAANumber),
 primary key(DirectorID, MPAANumber)
);

/*Create the table which links movies and actors*/
CREATE TABLE Roles (
  ActorID int not null references Actors(ActorID),
  MPAANumber int not null references Movies(MPAANumber),
  RoleName text not null,
 primary key(ActorID, MPAANumber, RoleName)
);


/*Finds the names of all the directors with whom actor "Sean Connery" has worked*/
select pe.Name
from Person p inner join Actors a on p.PersonID = a.ActorID
              Inner Join Roles r on a.ActorID = r.ActorID
              inner join Movies m on r.MPAANumber = m.MPAANumber
              inner join Projects pr on m.MPAANumber = pr.MPAANumber
              inner join Directors d on pr.DirectorID = d.DirectorID
              inner join Person pe on d.DirectorID = pe.PersonID
where p.name = 'Sean Connery';