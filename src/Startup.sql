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

INSERT INTO users (email,password,isAdmin) VALUES('admin@a','a',true);

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
                          paymentId INTEGER PRIMARY KEY AUTOINCREMENT,
                          userId INTEGER NOT NULL,
                          methodId INTEGER NOT NULL,
                          amount REAL,
                          date TEXT,
                          status TEXT,
                          FOREIGN KEY(userId) REFERENCES Users(userId),
                          FOREIGN KEY(methodId) REFERENCES PaymentMethods(methodId)
);

INSERT INTO Payments (userId, methodId, amount, date, status) VALUES
                                                                  (1, 1, 129.99, '2025-05-01', 'Completed'),
                                                                  (1, 2, 49.99, '2025-05-02', 'Pending'),
                                                                  (2, 3, 299.00, '2025-05-03', 'Completed'),
                                                                  (3, 5, 79.99, '2025-05-04', 'Failed'),
                                                                  (4, 6, 599.00, '2025-05-05', 'Completed'),
                                                                  (5, 7, 89.99, '2025-05-06', 'Completed');

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
    logoutTime VARCHAR(255)
);

SELECT * FROM products;
SELECT * FROM users;
SELECT * FROM websiteAccessLog;