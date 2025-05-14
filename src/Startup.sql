DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS PaymentMethods;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS websiteAccessLog;

CREATE TABLE users (
                       userID INTEGER PRIMARY KEY AUTOINCREMENT,
                       firstName VARCHAR(255),
                       lastName VARCHAR(255),
                       email VARCHAR(255),
                       password VARCHAR(255),
                       address VARCHAR(255),
                       mobile INT,
                       city VARCHAR(255),
                       state VARCHAR(255),
                       isAdmin BOOLEAN
);

INSERT INTO users (firstName, lastName, email, password, address, mobile, city, state) VALUES
                                                                                           ('Andrew', 'Mungai', 'a@a', 'a', '123 Smart St', 1234567890, 'Sydney', 'NSW'),
                                                                                           ('And3ew', 'Mungai', 'b@b', 'a', '456 Tech Ave', 2345678901, 'Melbourne', 'VIC'),
                                                                                           ('Jane', 'Doe', 'jane@example.com', 'pass123', '789 Light Rd', 3456789012, 'Brisbane', 'QLD'),
                                                                                           ('John', 'Smith', 'john@example.com', 'abc456', '321 Cloud Ln', 4567890123, 'Perth', 'WA'),
                                                                                           ('Emily', 'Brown', 'emily@example.com', 'xyz789', '654 AI Blvd', 5678901234, 'Adelaide', 'SA');


INSERT INTO users (firstName, email,password,isAdmin) VALUES('ANDREW-ADMIN','admin@a','a',true);


CREATE TABLE IF NOT EXISTS PaymentMethods (
                                              methodId INTEGER PRIMARY KEY AUTOINCREMENT,
                                              userId INTEGER NOT NULL,
                                              type TEXT NOT NULL,
                                              cardNumber TEXT,
                                              nameOnCard TEXT,
                                              expiry TEXT,
                                              cvv TEXT,
                                              FOREIGN KEY(userId) REFERENCES Users(userId)
);

INSERT INTO PaymentMethods (userId, type, cardNumber, nameOnCard, expiry, cvv) VALUES
                                                                                   (1, 'Credit Card', '4111111111111111', 'Andrew Mungai', '2025-12', '123'),
                                                                                   (1, 'Debit Card', '5500000000000004', 'Andrew Mungai', '2026-06', '456'),
                                                                                   (2, 'PayPal', NULL, 'And3ew Mungai (PayPal)', NULL, NULL),
                                                                                   (2, 'Bank Transfer', NULL, 'And3ew Mungai (Bank)', NULL, NULL),
                                                                                   (3, 'Credit Card', '4000123412341234', 'Jane Doe', '2025-05', '321'),
                                                                                   (4, 'Credit Card', '4242424242424242', 'John Smith', '2027-11', '789'),
                                                                                   (5, 'Debit Card', '6011000990139424', 'Emily Brown', '2024-09', '654');

CREATE TABLE Payments (
                          paymentId INTEGER PRIMARY KEY ,
                          userId INTEGER NOT NULL,
                          methodId INTEGER NOT NULL,
                          amount REAL,
                          date TEXT,
                          status TEXT,
                          FOREIGN KEY(userId) REFERENCES Users(userId),
                          FOREIGN KEY(methodId) REFERENCES PaymentMethods(methodId)
);


