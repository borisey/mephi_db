SELECT vehicle.maker, car.model, car.horsepower, car.engine_capacity, 'Car' AS vehicle_type
FROM Vehicle vehicle
JOIN Car car ON vehicle.model = car.model
WHERE car.horsepower > 150
  AND car.price < 35000.00
  AND car.engine_capacity < 3

UNION ALL

SELECT vehicle.maker, motorcycle.model, motorcycle.horsepower, motorcycle.engine_capacity, 'Motorcycle' AS vehicle_type
FROM Vehicle vehicle
JOIN Motorcycle motorcycle ON vehicle.model = motorcycle.model
WHERE motorcycle.horsepower > 150
  AND motorcycle.price < 20000.00
  AND motorcycle.engine_capacity < 1.5

UNION ALL

SELECT vehicle.maker, bicycle.model, NULL AS horsepower, NULL AS engine_capacity,  'Bicycle' AS vehicle_type
FROM Vehicle vehicle
JOIN Bicycle bicycle ON vehicle.model = bicycle.model
WHERE bicycle.gear_count > 18
  AND bicycle.price < 4000.00

ORDER BY horsepower DESC;