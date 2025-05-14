package com.IoTBay.model.dao;

import com.IoTBay.model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for the Payment entity.
 * Provides methods to create, read, update, delete, and query Payment records in the database.
 */
public class PaymentDBManager extends DBManager<Payment> {

    // Constructor that passes the DB connection to the parent class
    public PaymentDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    /**
     * Adds a new Payment to the database with a kinda-random 8-digit unique paymentId.
     * @param payment the Payment object to be added
     * @return the Payment object with its paymentId set
     */
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

    /**
     * Retrieves a Payment from the database using its ID.
     * @param payment the Payment object with a valid paymentId
     * @return the complete Payment record from the database, or null if not found
     */
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

    /**
     * Updates an existing Payment in the database.
     * @param oldPayment the existing Payment to be updated (used to locate the record)
     * @param newPayment the new data to be applied
     */
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

    /**
     * Deletes a Payment record from the database.
     * @param payment the Payment object with a valid paymentId
     */
    @Override
    public void delete(Payment payment) throws SQLException {
        String sql = "DELETE FROM Payments WHERE paymentId = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, payment.getPaymentId());
        ps.executeUpdate();
    }

    /**
     * Retrieves all payments made by a specific user.
     * @param userId the ID of the user
     * @return a list of Payments made by the user
     */
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


    /**
     * Retrieves a Payment by its paymentId.
     * @param paymentId the ID of the payment
     * @return the Payment object or null if not found
     */
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

    /**
     * Retrieves a Payment by both its paymentId and userId (for security/ownership check).
     * @param paymentId the payment ID
     * @param userId the user ID who made the payment
     * @return the matching Payment or null if not found
     */
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

    /**
     * Retrieves all payments in the database.
     * @return a list of all Payments
     * @throws SQLException if a database access error occurs
     */
    public List<Payment> getAllPayments() throws SQLException {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payments";
        PreparedStatement ps = connection.prepareStatement(sql);
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


}
