-- 1/ GET THE TOP 3 FILMS THAT HAVE THE MOST CUSTOMER BOOK
SELECT f.*, COUNT(*) AS film_booking
FROM booking as b
	JOIN customer as c ON b.customer_id = c.id
    	JOIN screening as s ON b.screening_id = s.id
    	JOIN film as f ON s.film_id = f.id
GROUP BY f.id
ORDER BY film_booking DESC
LIMIT 3; -- SAME RANK THEN HOW?

-- 2/ GET ALL FILMS THAT LONGER THAN AVG LENGTH
SELECT *
FROM film
HAVING length_min > (
	SELECT AVG(length_min)
	FROM film)
ORDER BY length_min DESC;

-- 3/ GET THE ROOM WHICH HAVE THE HIGHEST & LOWEST SCREENINGS IN 1 SQL QUERY
SELECT room_id, COUNT(id) AS count_room
FROM screening AS s
GROUP BY room_id
HAVING count_room = (
	SELECT COUNT(id) AS count
	FROM screening AS s
	GROUP BY room_id
	ORDER BY count ASC
	LIMIT 1)
    OR count_room = (
	SELECT COUNT(id) AS count
	FROM screening AS s
	GROUP BY room_id
	ORDER BY count DESC
	LIMIT 1)
ORDER BY count_room
;

-- 4/ Get number of booking customers of each room of film ‘Tom&Jerry’
SELECT r.*, count(*) AS room_booked_Tom_Jerry
FROM booking AS b
	JOIN screening AS s ON b.screening_id = s.id
    	JOIN room AS r ON s.room_id = r.id
    	JOIN film AS f ON s.film_id = f.id
WHERE f.name = 'Tom&Jerry'
GROUP BY room_id
;

-- 5/ What seat is being book the most ?
SELECT s.*, COUNT(*) AS no_of_books
FROM reserved_seat AS r
	JOIN seat AS s ON r.seat_id = s.id
GROUP BY s.id
HAVING no_of_books = (
	SELECT COUNT(*) AS no_of_books
	FROM reserved_seat AS r
	JOIN seat AS s ON r.seat_id = s.id
	GROUP BY s.id
        ORDER BY no_of_books DESC
        LIMIT 1)
;

-- 6/ What film have the most screens in 2022?
SELECT f.*, COUNT(*) AS no_of_screenings
FROM screening AS s
	JOIN film AS f ON s.film_id = f.id
WHERE YEAR(s.start_time) = 2022
GROUP BY f.id
HAVING no_of_screenings = (
	SELECT COUNT(*) AS no_of_screenings
	FROM screening AS s
	JOIN film AS f ON s.film_id = f.id
	GROUP BY f.id
	ORDER BY no_of_screenings DESC
        LIMIT 1)
;

-- 7/ Which day has most screen?
SELECT CAST(start_time AS DATE), COUNT(*) AS no_of_screenings
FROM screening AS s
GROUP BY CAST(start_time AS DATE)
ORDER BY no_of_screenings DESC;

-- 8/ Show film on 2022- May
SELECT DISTINCT f.id, f.name
FROM screening AS s
	JOIN film AS f ON s.film_id = f.id
WHERE YEAR(s.start_time) = 2022 AND MONTH(s.start_time) = 5
;

-- 9/ Select film end with character "n"
SELECT `name`
FROM film
WHERE `name` LIKE "%n"
;

-- 10/ Show customer name but just show first 3 characters AND last 3 characters in UPPERCASE
SELECT c.id, LEFT(c.first_name,3), UPPER(RIGHT(c.last_name,3))
FROM customer AS c
;

-- 11/ WHAT film long than 2 hours?
SELECT *
FROM film
WHERE length_min >= 120
;
