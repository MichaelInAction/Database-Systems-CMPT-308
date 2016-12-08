/*Remove all existing tables and views involved in the database*/
drop view if exists EvolutionPokemon;

drop table if exists Evolution;
drop table if exists Mega;
drop table if exists Legendary;
drop table if exists TypeMatchup;
drop table if exists HasTyping;
drop table if exists CanLearn;
drop table if exists Damaging;
drop table if exists ConditionAfflicting;
drop table if exists Moves;
drop table if exists Types;
drop table if exists HasAbility;
drop table if exists Abilities;
drop table if exists PokedexEntry;
drop table if exists Regions;
drop table if exists Pokemon;

/*Create the tables*/

/*Create the pokemon table*/
create table Pokemon(
   PokeID serial not null,
   NationalDexNumber int not null,
   name text not null,
   HeightInFt decimal,
   WeightInLbs decimal,
   PercentageMale decimal,
   Classification text,
   primary key (PokeID)
);

/*Create the Legendary subtype table*/
create table Legendary (
   PokeID int not null references Pokemon(PokeID),
   ShinyLocked boolean not null,
   EventOnly boolean not null,
   primary key (PokeID)
);

/*Create the Mega suptype table*/
create table Mega (
   PokeID int not null references Pokemon(PokeID),
   PreEvoID int not null references Pokemon(PokeID),
   MegaCondition text not null,
   primary key (PokeID)
);

/*Create the Evolution table*/
create table Evolution (
   PokeID int not null references Pokemon(PokeID),
   PreEvoID int not null references Pokemon(PokeID),
   Condition text not null,
   primary key (PokeID)
);

/*Create the Regions table*/
create table Regions (
   RegionID serial not null,
   Name text not null,
   primary key (RegionID)
);

/*Create the linking table between Pokemon and Regions*/
create table PokedexEntry (
   PokeID int not null references Pokemon(PokeID),
   RegionID int not null references Regions(RegionID),
   LocalDexNumber int not null,
   primary key (PokeID, RegionID)
);

/*Create the Abilities table*/
create table Abilities (
   AbilityID serial not null,
   Name text not null,
   Description text not null,
   primary key (AbilityID)
);

/*Create the linking table between Pokemon and Abilities*/
create table HasAbility (
   PokeID int not null references Pokemon(PokeID),
   AbilityID int not null references Abilities(AbilityID),
   Hidden boolean not null,
   primary key (PokeID, AbilityID)
);

/*Create the Types Table*/
create table Types (
   TypeID serial not null,
   Name text not null,
   primary key (TypeID)
);

/*Create the linking table between Pokemon and Types*/
create table HasTyping (
   PokeID int not null references Pokemon(PokeID),
   TypeID int not null references Types(TypeID),
   primary key (PokeID, TypeID)
);

/*Create the TypeMatchup Table*/
create table TypeMatchup (
   AttackingTypeID int not null references Types(TypeID),
   DefendingTypeID int not null references Types(TypeID),
   DamageMultiplier decimal,
   Description text check (Description in ('Its super effective!', 'Its normally effective', 'Its not very effective', 'No effect')),
   primary key (AttackingTypeID, DefendingTypeID)
);

/*Create the Moves table*/
create table Moves (
   MoveID serial not null,
   name text not null,
   TypeID int not null references Types(TypeID),
   BaseAccuracy decimal,
   ContestType text check (ContestType in ('Beauty', 'Cool', 'Cute', 'Clever', 'Tough')),
   PowerPoints int,
   primary key (MoveID)
);

/*Create the linking table between Pokemon and Moves*/
create table CanLearn (
   PokeID int not null references Pokemon(PokeID),
   MoveID int not null references Moves(MoveID),
   Condition text not null,
   primary key (PokeID, MoveID)
);

/*Create the Damaging subtype of Moves*/
create table Damaging (
   MoveID int not null references Moves(MoveID),
   BaseDamage int,
   Category text not null check (Category in ('Physical', 'Special')),
   primary key (MoveID)
);

/*Create the ConditionAfflicting subtype of Moves*/
create table ConditionAfflicting (
   MoveID int not null references Moves(MoveID),
   ConditionApplied text not null,
   primary key (MoveID)
);

/*Insert the sample data into the database*/

