package com.IoTBay.model.dao;

import com.IoTBay.model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class PaymentDBManager extends DBManager<Payment> {

    public PaymentDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    @Override
    public Payment add(Payment payment) throws SQLException {
        String sql = "INSERT INTO Payments (userId, methodId, amount, date, status) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, payment.getUserId());
        ps.setInt(2, payment.getMethodId());
        ps.setDouble(3, payment.getAmount());
        ps.setString(4, payment.getDate());
        ps.setString(5, payment.getStatus());
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            payment.setPaymentId(rs.getInt(1));
        }

        return payment;
    }

    @Override
    public Payment get(Payment payment) throws SQLException {
        String sql = "SELECT * FROM Payments WHERE paymentId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, payment.getPaymentId());
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new Payment(
                    rs.getInt("paymentId"),
                    rs.getInt("userId"),
                    rs.getInt("methodId"),
                    rs.getDouble("amount"),
                    rs.getString("date"),
                    rs.getString("status")
            );
        } else {
            return null;
        }
    }

    @Override
    public void update(Payment oldPayment, Payment newPayment) throws SQLException {
        String sql = "UPDATE Payments SET methodId = ?, amount = ?, date = ?, status = ? WHERE paymentId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, newPayment.getMethodId());
        ps.setDouble(2, newPayment.getAmount());
        ps.setString(3, newPayment.getDate());
        ps.setString(4, newPayment.getStatus());
        ps.setInt(5, oldPayment.getPaymentId());
        ps.executeUpdate();
    }

    @Override
    public void delete(Payment payment) throws SQLException {
        String sql = "DELETE FROM Payments WHERE paymentId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, payment.getPaymentId());
        ps.executeUpdate();
    }

    public List<Payment> getPaymentsByUserId(int userId) throws SQLException {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payments WHERE userId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            payments.add(new Payment(
                    rs.getInt("paymentId"),
                    rs.getInt("userId"),
                    rs.getInt("methodId"),
                    rs.getDouble("amount"),
                    rs.getString("date"),
                    rs.getString("status")
            ));
        }

        return payments;
    }

    public Payment getPaymentById(int paymentId) throws SQLException {
        String sql = "SELECT * FROM Payments WHERE paymentId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, paymentId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new Payment(
                    rs.getInt("paymentId"),
                    rs.getInt("userId"),
                    rs.getInt("methodId"),
                    rs.getDouble("amount"),
                    rs.getString("date"),
                    rs.getString("status")
            );
        } else {
            return null;
        }
    }

    public Payment getPaymentByIdAndUserId(int paymentId, int userId) throws SQLException {
        String query = "SELECT * FROM Payments WHERE paymentId = ? AND userId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, paymentId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Payment(
                        rs.getInt("paymentId"),
                        rs.getInt("userId"),
                        rs.getInt("methodId"),
                        rs.getDouble("amount"),
                        rs.getString("date"),
                        rs.getString("status")
                );
            }
        }
        return null;
    }

}
