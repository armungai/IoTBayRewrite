package com.IoTBay.model.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class DAO {

    private final ArrayList<DBManager<?>> tables;
    private final Connection connection;
    private final UserDBManager userDBManager;
    private final PaymentDBManager paymentDBManager;
    private final PaymentMethodDBManager paymentMethodDBManager;
    private final ProductDBManager productDBManager;
    private final OrderDBManager orderDBManager;
    private final OrderItemDBManager orderItemDBManager;
    private final ShipmentDBManager shipmentDBManager;

    public DAO() throws SQLException {
        tables = new ArrayList<>();
        connection = new DBConnector().getConnection();

        try {
            userDBManager = new UserDBManager(connection);
            paymentDBManager = new PaymentDBManager(connection);
            paymentMethodDBManager = new PaymentMethodDBManager(connection);
            productDBManager = new ProductDBManager(connection);
            orderDBManager = new OrderDBManager(connection);
            orderItemDBManager = new OrderItemDBManager(connection);
            shipmentDBManager = new ShipmentDBManager(connection);

            tables.add(userDBManager);
            tables.add(paymentDBManager);
            tables.add(paymentMethodDBManager);
            tables.add(orderDBManager);
            tables.add(orderItemDBManager);
            tables.add(shipmentDBManager);
        } catch (SQLException e) {
            throw new SQLException("Error initializing DBManagers", e);
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public UserDBManager Users() {
        return userDBManager;
    }

    public PaymentDBManager Payments() {
        return paymentDBManager;
    }

    public PaymentMethodDBManager PaymentMethods() {
        return paymentMethodDBManager;
    }

    public ProductDBManager Products() {
        return productDBManager;
    }

    public OrderDBManager Orders() {
        return orderDBManager;
    }

    public OrderItemDBManager OrderItems() {
        return orderItemDBManager;
    }

    public ShipmentDBManager Shipments() {

        return shipmentDBManager;
    }
}