package com.IoTBay.controller;

import com.IoTBay.model.Payment;
import com.IoTBay.model.User;
import com.IoTBay.model.PaymentMethod;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet that handles deletion of a payment record.
 * Accessible via both GET and POST requests.
 * Ensures the logged-in user owns the payment before deletion.
 */
@WebServlet("/DeletePaymentServlet")
public class DeletePaymentServlet extends HttpServlet {

    // Handle POST requests (e.g., form submissions)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleDelete(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleDelete(request, response);  // Also allow GET for link-based deletion
    }

    /**
     * Centralized method to handle payment deletion logic.
     * Checks for session validity, user ownership, and performs secure deletion.
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        // Retrieve session and required attributes
        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");               // DAO for database access
        User user = (User) session.getAttribute("loggedInUser");  // Logged-in user

        // Redirect to login page if not logged in or database unavailable
        if (dao == null || user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Parse the payment ID from the request
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));

            // Fetch payment from the database
            Payment payment = dao.Payments().getPaymentById(paymentId);

            // If no such payment exists, send 404
            if (payment == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Payment not found.");
                return;
            }

            // Prevent users from deleting payments that aren't theirs
            if (payment.getUserId() != user.getId() && !user.getAdmin()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not authorized to delete this payment.");
                return;
            }

            // Perform deletion
            dao.Payments().delete(payment);
            System.out.println("Deleting payment #" + payment.getPaymentId() + "; For user: " + user.getId());

            // Redirect to the user's payment history page
            response.sendRedirect("AccountPages/paymentHistory.jsp");

        } catch (NumberFormatException e) {
            // Handle bad or missing payment ID
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid payment ID.");
        } catch (SQLException e) {
            // Handle database issues
            throw new ServletException("Database error during deletion", e);
        }
    }
}
