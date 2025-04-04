-- 1. List all users subscribed to the Premium plan:
SELECT users.name,email
FROM users
WHERE plan='premium';

-- 2. Retrieve all movies in the Drama genre with a rating higher than 8.5:
SELECT movies.title,rating
FROM movies
WHERE genre= 'drama' AND rating >8.5;

-- 3. Find the average rating of all movies released after 2015:
SELECT avg(movies.rating) AS avg_rating
FROM movies
WHERE release_year >2015;

-- 4. List the names of users who have watched the movie Stranger Things along with their completion percentage:
SELECT u.name, wh.completion_percentage
FROM movies m
INNER JOIN watchhistory wh ON m.movie_id= wh.movie_id AND title='Stranger Things'
INNER JOIN users u ON wh.user_id= u.user_id;

SELECT U.name, W.completion_percentage 
FROM Users U 
JOIN WatchHistory W ON U.user_id = W.user_id
JOIN Movies M ON W.movie_id = M.movie_id 
WHERE M.title = 'Stranger Things';

-- 5. Find the name of the user(s) who rated a movie the highest among all reviews:
-- SELECT m.rating, u.name
-- FROM movies m
-- INNER JOIN watchhistory wh ON m.movie_id=wh.movie_id
-- INNER JOIN users u ON wh.user_id=u.user_id
-- ORDER BY m.rating DESC LIMIT 1;


SELECT U.name 
FROM Users U 
JOIN Reviews R ON U.user_id = R.user_id 
WHERE R.rating = (SELECT MAX(rating) FROM Reviews);
-- If multiple users have the same highest rating (e.g., two users both have a rating of 5), this query will return both users.

SELECT U.name 
FROM Users U 
JOIN Reviews R ON U.user_id = R.user_id
ORDER BY r.rating DESC LIMIT 1;
-- If two users both have the highest rating of 5, but User A appears first in the ordered list (due to their user_id or some other factor), this query will return only User A.

-- 6. Calculate the number of movies watched by each user and sort by the highest count:
SELECT users.name,count(users.user_id) AS movies_watched
FROM watchhistory
INNER JOIN users ON users.user_id=watchhistory.user_id
GROUP BY users.name
ORDER BY movies_watched DESC;

SELECT U.name, COUNT(W.watch_id) AS movies_watched 
FROM Users U 
JOIN WatchHistory W ON U.user_id = W.user_id 
GROUP BY U.user_id 
ORDER BY movies_watched DESC;

-- 7.List all movies watched by John Doe, including their genre, rating, and his completion percentage:

SELECT u.name, wh.completion_percentage,m.rating, m.genre,m.title
FROM users u
JOIN watchhistory wh ON u.user_id=wh.user_id
JOIN movies m ON wh.movie_id= m.movie_id WHERE name='John Doe';

SELECT m.rating, m.genre,  m.title, wh.completion_percentage, u.name
FROM movies m
JOIN watchhistory wh ON m.movie_id=wh.movie_id
JOIN users u ON wh.user_id=u.user_id WHERE name='John Doe';

-- 8.Update the movie's rating for Stranger Things:
UPDATE movies
SET rating = 8.9
WHERE title= 'Stranger Things';

-- 9.Remove all reviews for movies with a rating below 4.0:
DELETE FROM reviews
WHERE reviews.rating<4;

DELETE FROM Reviews 
WHERE movie_id IN (SELECT movie_id FROM Movies WHERE rating < 4.0);
-- The subquery (SELECT movie_id FROM Movies WHERE rating < 4.0) retrieves the movie_id of movies with a rating less than 4.0.

-- 10. Fetch all users who have reviewed a movie but have not watched it completely (completion percentage < 100):
SELECT u.name, wh.completion_percentage
FROM reviews r
LEFT JOIN watchhistory wh ON r.movie_id= wh.movie_id
JOIN users u ON wh.user_id=u.user_id WHERE (wh.completion_percentage<100 or wh.completion_percentage IS NULL);

SELECT U.name, M.title, R.review_text 
FROM Users U
JOIN Reviews R ON U.user_id = R.user_id
JOIN Movies M ON R.movie_id = M.movie_id
LEFT JOIN WatchHistory W ON U.user_id = W.user_id AND M.movie_id = W.movie_id
WHERE (W.completion_percentage IS NULL OR W.completion_percentage < 100);

-- 11. List all movies watched by John Doe along with their genre and his completion percentage:
SELECT m.rating, m.genre,  m.title, wh.completion_percentage, u.name
FROM movies m
JOIN watchhistory wh ON m.movie_id=wh.movie_id
JOIN users u ON wh.user_id=u.user_id WHERE name='John Doe';

-- 12.Retrieve all users who have reviewed the movie Stranger Things, including their review text and rating:
SELECT r.rating,r.review_text, u.user_id, u.name
FROM users u 
JOIN reviews r ON u.user_id=r.user_id
JOIN movies m ON r.movie_id=m.movie_id WHERE m.title='Stranger Things';

-- 13. Fetch the watch history of all users, including their name, email, movie title, genre, watched date, and completion percentage:
SELECT u.name,u.email,m.title,m.genre,wh.watched_date,wh.completion_percentage
FROM users u
JOIN watchhistory wh ON u.user_id=wh.user_id
JOIN movies m ON m.movie_id=wh.movie_id;

-- 14.List all movies along with the total number of reviews and average rating for each movie, including only movies with at least two reviews:
SELECT m.title , count(r.user_id) AS total_reviews, avg(r.rating) AS avg_rating
FROM movies m
LEFT JOIN reviews r ON m.movie_id=r.movie_id
GROUP BY m.movie_id
HAVING total_reviews>=1; 
 
SELECT m.title , count(r.review_id) AS total_reviews, avg(r.rating) AS avg_rating
FROM movies m
LEFT JOIN reviews r ON m.movie_id=r.movie_id
GROUP BY m.movie_id
HAVING total_reviews=0;

SELECT M.title, COUNT(R.review_id) AS total_reviews, AVG(R.rating) AS average_rating 
FROM Movies M
JOIN Reviews R ON M.movie_id = R.movie_id
GROUP BY M.movie_id
HAVING COUNT(R.review_id) = 0;

SELECT count(r.review_id) AS total_reviews, avg(r.rating) AS avg_rating
FROM movies m
LEFT JOIN reviews r ON m.movie_id=r.movie_id;

-- Yes, you need to use GROUP BY when you select non-aggregated columns along with aggregation functions in the same SELECT statement.



