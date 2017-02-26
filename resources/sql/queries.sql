-- :name create-show! :! :n
-- :doc create a new show
INSERT INTO shows
    (slot, show_name, created_on) VALUES
(:slot, :show_name, :timestamp)

-- :name update-shows! :! :n
-- :doc update an existing show
UPDATE shows
SET show_name = :show_name
    slot = :slot
WHERE id = :id

-- :name get-show :? :1
-- :doc retrieve a show given the id.
SELECT * FROM shows
WHERE id = :id

-- :name get-shows :? :*
-- :doc get all shows
SELECT * FROM shows

-- :name delete-show! :! :n
-- :doc delete a show
DELETE FROM shows
WHERE id = :id

-- :name get-seats :? :*
-- :doc get all seats
SELECT * FROM seats

-- :name delete-show-seats! :! :n
-- :doc delete seats of a show
DELETE FROM show_seats WHERE show_id=:id

-- :name booked-seats :? :*
-- :doc get booked seats for a show
SELECT * FROM show_seats INNER JOIN shows ON show_seats.show_id = shows.id INNER JOIN seats ON show_seats.seat_id = seats.id WHERE shows.id = :id

-- :name book-ticket! :i!
-- :doc book a seat in a show
INSERT INTO bookings 
    (show_id, seat_id, created_on) VALUES
    (:show_id, :seat_id, :timestamp)

-- :name booked-seat! :! :n
-- :doc enter into the booked seats into the record. Do not use without a transaction
INSERT INTO show_seats
    (show_id, seat_id) VALUES
    (:show_id, :seat_id)

-- :name get-booking :? :1
-- doc: find the booking details based on the id
SELECT * FROM bookings
WHERE id= :generated_key

-- :name get-available-seats :? :*
-- doc: show available seats for the show
SELECT seats.id, seats.seat_name FROM (SELECT * FROM show_seats WHERE show_seats.show_id=:id) AS the_show RIGHT JOIN seats ON the_show.seat_id=seats.id WHERE the_show.seat_id IS NULL;

-- :name delete-bookings :! :n
-- :doc Delete bookings by show_id
DELETE FROM bookings WHERE bookings.show_id=:id 
