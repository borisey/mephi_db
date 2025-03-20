CREATE TEMPORARY TABLE CarAverages AS
SELECT
    cars.name AS car_name,
    cars.class AS car_class,
    AVG(results.position) AS average_position,
    COUNT(results.race) AS race_count
FROM Cars cars
         JOIN Results results ON cars.name = results.car
GROUP BY cars.name, cars.class;

CREATE TEMPORARY TABLE LowPositionCars AS
SELECT
    car_averages.car_name,
    car_averages.car_class,
    car_averages.average_position,
    car_averages.race_count
FROM CarAverages car_averages
WHERE car_averages.average_position > 3.0;

CREATE TEMPORARY TABLE ClassRaceCounts AS
SELECT
    cars.class AS car_class,
    COUNT(results.race) AS total_race_count
FROM Cars cars
         JOIN Results results ON cars.name = results.car
GROUP BY cars.class;

CREATE TEMPORARY TABLE ClassLowPositionCounts AS
SELECT
    lpc.car_class,
    COUNT(lpc.car_name) AS low_position_count
FROM LowPositionCars lpc
GROUP BY lpc.car_class;

SELECT
    lpc.car_name,
    lpc.car_class,
    ROUND(lpc.average_position, 4) AS average_position,
    lpc.race_count,
    cl.country,
    crc.total_race_count,
    clpc.low_position_count
FROM LowPositionCars lpc
         JOIN ClassLowPositionCounts clpc ON lpc.car_class = clpc.car_class
         JOIN Classes cl ON lpc.car_class = cl.class
         JOIN ClassRaceCounts crc ON lpc.car_class = crc.car_class
ORDER BY clpc.low_position_count DESC, lpc.average_position DESC;