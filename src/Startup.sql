-- Drop tables in reverse dependency order
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS PaymentMethods;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS websiteAccessLog;
DROP TABLE IF EXISTS Shipments;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
                       userID INTEGER PRIMARY KEY AUTOINCREMENT,
                       firstName VARCHAR(255),
                       lastName VARCHAR(255),
                       email VARCHAR(255),
                       password VARCHAR(255),
                       address VARCHAR(255),
                       mobile TEXT,
                       city VARCHAR(255),
                       state VARCHAR(255),
                       isAdmin BOOLEAN
);

-- Insert users
INSERT INTO users (firstName, lastName, email, password, address, mobile, city, state, isAdmin) VALUES
                                                                                                    ('Andrew', 'Mungai', 'a@a', 'a', '123 Smart St', '1234567890', 'Sydney', 'NSW', 0),
                                                                                                    ('And3ew', 'Mungai', 'b@b', 'a', '456 Tech Ave', '2345678901', 'Melbourne','VIC', 0),
                                                                                                    ('Jane', 'Doe', 'jane@example.com', 'pass123', '789 Light Rd', '3456789012', 'Brisbane', 'QLD', 0),
                                                                                                    ('John', 'Smith', 'john@example.com', 'abc456', '321 Cloud Ln', '4567890123', 'Perth', 'WA', 0),
                                                                                                    ('Emily', 'Brown', 'emily@example.com', 'xyz789', '654 AI Blvd', '5678901234', 'Adelaide', 'SA', 0),
                                                                                                    ('Tony', 'Tran', 'admin@a', 'a', 'Charles St', '0123456789', 'Sydney', 'NSW', 1);

-- Create PaymentMethods table
CREATE TABLE PaymentMethods (
                                methodId INTEGER PRIMARY KEY AUTOINCREMENT,
                                userId INTEGER NOT NULL,
                                type TEXT NOT NULL,
                                cardNumber TEXT,
                                nameOnCard TEXT,
                                expiry TEXT,
                                cvv TEXT,
                                FOREIGN KEY(userId) REFERENCES users(userId)
);

-- Insert PaymentMethods
INSERT INTO PaymentMethods (userId, type, cardNumber, nameOnCard, expiry, cvv) VALUES
                                                                                   (1, 'Credit Card', '4111111111111111', 'Andrew Mungai', '2025-12', '123'),
                                                                                   (1, 'Debit Card', '5500000000000004', 'Andrew Mungai', '2026-06', '456'),
                                                                                   (2, 'PayPal', NULL, 'And3ew Mungai (PayPal)', NULL, NULL),
                                                                                   (2, 'Bank Transfer', NULL, 'And3ew Mungai (Bank)', NULL, NULL),
                                                                                   (3, 'Credit Card', '4000123412341234', 'Jane Doe', '2025-05', '321'),
                                                                                   (4, 'Credit Card', '4242424242424242', 'John Smith', '2027-11', '789'),
                                                                                   (5, 'Debit Card', '6011000990139424', 'Emily Brown', '2024-09', '654');

-- Create Payments table
CREATE TABLE Payments (
                          paymentId INTEGER PRIMARY KEY,
                          userId INTEGER NOT NULL,
                          methodId INTEGER NOT NULL,
                          amount REAL,
                          date TEXT,
                          status TEXT,
                          FOREIGN KEY(userId) REFERENCES users(userId),
                          FOREIGN KEY(methodId) REFERENCES PaymentMethods(methodId)
);

-- Sample insert for Payments (keep your extended list in a separate script if needed)
INSERT INTO Payments (paymentId, userId, methodId, amount, date, status) VALUES
                                                                             (18376291, 1, 1, 129.99, '2025-05-01', 'Completed'),
                                                                             (28163927, 1, 2, 49.99, '2025-05-02', 'Pending'),
                                                                             (30945871, 4, 6, 599.00, '2025-05-05', 'Completed');

-- Create Orders table
CREATE TABLE Orders (
                        orderId INTEGER PRIMARY KEY AUTOINCREMENT,
                        userId INTEGER NOT NULL,
                        paymentId INTEGER NOT NULL,
                        orderDate TEXT NOT NULL,
                        status TEXT DEFAULT 'Pending',
                        FOREIGN KEY(userId) REFERENCES users(userId),
                        FOREIGN KEY(paymentId) REFERENCES Payments(paymentId)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
                            itemId INTEGER PRIMARY KEY AUTOINCREMENT,
                            orderId INTEGER,
                            productId INTEGER,
                            quantity INTEGER,
                            FOREIGN KEY(orderId) REFERENCES Orders(orderId),
                            FOREIGN KEY(productId) REFERENCES products(productId)
);

-- Create Shipments table
CREATE TABLE Shipments (
                           shipmentId INTEGER PRIMARY KEY AUTOINCREMENT,
                           orderId INTEGER NOT NULL,
                           address TEXT NOT NULL,
                           shippingMethod TEXT NOT NULL,
                           shippingDate TEXT NOT NULL,
                           FOREIGN KEY(orderId) REFERENCES Orders(orderId)
);

-- Create products table
CREATE TABLE products (
                          productID INTEGER PRIMARY KEY AUTOINCREMENT,
                          productName VARCHAR(255),
                          price FLOAT(6,2),
                          productDescription VARCHAR(255),
                          productImageAddress VARCHAR(225),
                          stock INTEGER NOT NULL DEFAULT 10
);

-- Insert sample products
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

-- Create websiteAccessLog table
CREATE TABLE websiteAccessLog (
                                  logID INTEGER PRIMARY KEY AUTOINCREMENT,
                                  userID INTEGER,
                                  loginTime VARCHAR(255),
                                  logoutTime VARCHAR(255),
                                  FOREIGN KEY(userID) REFERENCES users(userID)
);

-- Sample insert for access log
INSERT INTO websiteAccessLog(userID, loginTime, logoutTime)
VALUES (1, '2025-05-08 02:02:14', '2025-05-08 02:02:20');
