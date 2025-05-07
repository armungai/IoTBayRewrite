package com.IoTBay.model.dao;

import com.IoTBay.model.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDBManager extends DBManager<OrderItem> {
    public OrderItemDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    @Override
    public OrderItem add(OrderItem item) throws SQLException {
        String sql = "INSERT INTO OrderItems (orderId, productId, quantity) VALUES (?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, item.getOrderId());
        ps.setInt(2, item.getProductId());
        ps.setInt(3, item.getQuantity());
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            item.setId(rs.getInt(1));
        }
        return item;
    }

    @Override
    public OrderItem get(OrderItem item) throws SQLException {
        return get(item.getId());
    }

    public OrderItem get(int itemId) throws SQLException {
        String sql = "SELECT * FROM OrderItems WHERE itemId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, itemId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new OrderItem(
                    rs.getInt("itemId"),
                    rs.getInt("orderId"),
                    rs.getInt("productId"),
                    null, // productName is not stored
                    0,    // price is not stored
                    rs.getInt("quantity")
            );
        }
        return null;
    }

    @Override
    public void update(OrderItem oldItem, OrderItem newItem) throws SQLException {
        String sql = "UPDATE OrderItems SET orderId=?, productId=?, quantity=? WHERE itemId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, newItem.getOrderId());
        ps.setInt(2, newItem.getProductId());
        ps.setInt(3, newItem.getQuantity());
        ps.setInt(4, oldItem.getId());
        ps.executeUpdate();
    }

    @Override
    public void delete(OrderItem item) throws SQLException {
        String sql = "DELETE FROM OrderItems WHERE itemId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, item.getId());
        ps.executeUpdate();
    }

    public List<OrderItem> getItemsByOrderId(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM OrderItems WHERE orderId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            items.add(new OrderItem(
                    rs.getInt("itemId"),
                    rs.getInt("orderId"),
                    rs.getInt("productId"),
                    null, // productName not stored
                    0,    // price not stored
                    rs.getInt("quantity")
            ));
        }

        return items;
    }
}