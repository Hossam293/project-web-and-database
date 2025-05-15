CREATE DATABASE smart_farm;
USE smart_farm;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);

INSERT INTO Users VALUES
(1, 'Ahmed Ali', 'ahmed@example.com', 'pass123'),
(2, 'Sara Hassan', 'sara@example.com', 'pass456'),
(3, 'Khaled Youssef', 'khaled@example.com', 'pass789'),
(4, 'Laila Mansour', 'laila@example.com', 'pass234'),
(5, 'Omar Fathy', 'omar@example.com', 'pass567'),
(6, 'Nour Adel', 'nour@example.com', 'pass678'),
(7, 'Youssef Sami', 'youssef@example.com', 'pass890'),
(8, 'Huda Salim', 'huda@example.com', 'pass321'),
(9, 'Tariq Nabil', 'tariq@example.com', 'pass741'),
(10, 'Mona Ehab', 'mona@example.com', 'pass852');

CREATE TABLE Device (
    device_id INT PRIMARY KEY,
    user_id INT,
    device_name VARCHAR(100),
    location VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Device VALUES
(1, 1, 'Sensor-1', 'Farm A'),
(2, 1, 'Sensor-2', 'Farm B'),
(3, 2, 'Sensor-3', 'Greenhouse'),
(4, 3, 'Sensor-4', 'Desert Farm'),
(5, 4, 'Sensor-5', 'Palm Field'),
(6, 5, 'Sensor-6', 'Rooftop'),
(7, 6, 'Sensor-7', 'Greenhouse B'),
(8, 7, 'Sensor-8', 'Urban Farm'),
(9, 8, 'Sensor-9', 'Orchard'),
(10, 9, 'Sensor-10', 'Corn Field');

CREATE TABLE SensorData (
    data_id INT PRIMARY KEY,
    user_id INT,
    device_id INT,
    temperature FLOAT,
    soil_moisture FLOAT,
    timestamp DATETIME,
    water_needed BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (device_id) REFERENCES Device(device_id)
);

INSERT INTO SensorData VALUES
(1, 1, 1, 33.4, 10.2, '2025-05-10 08:00:00', TRUE),
(2, 1, 2, 29.1, 40.5, '2025-05-10 09:00:00', FALSE),
(3, 2, 3, 27.3, 18.4, '2025-05-10 10:00:00', TRUE),
(4, 3, 4, 35.0, 12.7, '2025-05-10 11:00:00', TRUE),
(5, 4, 5, 30.1, 50.2, '2025-05-10 12:00:00', FALSE),
(6, 5, 6, 32.8, 15.3, '2025-05-10 13:00:00', TRUE),
(7, 6, 7, 28.4, 45.0, '2025-05-10 14:00:00', FALSE),
(8, 7, 8, 31.6, 19.8, '2025-05-10 15:00:00', TRUE),
(9, 8, 9, 33.9, 22.1, '2025-05-10 16:00:00', TRUE),
(10, 9, 10, 30.5, 17.6, '2025-05-10 17:00:00', TRUE);

CREATE TABLE Alert (
    alert_id INT PRIMARY KEY,
    user_id INT,
    device_id INT,
    message TEXT,
    level VARCHAR(20),
    timestamp DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (device_id) REFERENCES Device(device_id)
);

INSERT INTO Alert VALUES
(1, 1, 1, 'Low moisture detected', 'High', '2025-05-10 08:10:00'),
(2, 1, 2, 'Optimal conditions', 'Low', '2025-05-10 09:10:00'),
(3, 2, 3, 'Low moisture', 'Medium', '2025-05-10 10:10:00'),
(4, 3, 4, 'Very dry soil', 'High', '2025-05-10 11:10:00'),
(5, 4, 5, 'Irrigation needed', 'Medium', '2025-05-10 12:10:00'),
(6, 5, 6, 'Soil drying rapidly', 'High', '2025-05-10 13:10:00'),
(7, 6, 7, 'Stable condition', 'Low', '2025-05-10 14:10:00'),
(8, 7, 8, 'Need attention', 'Medium', '2025-05-10 15:10:00'),
(9, 8, 9, 'Low moisture warning', 'Medium', '2025-05-10 16:10:00'),
(10, 9, 10, 'Critical condition', 'High', '2025-05-10 17:10:00');

