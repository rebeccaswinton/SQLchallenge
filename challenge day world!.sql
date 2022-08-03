use world;
-- Using COUNT, get the number of cities in the USA
select COUNT(countrycode) as `Number of cities in the USA` from city where countrycode = 'USA';
-- Find out the population and life expectancy for people in Argentina
select population, LifeExpectancy from country where `Name` = 'Argentina';
-- Using IS NOT NULL, ORDER BY AND LIMIT, which country has the highest life expectancy?
select `Name` from country where LifeExpectancy is not null order by  LifeExpectancy desc limit 1;
-- Using JOIN.. ON, find the capital city of Spain
select ci.`name` from city ci
join country c on ci.ID=c.capital
where c.`name` = 'Spain';
-- Using JOIN.. ON, list all the languages spoken in the Southeast Asia region
select distinct `Language` from countrylanguage cl
join country c on cl.countrycode=c.`code`
where c.region = 'Southeast Asia';
-- Using a single query, list 25 cities around the world that start with the letter F 
select * from city where `Name` like 'F%' limit 25;
-- Using count and join... on, get the number of cities in china
select count(ci.ID) from city ci
join country c on ci.countrycode=c.`code`
where c.`name`= 'China';
-- Using is not null, order by and limit, which country has the lowest population? Discard non-zero populations
select `name`, population from country where population is not null and population != '0' order by population;
-- Using aggregate functions, return the number of countries the database contains
select distinct count(`code`and `name`) from country;
-- What are the top ten largest countries by area?
select * from country  order by surfacearea desc limit 10;
-- List the five largest cities by populaiton in Japan
select ci.`name` from city ci 
join country c on c.`code`=ci.countrycode
where c.`name` = 'Japan'
order by c.population desc limit 5;
select * from city where countrycode =(select `code` from country where `Name` ='Japan') limit 5;
-- List the name and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake
select* from country;
update country 
set HeadOfState = 'Elizabeth II' where HeadOfState = 'Elisabeth II';
select `name`, code from country where HeadOfState = 'Elizabeth II';
-- List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0
select `name`, (Population/ SurfaceArea) as ratio from country where population > 0  order by ratio asc limit 10;
-- List every unique world language.
select distinct language from countrylanguage;
-- List the names and GNP of the world's top 10 richest countries.
select `name`, GNP from country order by GNP desc limit 10;
-- List the names of, and number of languages spoken by, the top ten most multilingual countries
select c.`name`, count(cl.countrycode) from countrylanguage cl
join country c on c.code=cl.countrycode
group by cl.countrycode
order by count(cl.countrycode)
desc limit 10;
-- List every country where over 50% of its population can speak German.
select c.`name`, cl.language, cl.percentage from countrylanguage cl
join country c on cl.countrycode=c.code
where cl.percentage > 50 and cl.language = 'German';
-- Which country has the worst life expectancy? Discard zero or null values
select * from country where LifeExpectancy is not null order by LifeExpectancy asc limit 1;
-- List the top three most common government forms.
select GovernmentForm from country  group by GovernmentForm order by count(GovernmentForm) desc limit 3;
-- How many countries have gained independence since records began?
select count(IndepYear) from country where IndepYear is not null;

