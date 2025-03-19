SELECT
    ca.car_name,
    ca.car_class,
    ROUND(ca.average_position, 4) AS average_position,
    ca.race_count,
    classes.country,
    sc.total_race_count AS total_races
FROM (
         SELECT
             cars.name AS car_name,
             cars.class AS car_class,
             AVG(results.position) AS average_position,
             COUNT(results.race) AS race_count
         FROM Cars cars
                  JOIN Results results ON cars.name = results.car
         GROUP BY cars.name, cars.class
     ) ca
         JOIN (
    SELECT
        ca.car_class,
        ca.avg_class_position,
        ca.total_race_count
    FROM (
             SELECT
                 cars.class AS car_class,
                 AVG(results.position) AS avg_class_position,
                 COUNT(results.race) AS total_race_count
             FROM Cars cars
                      JOIN Results results ON cars.name = results.car
             GROUP BY cars.class
         ) ca
             JOIN (
        SELECT MIN(avg_class_position) AS min_avg_position
        FROM (
                 SELECT
                     cars.class AS car_class,
                     AVG(results.position) AS avg_class_position
                 FROM Cars cars
                          JOIN Results results ON cars.name = results.car
                 GROUP BY cars.class
             ) subquery
    ) ma ON ca.avg_class_position = ma.min_avg_position
) sc ON ca.car_class = sc.car_class
         JOIN Classes classes ON ca.car_class = classes.class
ORDER BY average_position, car_name;