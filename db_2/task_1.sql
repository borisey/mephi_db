SELECT
    AveragePosition.car_name,
    AveragePosition.car_class,
    AveragePosition.average_position,
    AveragePosition.race_count
FROM (
         SELECT
             cars.class AS car_class,
             cars.name AS car_name,
             AVG(results.position) AS average_position,
             COUNT(*) AS race_count
         FROM Cars cars
                  JOIN Results results ON cars.name = results.car
         GROUP BY cars.class, cars.name
     ) AS AveragePosition
         JOIN (
    SELECT
        car_class,
        MIN(average_position) AS minimum_average_position
    FROM (
             SELECT
                 cars.class AS car_class,
                 cars.name AS car_name,
                 AVG(position) AS average_position
             FROM Cars cars
                      JOIN Results results ON cars.name = results.car
             GROUP BY cars.class, cars.name
         ) AS AvgPos
    GROUP BY car_class
) AS MAP
              ON AveragePosition.car_class = MAP.car_class
                  AND AveragePosition.average_position = MAP.minimum_average_position
ORDER BY AveragePosition.average_position;