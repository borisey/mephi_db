SELECT
    customer.name,
    customer.email,
    customer.phone,
    COUNT(booking.ID_booking) AS total_bookings,
    GROUP_CONCAT(DISTINCT hotel.name ORDER BY hotel.name SEPARATOR ', ') AS hotel_list,
    ROUND(AVG(DATEDIFF(booking.check_out_date, booking.check_in_date)), 4) AS avg_stay_duration
FROM Booking booking
         JOIN Customer customer ON booking.ID_customer = customer.ID_customer
         JOIN Room room ON booking.ID_room = room.ID_room
         JOIN Hotel hotel ON room.ID_hotel = hotel.ID_hotel
GROUP BY customer.ID_customer
HAVING COUNT(DISTINCT hotel.ID_hotel) > 1 AND COUNT(booking.ID_booking) >= 3
ORDER BY total_bookings DESC;