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


@WebServlet("/DeletePaymentServlet")
public class DeletePaymentServlet extends HttpServlet {
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

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");

        if (dao == null || user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));

            Payment payment = dao.Payments().getPaymentById(paymentId);
            if (payment == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Payment not found.");
                return;
            }

            if (payment.getUserId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not authorized to delete this payment.");
                return;
            }

            dao.Payments().delete(payment);
            System.out.println("Deleting payment #" + payment.getPaymentId() + "; For user: " + user.getId());
            response.sendRedirect("AccountPages/paymentHistory.jsp");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid payment ID.");
        } catch (SQLException e) {
            throw new ServletException("Database error during deletion", e);
        }

    }
}
