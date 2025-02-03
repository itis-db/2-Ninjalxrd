/**
  @author
 */
DROP TABLE IF EXISTS Client CASCADE;
DROP TABLE IF EXISTS Car CASCADE;
DROP TABLE IF EXISTS Repair CASCADE;

CREATE TABLE Client (
    client_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE Car (
    car_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Client(client_id),
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT NOT NULL
);

CREATE TABLE Repair (
    repair_id SERIAL PRIMARY KEY,
    car_id INT REFERENCES Car(car_id),
    description TEXT NOT NULL,
    cost NUMERIC(10, 2) NOT NULL,
    repair_date DATE NOT NULL
);

INSERT INTO Client (name, phone, email)
SELECT
    'Client ' || n AS name,
    '+7' || floor(random() * 1000000000)::text AS phone,
    'client' || n || '@example.com' AS email
FROM generate_series(1, 500) AS n;

INSERT INTO Car (client_id, make, model, year)
SELECT
    (random() * ((SELECT COUNT(*) FROM Client) - 1))::int + 1 AS client_id,
    CASE floor(random() * 5)
        WHEN 0 THEN 'Toyota'
        WHEN 1 THEN 'Honda'
        WHEN 2 THEN 'Ford'
        WHEN 3 THEN 'BMW'
        ELSE 'Audi'
    END AS make,
    CASE floor(random() * 5)
        WHEN 0 THEN 'Corolla'
        WHEN 1 THEN 'Civic'
        WHEN 2 THEN 'Focus'
        WHEN 3 THEN 'X5'
        ELSE 'A4'
    END AS model,
    (random() * 24 + 2000)::int AS year
FROM generate_series(1, 500) AS n;

INSERT INTO Repair (car_id, description, cost, repair_date)
SELECT
    (random() * ((SELECT COUNT(*) FROM Car) - 1))::int + 1 AS car_id,
    CASE floor(random() * 5)
        WHEN 0 THEN 'Oil change'
        WHEN 1 THEN 'Engine repair'
        WHEN 2 THEN 'Brake pad replacement'
        WHEN 3 THEN 'Body painting'
        ELSE 'Battery replacement'
    END AS description,
    (random() * 1000 + 50)::numeric(10, 2) AS cost,
    CURRENT_DATE - (random() * 365)::int AS repair_date
FROM generate_series(1, 500) AS n;

SELECT * FROM Client;
SELECT * FROM Car ;
SELECT * FROM Repair;
