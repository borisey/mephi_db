CREATE TEMPORARY TABLE ClientBookings AS
SELECT
    customer.ID_customer,
    customer.name,
    COUNT(booking.ID_booking) AS total_bookings,
    COUNT(DISTINCT hotel.ID_hotel) AS unique_hotels,
    SUM(room.price) AS total_spent
FROM Booking booking
         JOIN Customer customer ON booking.ID_customer = customer.ID_customer
         JOIN Room room ON booking.ID_room = room.ID_room
         JOIN Hotel hotel ON room.ID_hotel = hotel.ID_hotel
GROUP BY customer.ID_customer, customer.name
HAVING COUNT(booking.ID_booking) > 2 AND COUNT(DISTINCT hotel.ID_hotel) > 1;

CREATE TEMPORARY TABLE ClientSpentMoreThan500 AS
SELECT
    customer.ID_customer,
    customer.name,
    SUM(room.price) AS total_spent,
    COUNT(booking.ID_booking) AS total_bookings
FROM Booking booking
         JOIN Customer customer ON booking.ID_customer = customer.ID_customer
         JOIN Room room ON booking.ID_room = room.ID_room
GROUP BY customer.ID_customer, customer.name
HAVING SUM(room.price) > 500;

SELECT
    client_bookings.ID_customer,
    client_bookings.name,
    client_bookings.total_bookings,
    client_bookings.total_spent,
    client_bookings.unique_hotels
FROM ClientBookings client_bookings
         JOIN ClientSpentMoreThan500 csm ON client_bookings.ID_customer = csm.ID_customer
ORDER BY client_bookings.total_spent ASC;