-- manual inserts for Payments
INSERT INTO Payments (paymentId, userId, methodId, amount, date, status) VALUES
                                                                             (18376291, 1, 1, 129.99, '2025-05-01', 'Completed'),
                                                                             (28163927, 1, 2, 49.99, '2025-05-02', 'Pending'),
                                                                             (30945871, 4, 6, 599.00, '2025-05-05', 'Completed'),
                                                                             (27418936, 5, 7, 89.99, '2025-05-06', 'Completed'),
                                                                             (28451702, 1, 1, 75.00, '2025-05-11', 'Completed'),
                                                                             (21298374, 1, 2, 10.00, '2025-05-12', 'Completed'),
                                                                             (14782930, 1, 1, 49.99, '2025-04-01', 'Completed'),
                                                                             (15849274, 1, 2, 89.50, '2025-04-02', 'Pending'),
                                                                             (16749385, 1, 1, 120.00, '2025-04-03', 'Completed'),
                                                                             (17839465, 1, 2, 75.30, '2025-04-04', 'Failed'),
                                                                             (18920384, 1, 1, 60.10, '2025-04-05', 'Completed'),
                                                                             (19384756, 1, 2, 33.99, '2025-04-06', 'Completed'),
                                                                             (20495834, 1, 1, 150.75, '2025-04-07', 'Pending'),
                                                                             (21938475, 1, 2, 20.00, '2025-04-08', 'Completed'),
                                                                             (22638495, 1, 1, 45.25, '2025-04-09', 'Failed'),
                                                                             (23495874, 1, 2, 99.95, '2025-04-10', 'Completed'),
                                                                             (24593847, 1, 1, 110.00, '2025-04-11', 'Completed'),
                                                                             (25738495, 1, 2, 80.80, '2025-04-12', 'Pending'),
                                                                             (26495823, 1, 1, 69.69, '2025-04-13', 'Completed'),
                                                                             (27839571, 1, 2, 34.34, '2025-04-14', 'Completed'),
                                                                             (28394759, 1, 1, 200.00, '2025-04-15', 'Failed'),
                                                                             (29385741, 1, 2, 58.58, '2025-04-16', 'Completed'),
                                                                             (30294857, 1, 1, 77.77, '2025-04-17', 'Completed'),
                                                                             (31837492, 1, 2, 90.00, '2025-04-18', 'Pending'),
                                                                             (32948573, 1, 1, 42.42, '2025-04-19', 'Completed'),
                                                                             (33749285, 1, 2, 35.00, '2025-04-20', 'Completed');

INSERT INTO Payments (paymentId, userId, methodId, amount, date, status) VALUES
                                                                             (36120032, 3, 1, 164.72, '2025-09-19', 'Failed'),
                                                                             (35822900, 5, 1, 204.91, '2025-12-29', 'Failed'),
                                                                             (21937822, 4, 2, 21.45, '2025-10-01', 'Pending'),
                                                                             (18137768, 4, 2, 58.11, '2025-03-19', 'Failed'),
                                                                             (28247279, 2, 1, 199.45, '2025-11-30', 'Completed'),
                                                                             (28739415, 2, 2, 259.17, '2025-08-24', 'Failed'),
                                                                             (17169176, 4, 2, 31.14, '2025-05-27', 'Completed'),
                                                                             (36218241, 4, 1, 126.03, '2025-01-07', 'Failed'),
                                                                             (12260177, 4, 1, 108.78, '2025-02-13', 'Pending'),
                                                                             (28765461, 3, 2, 117.58, '2025-10-06', 'Pending'),
                                                                             (28024695, 5, 1, 250.21, '2025-01-09', 'Completed'),
                                                                             (27085068, 5, 1, 64.47, '2025-11-30', 'Pending'),
                                                                             (20976777, 3, 1, 171.26, '2025-04-13', 'Failed'),
                                                                             (33237659, 2, 1, 221.49, '2025-12-28', 'Pending'),
                                                                             (20612642, 3, 1, 189.28, '2025-05-06', 'Pending'),
                                                                             (14276441, 5, 1, 210.49, '2025-06-03', 'Pending'),
                                                                             (35485923, 1, 1, 30.92, '2025-04-07', 'Completed'),
                                                                             (26413671, 5, 2, 85.88, '2025-04-16', 'Pending'),
                                                                             (39314778, 2, 2, 170.17, '2025-03-31', 'Completed'),
                                                                             (30600118, 4, 2, 43.52, '2025-01-11', 'Failed'),
                                                                             (34396475, 4, 1, 55.63, '2025-05-14', 'Completed'),
                                                                             (26986678, 4, 1, 42.55, '2025-10-22', 'Failed'),
                                                                             (11005487, 4, 2, 264.13, '2025-06-03', 'Failed'),
                                                                             (34666773, 4, 2, 22.02, '2025-11-05', 'Pending'),
                                                                             (18289740, 2, 1, 96.2, '2025-12-20', 'Failed');

CREATE TABLE Orders (
                        orderId INTEGER PRIMARY KEY AUTOINCREMENT,
                        userId INTEGER NOT NULL,
                        paymentId INTEGER NOT NULL,
                        orderDate TEXT NOT NULL,
                        FOREIGN KEY (userId) REFERENCES Users(userId),
                        FOREIGN KEY (paymentId) REFERENCES Payments(paymentId)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
                            itemId INTEGER PRIMARY KEY AUTOINCREMENT,
                            orderId INTEGER,
                            productId INTEGER,
                            quantity INTEGER,
                            FOREIGN KEY (orderId) REFERENCES Orders(orderId),
                            FOREIGN KEY (productId) REFERENCES Products(productId)
);

