-- Show film with length < average length of all film
SELECT name
FROM film
WHERE length_min < (SELECT AVG(length_min) FROM film);

-- Show room and all seats
SELECT room.id, room.name, seat.id AS seat_id, seat.row, seat.number
FROM room LEFT JOIN seat
	ON room.id = seat.room_id;
    
-- Show film without any booking
SELECT * 
-- DISTINCT film.name
FROM screening
	RIGHT JOIN booking ON screening.id = booking.screening_id
    RIGHT JOIN film ON screening.film_id = film.id
WHERE booking.id IS NULL
;

-- SHOW all customers who never book
SELECT *
FROM customer
	LEFT JOIN booking ON customer.id = booking.customer_id
WHERE booking.customer_id IS NULL
;