package com.IoTBay.model.dao;

import com.IoTBay.model.Order;
import org.junit.jupiter.api.*;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class OrderDBManagerTest {

    private Connection connection;
    private OrderDBManager orderDBManager;

    @BeforeEach
    void setUp() throws SQLException {
        connection = DriverManager.getConnection("jdbc:sqlite::memory:");
        Statement stmt = connection.createStatement();

        stmt.executeUpdate(
                "CREATE TABLE Orders (" +
                        "orderId INTEGER PRIMARY KEY AUTOINCREMENT, " +
                        "userId INTEGER NOT NULL, " +
                        "paymentId INTEGER NOT NULL, " +
                        "orderDate TEXT NOT NULL, " +
                        "status TEXT NOT NULL)"
        );

        orderDBManager = new OrderDBManager(connection);
    }

    @Test
    void testAddOrderSuccessfully() throws SQLException {
        Order order = new Order(0, 12, 55, LocalDateTime.of(2025, 6, 1, 10, 30), "Pending");

        Order savedOrder = orderDBManager.add(order);

        assertTrue(savedOrder.getOrderId() > 0);
        assertEquals(12, savedOrder.getUserId());
        assertEquals(55, savedOrder.getPaymentId());
        assertEquals("Pending", savedOrder.getStatus());

        // Query DB to verify record exists
        PreparedStatement ps = connection.prepareStatement("SELECT * FROM Orders WHERE orderId = ?");
        ps.setInt(1, savedOrder.getOrderId());
        ResultSet rs = ps.executeQuery();

        assertTrue(rs.next());
        assertEquals(12, rs.getInt("userId"));
        assertEquals(55, rs.getInt("paymentId"));
        assertEquals("Pending", rs.getString("status"));
        assertEquals("2025-06-01 10:30:00", rs.getString("orderDate"));
    }

    @AfterEach
    void tearDown() throws SQLException {
        connection.close();
    }
}
