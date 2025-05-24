//package com.IoTBay.model.dao;
//
//import com.IoTBay.model.Order;
//
//import java.sql.*;
//import java.time.LocalDateTime;
//import java.util.ArrayList;
//import java.util.List;
//
//public class OrderDBManager extends DBManager<Order> {
//
//    public OrderDBManager(Connection conn) throws SQLException {
//        super(conn);
//    }
//
//    @Override
//    public Order add(Order order) throws SQLException {
//        String sql = "INSERT INTO Orders (userId, paymentId, orderDate) VALUES (?, ?, ?)";
//        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
//        ps.setInt(1, order.getUserId());
//        ps.setInt(2, order.getPaymentId());
//        ps.setString(3, order.getOrderDate().toString());
//        ps.executeUpdate();
//
//        ResultSet rs = ps.getGeneratedKeys();
//        if (rs.next()) {
//            order = new Order(rs.getInt(1), order.getUserId(), order.getPaymentId(), order.getOrderDate());
//        }
//        return order;
//    }
//
//    @Override
//    public Order get(Order o) throws SQLException {
//        return get(o.getOrderId());
//    }
//
//    public Order get(int orderId) throws SQLException {
//        String sql = "SELECT * FROM Orders WHERE orderId = ?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setInt(1, orderId);
//        ResultSet rs = ps.executeQuery();
//
//        if (rs.next()) {
//            return new Order(
//                    rs.getInt("orderId"),
//                    rs.getInt("userId"),
//                    rs.getInt("paymentId"),
//                    LocalDateTime.parse(rs.getString("orderDate"))
//            );
//        }
//        return null;
//    }
//
//    @Override
//    public void update(Order oldO, Order newO) throws SQLException {
//        String sql = "UPDATE Orders SET userId=?, paymentId=?, orderDate=? WHERE orderId=?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setInt(1, newO.getUserId());
//        ps.setInt(2, newO.getPaymentId());
//        ps.setString(3, newO.getOrderDate().toString());
//        ps.setInt(4, oldO.getOrderId());
//        ps.executeUpdate();
//    }
//
//    @Override
//    public void delete(Order order) throws SQLException {
//        String sql = "DELETE FROM Orders WHERE orderId=?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setInt(1, order.getOrderId());
//        ps.executeUpdate();
//    }
//
//    public List<Order> getOrdersByUserId(int userId) throws SQLException {
//        List<Order> orders = new ArrayList<>();
//        String sql = "SELECT * FROM Orders WHERE userId = ?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setInt(1, userId);
//        ResultSet rs = ps.executeQuery();
//
//        while (rs.next()) {
//            orders.add(new Order(
//                    rs.getInt("orderId"),
//                    rs.getInt("userId"),
//                    rs.getInt("paymentId"),
//                    LocalDateTime.parse(rs.getString("orderDate"))
//            ));
//        }
//
//        return orders;
//    }
//}

package com.IoTBay.model.dao;

import com.IoTBay.model.Order;
import com.IoTBay.model.OrderItem;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class OrderDBManager extends DBManager<Order> {
    private static final DateTimeFormatter FMT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public OrderDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    @Override
    public Order add(Order o) throws SQLException {
        String sql =
                "INSERT INTO Orders(userId,paymentId,orderDate,status) VALUES(?,?,?,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, o.getUserId());
            ps.setInt(2, o.getPaymentId());
            ps.setString(3, o.getOrderDate().format(FMT));
            ps.setString(4, o.getStatus());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) o.setOrderId(rs.getInt(1));
            }
        }
        return o;
    }

    @Override
    public Order get(Order template) throws SQLException {
        return get(template.getOrderId());
    }

    public Order get(int id) throws SQLException {
        String sql = "SELECT * FROM Orders WHERE orderId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                LocalDateTime dt = LocalDateTime.parse(rs.getString("orderDate"), FMT);
                Order ord = new Order(
                        rs.getInt("orderId"),
                        rs.getInt("userId"),
                        rs.getInt("paymentId"),
                        dt,
                        rs.getString("status")
                );
                return ord;
            }
        }
    }

    @Override
    public void update(Order oldO, Order newO) throws SQLException {
        String sql =
                "UPDATE Orders SET userId=?, paymentId=?, orderDate=?, status=? WHERE orderId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newO.getUserId());
            ps.setInt(2, newO.getPaymentId());
            ps.setString(3, newO.getOrderDate().format(FMT));
            ps.setString(4, newO.getStatus());
            ps.setInt(5, oldO.getOrderId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(Order o) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(
                "DELETE FROM Orders WHERE orderId=?")) {
            ps.setInt(1, o.getOrderId());
            ps.executeUpdate();
        }
    }

    public List<Order> getOrdersByUserId(int uid) throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE userId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, uid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LocalDateTime dt = LocalDateTime.parse(rs.getString("orderDate"), FMT);
                    Order ord = new Order(
                            rs.getInt("orderId"),
                            rs.getInt("userId"),
                            rs.getInt("paymentId"),
                            dt,
                            rs.getString("status")
                    );
                    list.add(ord);
                }
            }
        }
        return list;
    }

    public void updateOrderStatus(int oid, String st) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(
                "UPDATE Orders SET status=? WHERE orderId=?")) {
            ps.setString(1, st);
            ps.setInt(2, oid);
            ps.executeUpdate();
        }
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        String sql =
                "SELECT oi.itemId, oi.orderId, oi.productId, p.productName, p.price, oi.quantity " +
                        "FROM OrderItems oi " +
                        "JOIN products p ON oi.productId = p.productID " +
                        "WHERE oi.orderId=?";
        List<OrderItem> items = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(new OrderItem(
                            rs.getInt("itemId"),
                            rs.getInt("orderId"),
                            rs.getInt("productId"),
                            rs.getString("productName"),
                            rs.getFloat("price"),
                            rs.getInt("quantity")
                    ));
                }
            }
        }
        return items;
    }
}