insert into Pokemon (NationalDexNumber, Name,              HeightInFt, WeightInLbs, PercentageMale, Classification)
             values (1,                'Bulbasaur',        2.33,       15.2,        .875,           'The Seed Pokemon'),
                    (2,                'Ivysaur',          3.25,       28.7,        .875,           'The Seed Pokemon'),
                    (3,                'Venusaur',         6.58,       220.5,       .875,           'The Seed Pokemon'),
                    (4,                'Charmander',       2.00,       18.7,        .875,           'The Lizard Pokemon'),
                    (5,                'Charmeleon',       3.58,       41.9,        .875,           'The Flame Pokemon'),
                    (6,                'Charizard',        5.58,       199.5,       .875,           'The Flame Pokemon'),
                    (7,                'Squirtle',         1.66,       19.8,        .875,           'The Tiny Turtle Pokemon'),
                    (8,                'Wartortle',        3.25,       49.6,        .875,           'The Turtle Pokemon'),
                    (9,                'Blastoise',        5.25,       188.5,       .875,           'The Shellfish Pokemon'),
                    (3,                'Mega Venusaur',    7.83,       342.8,       .875,           'The Seed Pokemon'),
                    (6,                'Mega Charizard X', 5.58,       243.6,       .875,           'The Flame Pokemon'),
                    (6,                'Mega Charizard Y', 5.58,       221.6,       .875,           'The Flame Pokemon'),
                    (9,                'Mega Blastoise',   5.25,       222.9,       .875,           'The Shellfish Pokemon'),
                    (648,              'Meloetta',         2.00,       14.3,        null,           'The Melody Pokemon'),
                    (251,              'Celebi',           2.00,       11.0,        null,           'The Time Travel Pokemon'),
                    (801,              'Magearna',         3.25,       177.5,       null,           'The Artificial Pokemon'),
                    (374,              'Beldum',           2.00,       209.9,       null,           'The Iron Ball Pokemon'),
                    (375,              'Metang',           3.92,       446.4,       null,           'The Iron Claw Pokemon'),
                    (376,              'Metagross',        5.25,       1212.5,      null,           'The Iron Leg Pokemon'),
                    (376,              'Mega Metagross',   8.17,       2078.7,      null,           'The Iron Leg Pokemon'),
                    (255,              'Torchic',          1.33,       5.5,         .875,           'The Chick Pokemon'),
                    (256,              'Combusken',        2.92,       43.0,        .875,           'The Young Fowl Pokemon'),
                    (257,              'Blaziken',         6.25,       114.6,       .875,           'The Blaze Pokemon'),
                    (257,              'Mega Blaziken',    6.25,       114.6,       .875,           'The Blaze Pokemon');                    

insert into Abilities (Name, Description)
               values ('Blaze', 'When HP is below 1/3rd its maximum, power of Fire-type moves is increased by 50%'),
                      ('Torrent', 'When HP is below 1/3rd its maximum, power of Water-type moves is increased by 50%'),
                      ('Overgrow', 'When HP is below 1/3rd its maximum, power of Grass-type moves is increased by 50%'),
                      ('Chlorophyll', 'When sunny, the Pokémon’s Speed doubles. However, Speed will not double on the turn weather becomes Strong Sunlight'),
                      ('Clear Body', 'Opponents moves which lower this Pokémon’s stats have no effect. However this Pokémon may lower its own stats with its own moves'),
                      ('Light Metal', 'Halves the Pokémons weight'),
                      ('Speed Boost', 'Speed increases by one stage at the end of each turn.'),
                      ('Tough Claws', 'Increases the power of moves that make physical contact by 33%');

insert into HasAbility (PokeID, AbilityID, Hidden)
                values (1,      3,         false),
                       (2,      3,         false),
                       (3,      3,         false),
                       (4,      1,         false),
                       (5,      1,         false),
                       (6,      1,         false),
                       (7,      2,         false),
                       (8,      2,         false),
                       (9,      2,         false),
                       (11,     8,         false),
                       (1,      4,         true),
                       (2,      4,         true),
                       (3,      4,         true),
                       (17,     5,         false),
                       (17,     6,         true),
                       (18,     5,         false),
                       (18,     6,         true),
                       (19,     5,         false),
                       (19,     6,         true),
                       (20,     8,         false),
                       (21,     1,         false),
                       (21,     7,         true),
                       (22,     1,         false),
                       (22,     7,         true),
                       (23,     1,         false),
                       (23,     7,         true),
                       (24,     7,         false);


