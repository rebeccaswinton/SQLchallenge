use movielens;
-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
select title, release_date from movies where release_date between '1983-01-01' and '1993-12-31'order by release_date desc;
-- Without using LIMIT , list the titles of the movies with the lowest average rating
select m.title, r.rating from movies m
join ratings r on r.movie_id=m.id
where r.rating =(select min(rating) from ratings);
-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
select distinct m.title, r.rating, u.gender, g.`name` from movies m
join ratings r on m.id=r.movie_id
join users u on r.user_id=u.id
join genres_movies gm on gm.movie_id=m.id
join occupations o on u.occupation_id=o.id
join genres g on g.id=gm.genre_id
where g.`name` = 'Sci-Fi' 
and u.gender ='M'
and u.age = '24'
and o.`name` = 'Student'
and r.rating = '5'
;
-- List the unique titles of each of the movies released on the most popular release day.
select title from movies where release_date =(
select release_date 
from movies 
group by release_date 
order by count(release_date) 
desc limit 1);

-- Find the total number of movies in each genre; list the results in ascending numeric order.
select g.`name`, count(genre_id) as total_number from genres g
join genres_movies gm on g.id=gm.genre_id
group by genre_id order by total_number asc;

