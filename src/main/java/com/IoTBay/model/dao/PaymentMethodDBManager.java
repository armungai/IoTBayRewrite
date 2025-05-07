package com.IoTBay.model.dao;

import com.IoTBay.model.PaymentMethod;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class PaymentMethodDBManager extends DBManager<PaymentMethod> {
    public PaymentMethodDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    @Override
    public PaymentMethod add(PaymentMethod method) throws SQLException {
        String sql = "INSERT INTO PaymentMethods (userId, type, cardNumber, nameOnCard, expiry, cvv) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, method.getUserId());
        ps.setString(2, method.getType());
        ps.setString(3, method.getCardNumber());
        ps.setString(4, method.getNameOnCard());
        ps.setString(5, method.getExpiry());
        ps.setString(6, method.getCvv());
        ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) method.setMethodId(rs.getInt(1));
        return method;
    }

    @Override
    public PaymentMethod get(PaymentMethod m) throws SQLException {
        String sql = "SELECT * FROM PaymentMethods WHERE methodId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, m.getMethodId());
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new PaymentMethod(
                    rs.getInt("methodId"),
                    rs.getInt("userId"),
                    rs.getString("type"),
                    rs.getString("cardNumber"),
                    rs.getString("nameOnCard"),
                    rs.getString("expiry"),
                    rs.getString("cvv")
            );
        }
        return null;
    }

    @Override
    public void update(PaymentMethod oldM, PaymentMethod newM) throws SQLException {
        String sql = "UPDATE PaymentMethods SET type=?, cardNumber=?, nameOnCard=?, expiry=?, cvv=? WHERE methodId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, newM.getType());
        ps.setString(2, newM.getCardNumber());
        ps.setString(3, newM.getNameOnCard());
        ps.setString(4, newM.getExpiry());
        ps.setString(5, newM.getCvv());
        ps.setInt(6, oldM.getMethodId());
        ps.executeUpdate();
    }

    @Override
    public void delete(PaymentMethod method) throws SQLException {
        String sql = "DELETE FROM PaymentMethods WHERE methodId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, method.getMethodId());
        ps.executeUpdate();
    }

    public List<PaymentMethod> getMethodsByUserId(int userId) throws SQLException {
        List<PaymentMethod> methods = new ArrayList<>();
        String sql = "SELECT * FROM PaymentMethods WHERE userId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            methods.add(new PaymentMethod(
                    rs.getInt("methodId"),
                    rs.getInt("userId"),
                    rs.getString("type"),
                    rs.getString("cardNumber"),
                    rs.getString("nameOnCard"),
                    rs.getString("expiry"),
                    rs.getString("cvv")
            ));
        }

        return methods;
    }

    public PaymentMethod get(int methodId) throws SQLException {
        String sql = "SELECT * FROM PaymentMethods WHERE methodId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, methodId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new PaymentMethod(
                    rs.getInt("methodId"),
                    rs.getInt("userId"),
                    rs.getString("type"),
                    rs.getString("cardNumber"),
                    rs.getString("nameOnCard"),
                    rs.getString("expiry"),
                    rs.getString("cvv")
            );
        }

        return null;
    }
}