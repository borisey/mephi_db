SELECT vehicle.maker, motorcycle.model
FROM Vehicle vehicle
JOIN Motorcycle motorcycle ON vehicle.model = motorcycle.model
WHERE motorcycle.horsepower > 150
  AND motorcycle.price < 20000.00
  AND motorcycle.type = 'Sport'
  ORDER BY motorcycle.horsepower DESC;