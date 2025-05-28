package com.IoTBay.model.dao;

import com.IoTBay.model.Shipment;
import org.junit.jupiter.api.*;

import java.sql.*;

import static org.junit.jupiter.api.Assertions.*;

class ShipmentDBManagerTest {

    private Connection connection;
    private ShipmentDBManager shipmentDB;

    @BeforeEach
    void setUp() throws SQLException {
        connection = DriverManager.getConnection("jdbc:sqlite::memory:");
        Statement stmt = connection.createStatement();

        stmt.executeUpdate(
                "CREATE TABLE Shipments (" +
                        "shipmentId INTEGER PRIMARY KEY AUTOINCREMENT, " +
                        "orderId INTEGER NOT NULL, " +
                        "address TEXT NOT NULL, " +
                        "shippingMethod TEXT NOT NULL, " +
                        "shippingDate TEXT NOT NULL" +
                        ")"
        );


        shipmentDB = new ShipmentDBManager(connection);
    }

    @Test
    void testAddShipment() throws SQLException {
        Shipment shipment = new Shipment(
                123,                                   // orderId
                "1 UTS ST, Sydney, NSW",               // address
                "Express",                             // shippingMethod
                "2025-06-01"                           // shippingDate
        );

        Shipment saved = shipmentDB.add(shipment);

        assertTrue(saved.getShipmentId() > 0, "Shipment ID should be generated");
        assertEquals(123, saved.getOrderId());
        assertEquals("1 UTS ST, Sydney, NSW", saved.getAddress());
        assertEquals("Express", saved.getShippingMethod());
        assertEquals("2025-06-01", saved.getShippingDate());

        // Verify stored record
        PreparedStatement ps = connection.prepareStatement("SELECT * FROM Shipments WHERE shipmentId = ?");
        ps.setInt(1, saved.getShipmentId());
        ResultSet rs = ps.executeQuery();

        assertTrue(rs.next());
        assertEquals(123, rs.getInt("orderId"));
        assertEquals("1 UTS ST, Sydney, NSW", rs.getString("address"));
        assertEquals("Express", rs.getString("shippingMethod"));
        assertEquals("2025-06-01", rs.getString("shippingDate"));
    }

    @AfterEach
    void tearDown() throws SQLException {
        connection.close();
    }
}
