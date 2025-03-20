CREATE TEMPORARY TABLE HotelCategories AS
SELECT
    hotel.ID_hotel,
    CASE
        WHEN AVG(room.price) < 175 THEN 'Дешевый'
        WHEN AVG(room.price) BETWEEN 175 AND 300 THEN 'Средний'
        WHEN AVG(room.price) > 300 THEN 'Дорогой'
        END AS hotel_category
FROM Hotel hotel
         JOIN Room room ON hotel.ID_hotel = room.ID_hotel
GROUP BY hotel.ID_hotel;

CREATE TEMPORARY TABLE CustomerPreferences AS
SELECT
    booking.ID_customer,
    MAX(CASE
            WHEN hotel_categories.hotel_category = 'Дорогой' THEN 'Дорогой'
            WHEN hotel_categories.hotel_category = 'Средний' THEN 'Средний'
            WHEN hotel_categories.hotel_category = 'Дешевый' THEN 'Дешевый'
            ELSE NULL
        END) AS preferred_hotel_type,
    GROUP_CONCAT(DISTINCT hotel.name ORDER BY hotel.name SEPARATOR ', ') AS visited_hotels
FROM Booking booking
         JOIN Room room ON booking.ID_room = room.ID_room
         JOIN Hotel hotel ON room.ID_hotel = hotel.ID_hotel
         JOIN HotelCategories hotel_categories ON hotel.ID_hotel = hotel_categories.ID_hotel
GROUP BY booking.ID_customer;

SELECT
    customer_preferences.ID_customer,
    customer.name,
    customer_preferences.preferred_hotel_type,
    customer_preferences.visited_hotels
FROM CustomerPreferences customer_preferences
         JOIN Customer customer ON customer_preferences.ID_customer = customer.ID_customer
ORDER BY
    CASE customer_preferences.preferred_hotel_type
        WHEN 'Дешевый' THEN 1
        WHEN 'Средний' THEN 2
        WHEN 'Дорогой' THEN 3
        END;