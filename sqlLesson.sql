--1 Who won the Oscar for “Actor in a Leading Role” in 2015 ?
-- (Hint winner is indicated as '1.0')
SELECT name
FROM oscars
WHERE winner = '1.0'
    AND year = '2015';
-- 2 What query will produce the ten oldest movies in the database?
SELECT title,
    release_date
FROM movies
ORDER BY release_date ASC
LIMIT 10;
-- 3 How many unique awards are there in the Oscars table?
SELECT COUNT(DISTINCT award) AS Unique_Awards
FROM oscars;
-- 4 How many movies are there that contain the word “Spider” within their title?
SELECT COUNT(*) AS Movies_With_Spider
FROM movies
WHERE title LIKE '%Spider%';
-- 5 How many movies are there that were released between 1 August 2006 ('2006-08-01') and 1 October 2009 ('2009-10-01') that have a popularity score of more than 40 and a budget of less than 50 000 000?
SELECT COUNT(*) AS movies_
FROM movies
WHERE release_date BETWEEN '2006-08-01' AND '2009-10-01'
    AND popularity > 40.0
    AND budget < 50000000;
-- 6 How many unique characters has "Vin Diesel" played so far in the database?
SELECT COUNT(DISTINCT characters) AS unique_characters
FROM casts c
    JOIN actors a ON a.actor_id = c.actor_id
WHERE a.actor_name = 'Vin Diesel';
-- 7 What are the Genres of the movie “The Royal Tenenbaums”?
SELECT g.genre_name
FROM genres g
    JOIN genremap gm ON g.genre_id = gm.genre_id
    JOIN movies m ON m.movie_id = gm.movie_id
WHERE m.title = 'The Royal Tenenbaums';
-- 8 What are the three production companies that have the highest movie popularity score on average, as recorded within the database?
SELECT pc.production_company_name,
    AVG(m.popularity) AS average_popularity
FROM productioncompanies pc
    JOIN productioncompanymap pcm ON pcm.production_company_id = pc.production_company_id
    JOIN movies m ON m.movie_id = pcm.movie_id
GROUP BY pc.production_company_name
ORDER BY average_popularity DESC
LIMIT 3;
-- 9 How many female actors (i.e. gender = 1) have a name that starts with the letter "N"?
SELECT COUNT(*) AS start_with_n
FROM actors
WHERE gender = 1
    AND actor_name LIKE 'N%';
-- 10 Which genre has, on average, the lowest movie popularity score?
SELECT g.genre_name,
    AVG(m.popularity) AS lowest_popularity
FROM genres g
    JOIN genremap gm ON gm.genre_id = g.genre_id
    JOIN movies m ON m.movie_id = gm.movie_id
    GROUP BY g.genre_name
    ORDER BY lowest_popularity ASC
    LIMIT 1;
-- 11 Which award category has the highest number of actor 
nominations (actors can be male or female)?
(Hint Oscars.name contains both actors names and film names)
SELECT award,
    COUNT(*) AS highest_actor_nominations
FROM oscars
GROUP BY award
ORDER BY highest_actor_nominations DESC
LIMIT 1;
-- 12 For all of the entries in the Oscars table before 1934, 
-- the year is stored differently than in all the subsequent years. 
-- E.g the year would be saved as “1932/1933” instead of just “1933” 
-- (the second indicated year). Which of the following options would be 
-- the appropriate code to update this column to have the format of the 
-- year be consistent throughout the entire table (second indicated year 
-- only shown)?
UPDATE oscars
SET year = CAST(SUBSTRING(year FROM '[0-9]{4}$') AS INTEGER)
-- WHERE year LIKE '%/%';
-- 13 DStv will be having a special week dedicated to the actor Alan Rickman.
-- Which of the following queries would create a new view that shows the titles,
-- release dates, taglines, and overviews of all movies that Alan Rickman has played in?
CREATE VIEW alan_rickman_movies AS
SELECT m.title,
    m.release_date,
    m.tagline,
    m.overview
FROM movies m
    JOIN casts c ON m.movie_id = c.movie_id
    JOIN actors a ON c.actor_id = a.actor_id
WHERE a.actor_name = 'Alan Rickman';