insert into Types (name)
           values ('Psychic'),
                  ('Steel'),
                  ('Fire'),
                  ('Fighting'),
                  ('Grass'),
                  ('Poison'),
                  ('Flying'),
                  ('Water'),
                  ('Fairy'),
                  ('Dragon'),
                  ('Normal');

insert into TypeMatchup (AttackingTypeID, DefendingTypeID, DamageMultiplier, Description)
                 values (1,               1,               .5,               'Its not very effective'),
                        (1,               4,               2,                'Its super effective!'),
                        (3,               5,               2,                'Its super effective!'),
                        (5,               8,               2,                'Its super effective!'),
                        (8,               3,               2,                'Its super effective!'),
                        (3,               8,               .5,               'Its not very effective'),
                        (8,               5,               .5,               'Its not very effective'),
                        (5,               3,               .5,               'Its not very effective'),
                        (10,              10,              2,                'Its super effective!'),
                        (9,               10,              2,                'Its super effective!'),
                        (10,              9,               0,                'No effect'),
                        (7,               5,               2,                'Its super effective!'),
                        (1,               3,               1,                'Its normally effective'),
                        (4,               3,               1,                'Its normally effective'),
                        (1,               2,               .5,               'Its not very effective'),
                        (2,               1,               1,                'Its normally effective');

insert into hasTyping (PokeID, TypeID)
               values (1,      5),
                      (1,      6),
                      (2,      5),
                      (2,      6),
                      (3,      5),
                      (3,      6),
                      (4,      3),
                      (5,      3),
                      (6,      3),
                      (6,      7),
                      (7,      8),
                      (8,      8),
                      (9,      8),
                      (10,     5),
                      (10,     6),
                      (11,     3),
                      (11,     10),
                      (12,     3),
                      (12,     7),
                      (13,     8),
                      (14,     1),
                      (14,     11),
                      (21,     3),
                      (22,     3),
                      (22,     4),
                      (23,     3),
                      (23,     4),
                      (24,     3),
                      (24,     4);
                       
insert into Moves (Name,            TypeID, BaseAccuracy, ContestType, PowerPoints)
           values ('Tackle',        11,     1,            'Tough',     35),
                  ('Water Gun',     8,      1,            'Cute',      25),
                  ('Scratch',       11,     1,            'Tough',     35),
                  ('Growl',         11,     1,            'Cute',      40),
                  ('Ember',         3,      1,            'Cute',      25),
                  ('Take Down',     11,     .85,          'Tough',     20),
                  ('Poison Powder', 6,      .75,          'Clever',    35),
                  ('Vine Whip',     5,      1,            'Cool',      25);

insert into Damaging (MoveID, BaseDamage, Category)
              values (1,      50,         'Physical'),
                     (2,      40,         'Special'),
                     (3,      40,         'Physical'),
                     (5,      40,         'Special'),
                     (6,      90,         'Physical'),
                     (8,      45,         'Physical');

insert into ConditionAfflicting (MoveID, ConditionApplied)
                         values (4,      'Lowers opponents attack by one stage'),
                                (5,      'May induce burn'),
                                (6,      'User takes recoil damage equal to 25% of the damage inflicted'),
                                (7,      'Induces poison');                    
                  
insert into CanLearn (PokeID, MoveID, Condition)
              values (1,      1,      'Level 1'),
                     (2,      1,      'Level 1'),
                     (3,      1,      'Level 1'),
                     (4,      3,      'Level 1'),
                     (5,      3,      'Level 1'),
                     (6,      3,      'Level 1'),
                     (7,      1,      'Level 1'),
                     (8,      1,      'Level 1'),
                     (9,      1,      'Level 1'),
                     (7,      2,      'Level 7'),
                     (8,      2,      'Level 7'),
                     (9,      2,      'Level 7'),
                     (21,     3,      'Level 1'),
                     (21,     4,      'Level 1'),
                     (22,     3,      'Level 1'),
                     (22,     4,      'Level 1'),
                     (23,     3,      'Level 1'),
                     (23,     4,      'Level 1'),
                     (1,      7,      'Level 13'),
                     (2,      7,      'Level 13'),
                     (3,      7,      'Level 13'),
                     (17,     6,      'Level 1'),
                     (18,     6,      'Level 1'),
                     (19,     6,      'Level 1');
                      
insert into Regions (name)
             values ('Kanto'),
                    ('Johto'),
                    ('Hoenn'),
                    ('Alola');

