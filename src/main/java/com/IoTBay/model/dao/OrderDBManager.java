package com.IoTBay.model.dao;

import com.IoTBay.model.Order;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDBManager extends DBManager<Order> {

    public OrderDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    @Override
    public Order add(Order order) throws SQLException {
        String sql = "INSERT INTO Orders (userId, paymentId, orderDate) VALUES (?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, order.getUserId());
        ps.setInt(2, order.getPaymentId());
        ps.setString(3, order.getOrderDate().toString());
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            order = new Order(rs.getInt(1), order.getUserId(), order.getPaymentId(), order.getOrderDate());
        }
        return order;
    }

    @Override
    public Order get(Order o) throws SQLException {
        return get(o.getOrderId());
    }

    public Order get(int orderId) throws SQLException {
        String sql = "SELECT * FROM Orders WHERE orderId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new Order(
                    rs.getInt("orderId"),
                    rs.getInt("userId"),
                    rs.getInt("paymentId"),
                    LocalDateTime.parse(rs.getString("orderDate"))
            );
        }
        return null;
    }

    @Override
    public void update(Order oldO, Order newO) throws SQLException {
        String sql = "UPDATE Orders SET userId=?, paymentId=?, orderDate=? WHERE orderId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, newO.getUserId());
        ps.setInt(2, newO.getPaymentId());
        ps.setString(3, newO.getOrderDate().toString());
        ps.setInt(4, oldO.getOrderId());
        ps.executeUpdate();
    }

    @Override
    public void delete(Order order) throws SQLException {
        String sql = "DELETE FROM Orders WHERE orderId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, order.getOrderId());
        ps.executeUpdate();
    }

    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE userId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            orders.add(new Order(
                    rs.getInt("orderId"),
                    rs.getInt("userId"),
                    rs.getInt("paymentId"),
                    LocalDateTime.parse(rs.getString("orderDate"))
            ));
        }

        return orders;
    }
}