-- Create products table (unchanged)
CREATE TABLE products (
                          productID INTEGER PRIMARY KEY AUTOINCREMENT,
                          productName VARCHAR(255),
                          price FLOAT(6,2),
                          productDescription VARCHAR(255),
                          productImageAddress VARCHAR(225)
);

INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Smart Plug', 'Control your devices remotely', 29.99, 'assets/images/smart-plug.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Smart Light Bulb', 'Adjustable brightness and colors', '19.99', 'assets/images/smart-lightbulb.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Smart Thermostat', 'Energy-saving smart temperature control', '79.99', 'assets/images/smart-thermostat.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Smart Speaker', 'Voice-controlled AI assistant', '49.99', 'assets/images/smart-speaker.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Smart Security Camera', 'Real-time home monitoring', '99.99', 'assets/images/smart-camera.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Smart Door Lock', 'Keyless entry with mobile access', '89.99', 'assets/images/smart-doorlock.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Amazon Echo Dot (4th Gen)', 'Compact smart speaker with Alexa integration', '79.00', 'assets/images/echo-dot.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Google Nest Hub (2nd Gen)', 'Smart display with Google Assistant', '149.00', 'assets/images/nest-hub.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Philips Hue Starter Kit', 'Smart LED bulbs with app and voice control', '199.00', 'assets/images/philips-hue.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('TP-Link Kasa Smart Plug', 'Control your devices remotely', '29.99', 'assets/images/smart-plug.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Ring Video Doorbell 3', 'Video doorbell with two-way audio', '329.00', 'assets/images/ring-doorbell.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Nest Learning Thermostat (3rd Gen)', 'Learns preferences and saves energy', '349.00', 'assets/images/nest-thermostat.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Arlo Pro 4 Security Camera', '2K wireless camera with night vision', '399.00', 'assets/images/arlo-pro-4.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('August Wi-Fi Smart Lock', 'Keyless entry smart lock with remote access', '399.00', 'assets/images/august-lock.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Samsung SmartThings Hub', 'Connect and control all your smart devices', '99.00', 'assets/images/smartthings-hub.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('iRobot Roomba 692', 'Smart robot vacuum with adaptive navigation', '499.00', 'assets/images/roomba-692.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Fitbit Charge 5', 'Fitness tracker with heart rate and GPS', '269.00', 'assets/images/fitbit-charge-5.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Sony WH-1000XM4', 'Noise-canceling wireless headphones', '499.00', 'assets/images/sony-wh1000xm4.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Apple Watch Series 7', 'Smartwatch with health and app integration', '599.00', 'assets/images/apple-watch-series-7.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Eufy RoboVac 11S', 'Slim and quiet robotic vacuum cleaner', '299.00', 'assets/images/eufy-robovac.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Netatmo Weather Station', 'Monitors indoor and outdoor conditions', '249.00', 'assets/images/netatmo.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Tile Pro Tracker', 'Bluetooth tracker for keys and bags', '49.00', 'assets/images/tile-pro.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('LIFX Mini Smart Bulb', 'Colorful smart bulb with app control', '59.00', 'assets/images/lifx-mini.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Withings Body+ Smart Scale', 'Body composition scale with health sync', '179.00', 'assets/images/withings-body.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Logitech Harmony Elite', 'Universal remote for smart devices', '449.00', 'assets/images/logitech-harmony.png');
INSERT INTO products(productName, productDescription, price, productImageAddress) VALUES ('Sonos One', 'Smart speaker with high quality sound', '299.00', 'assets/images/sonos-one.png');


CREATE TABLE websiteAccessLog(
                                 logID INTEGER PRIMARY KEY AUTOINCREMENT,
                                 userID INTEGER,
                                 loginTime VARCHAR(255),
                                 logoutTime VARCHAR(255),
                                 FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE IF NOT EXISTS Shipments (
                                         shipmentId INTEGER PRIMARY KEY AUTOINCREMENT,
                                         orderId INTEGER,
                                         address TEXT,
                                         shippingMethod TEXT,
                                         shippingDate TEXT
);

INSERT INTO websiteAccessLog(userID, loginTime, logoutTime) VALUES (1,'2025-05-08 02:02:14','2025-05-08 02:02:20');

INSERT INTO users(firstName, lastName, email, password, address, mobile, city, state, isAdmin)  VALUES  ('Tony', 'Tran', 'admin@a', 'a', 'Charles St', '0123456789', 'Sydney', 'NSW', 1);

SELECT userID, firstName, lastName, email, isAdmin FROM users WHERE email='admin@a' AND password='a';