insert into PokedexEntry (PokeID, RegionID, LocalDexNumber)
                  values (17,     4,        214),
                         (18,     4,        215),
                         (19,     4,        216),
                         (20,     4,        216),
                         (17,     3,        190),
                         (18,     3,        191),
                         (19,     3,        192),
                         (20,     3,        192),
                         (21,     3,        4),
                         (22,     3,        5),
                         (23,     3,        6),
                         (24,     3,        6),
                         (1,      1,        1),
                         (2,      1,        2),
                         (3,      1,        3),
                         (4,      1,        4),
                         (5,      1,        5),
                         (6,      1,        6),
                         (7,      1,        7),
                         (8,      1,        8),
                         (9,      1,        9),
                         (10,     1,        3),
                         (11,     1,        6),
                         (12,     1,        6),
                         (13,     1,        9),
                         (15,     2,        251),
                         (15,     3,        386),
                         (16,     4,        301);

insert into Evolution (PokeID, PreEvoID, Condition)
               values (2,      1,        'Level 16'),
                      (3,      2,        'Level 32'),
                      (5,      4,        'Level 16'),
                      (6,      5,        'Level 36'),
                      (8,      7,        'Level 16'),
                      (9,      8,        'Level 36'),
                      (18,     17,       'Level 20'),
                      (19,     18,       'Level 45'),
                      (22,     21,       'Level 16'),
                      (23,     22,       'Level 36');

insert into Mega (PokeID, PreEvoID, MegaCondition)
          values (10,     3,        'Holding a Venusaurite'),
                 (11,     6,        'Holding a Charizardite X'),
                 (12,     6,        'Holding a Charizardite Y'),
                 (13,     9,        'Holding a Blastoisinite'),
                 (20,     19,       'Holding a Metagrossite'),
                 (24,     23,       'Holding a Blazikenite');

insert into Legendary (PokeID, ShinyLocked, EventOnly)
               values (14, true, true),
                      (15, true, true),
                      (16, true, true);

/*Create the views*/

create or replace view EvolutionPokemon as
select p.PokeID, p.NationalDexNumber, p.Name, p.HeightInFt, p.WeightInLbs, p.PercentageMale, p.Classification, e.Condition as EvolvedCondition, o.name as EvolvedFrom, v.Condition EvolvesCondition, k.name as EvolvesInto
from Pokemon p full outer join Evolution e on p.PokeID = e.PokeID
               left outer join Pokemon o on e.preEvoID = o.PokeID
               full outer join Evolution v on p.PokeID = v.PreEvoID
               left outer join Pokemon k on v.PokeID = k.PokeID
where (o.name is not null or k.name is not null)
order by NationalDexNumber asc;

/*Some interesting queries*/

select r.name, count(r.name)
from Pokemon p inner join PokedexEntry pe on p.PokeID = pe.PokeID
               inner join regions r       on r.RegionID = pe.RegionID
group by (r.name);

select name
from Pokemon p inner join hasTyping ht on p.PokeID = ht.PokeID
group by (name)
having count(name) = 2;

select name
from types t inner join hasTyping ht on t.TypeID = ht.TypeID
group by (name)
order by count(name) desc
limit 1;

/*Creating the stored procedures and triggers*/

create or replace function check_typings() returns trigger 
as
$$
declare
   rc int;
begin
   select count(*) into rc
     from hasTyping
    where PokeID = NEW.PokeID;
   if (rc < 2)
       then
      --All good. Do nothing. Move along. These are not the droids you're looking for
   else
      raise exception 'A pokemon cannot have more than two types';
   end if;
   return new;
end;
$$
language PLPGSQL;

create trigger manage_pokemon_typings
   before insert or update
   on hasTyping
   for each row
   execute procedure check_typings();


create or replace function create_type_matchups() returns trigger 
as
$$
declare
   defendingType record;
begin
   FOR defendingType IN select TypeID from Types LOOP

      insert into TypeMatchup (AttackingTypeID, DefendingTypeID)
                       values (new.TypeID, defendingType.TypeID);

   end loop;
   return null;
end;
$$
language PLPGSQL;



create trigger manage_type_matchups
   after insert
   on Types
   for each row
   execute procedure create_type_matchups();

/*Create the security roles*/

create role professor;
grant all on all tables in schema public to professor;

create role trainer;
revoke all on all tables in schema public from trainer;
grant select on all tables in schema public to trainer;
grant insert on Pokemon, Types, Moves to trainer;

create role youngster;
revoke all on all tables in schema public from youngster;
grant select on all tables in schema public to youngster;