SELECT
    cars.name AS car_name,
    cars.class AS car_class,
    AVG(results.position) AS average_position,
    COUNT(*) AS race_count,
    classes.country AS car_country
FROM Cars cars
         JOIN Results results ON cars.name = results.car
         JOIN Classes classes ON cars.class = classes.class
GROUP BY cars.name, cars.class, classes.country
ORDER BY average_position ASC, car_name ASC
    LIMIT 1;