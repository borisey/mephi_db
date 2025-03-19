SELECT
    ca.car_name,
    ca.car_class,
    ROUND(ca.average_position, 4) AS average_position,
    ca.race_count,
    cl.country AS car_country
FROM (
         SELECT
             c.name AS car_name,
             c.class AS car_class,
             AVG(r.position) AS average_position,
             COUNT(r.race) AS race_count
         FROM Cars c
                  JOIN Results r ON c.name = r.car
         GROUP BY c.name, c.class
     ) ca
         JOIN (
    SELECT
        c.class AS car_class,
        AVG(r.position) AS class_avg_position
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.class
    HAVING COUNT(*) > 1
) class_avg ON ca.car_class = class_avg.car_class
         JOIN Classes cl ON ca.car_class = cl.class
WHERE ca.average_position < class_avg.class_avg_position
ORDER BY ca.car_class, ca.average_position;