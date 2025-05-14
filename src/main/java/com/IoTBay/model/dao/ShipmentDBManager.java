package com.IoTBay.model.dao;

import com.IoTBay.model.Shipment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShipmentDBManager extends DBManager<Shipment> {

    public ShipmentDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    @Override
    public Shipment add(Shipment shipment) throws SQLException {
        String sql = "INSERT INTO Shipments (orderId, address, shippingMethod, shippingDate) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, shipment.getOrderId());
        ps.setString(2, shipment.getAddress());
        ps.setString(3, shipment.getShippingMethod());
        ps.setString(4, shipment.getShippingDate());
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            shipment.setShipmentId(rs.getInt(1));
        }
        return shipment;
    }

    @Override
    public Shipment get(Shipment shipment) throws SQLException {
        String sql = "SELECT * FROM Shipments WHERE shipmentId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, shipment.getShipmentId());
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new Shipment(
                    rs.getInt("shipmentId"),
                    rs.getInt("orderId"),
                    rs.getString("address"),
                    rs.getString("shippingMethod"),
                    rs.getString("shippingDate")
            );
        }
        return null;
    }

    @Override
    public void update(Shipment oldShipment, Shipment newShipment) throws SQLException {
        String sql = "UPDATE Shipments SET address = ?, shippingMethod = ?, shippingDate = ? WHERE shipmentId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, newShipment.getAddress());
        ps.setString(2, newShipment.getShippingMethod());
        ps.setString(3, newShipment.getShippingDate());
        ps.setInt(4, oldShipment.getShipmentId());
        ps.executeUpdate();
    }

    @Override
    public void delete(Shipment shipment) throws SQLException {
        String sql = "DELETE FROM Shipments WHERE shipmentId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, shipment.getShipmentId());
        ps.executeUpdate();
    }

    public List<Shipment> getByOrderId(int orderId) throws SQLException {
        List<Shipment> list = new ArrayList<>();
        String sql = "SELECT * FROM Shipments WHERE orderId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(new Shipment(
                    rs.getInt("shipmentId"),
                    rs.getInt("orderId"),
                    rs.getString("address"),
                    rs.getString("shippingMethod"),
                    rs.getString("shippingDate")
            ));
        }

        return list;
    }

    public List<Shipment> getByUserId(int userId) throws SQLException {
        List<Shipment> list = new ArrayList<>();
        String sql = "SELECT s.* FROM Shipments s " +
                "JOIN Orders o ON s.orderId = o.orderId " +
                "WHERE o.userId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(new Shipment(
                    rs.getInt("shipmentId"),
                    rs.getInt("orderId"),
                    rs.getString("address"),
                    rs.getString("shippingMethod"),
                    rs.getString("shippingDate")
            ));
        }

        return list;
    }

    public Shipment getByIdAndUserId(int shipmentId, int userId) throws SQLException {
        String sql = "SELECT s.* FROM Shipments s " +
                "JOIN Orders o ON s.orderId = o.orderId " +
                "WHERE s.shipmentId = ? AND o.userId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, shipmentId);
        ps.setInt(2, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new Shipment(
                    rs.getInt("shipmentId"),
                    rs.getInt("orderId"),
                    rs.getString("address"),
                    rs.getString("shippingMethod"),
                    rs.getString("shippingDate")
            );
        }
        return null;
    }

    public List<Shipment> getByDateRange(int userId, String startDate, String endDate) throws SQLException {
        List<Shipment> list = new ArrayList<>();
        String sql = "SELECT s.* FROM Shipments s " +
                "JOIN Orders o ON s.orderId = o.orderId " +
                "WHERE o.userId = ? AND s.shippingDate BETWEEN ? AND ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setString(2, startDate);
        ps.setString(3, endDate);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(new Shipment(
                    rs.getInt("shipmentId"),
                    rs.getInt("orderId"),
                    rs.getString("address"),
                    rs.getString("shippingMethod"),
                    rs.getString("shippingDate")
            ));
        }

        return list;
    }
}
