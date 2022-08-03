show databases;
use sakila;
show tables;
-- List all actors
select * from actor;
-- Find the surname of the actor with the forename 'John'.
select * from actor where first_name like '%John';
-- Find all actors with surname 'Neeson'.
select * from actor where last_name like '%Neeson';
-- Find all actors with ID numbers divisible by 10.
select * from actor where (actor_id%10=0);
-- What is the description of the movie with an ID OF 100?
select description from film where film_id=100;
-- Find every R-rated movie
select * from film where rating='R';
-- Find every non-R-rated movie.
select * from film where rating !='R';
-- Find the ten shortest movies
select * from film order by length asc limit 10;
-- Find the movies with the longest runtime, without using LIMIT
select * from film where length = (select max(length) from film);
-- Find all movies that have deleted scenes. 
select * from film where special_features like '%Deleted Scenes%';
-- Using HAVING, reverse-alphabetically list the last names that are not repeated
select last_name from actor 
 group by last_name having count(last_name) = '1'
order by last_name desc;
-- Using HAVING, list the last names that appear more than once, from highest to lowest frequency
select last_name from actor
group by last_name having count(last_name) > '1'
order by count(last_name) asc;
-- Which actor has appeared in the most films?
select * from actor 
where actor_id = (
select actor_id
from film_actor
group by actor_id
order by count(actor_id) desc
limit 1 
);
-- 'Academy Dinosaur' has been rented out, when is it due to be returned?
select r.return_date from rental r 
inner join inventory i on r.inventory_id=i.inventory_id
inner join film f on f.film_id=i.film_id
where f.title='Academmy Dinosaur'order by r.return_date desc limit 1;

-- What is the average runtime of all films?
select avg(length) from film;
-- List the average  runtime for every film category
select c.`name`, avg(length) as average_length from category c
inner join film_category fc on c.category_id=fc.category_id
inner join film f on f.film_id=fc.film_id
group by c.category_id;
-- List all movies featuring a robot.
select * from film where description like '%robot%';
-- How many movies were released in 2010?
select count(film_id) from film where release_year = '2010';
-- Find titles of all horror movies
select f.title from film f
inner join film_category fc on f.film_id=fc.film_id
inner join category c  on c.category_id=fc.category_id
where c.`name` = 'horror';
-- List the full name of the staff member with the ID of 2
select first_name, last_name from staff where staff_id =2;
select concat(first_name,   last_name) as full_name from staff where staff_id =2;
-- List all the movies that Fred Costner has appeared in 
select f.title from film f 
inner join film_actor fa on fa.film_id=f.film_id
inner join actor a on a.actor_id=fa.actor_id
where first_name = 'Fred' and last_name = 'Costner';
-- How many distinct countries are there?
select distinct count(country) from country;
-- List the name  of every language in reverse-alphabetical order
select `name` from `language` order by `name` desc;
-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename
select first_name, last_name as full_name from actor where last_name like '%son' order by first_name;
-- Which category contains the most films?
select * from film_category order by category_id;
select * from category 
where category_id = (
select category_id
from film_category
group by category_id
order by count(category_id) desc
limit 1
);

