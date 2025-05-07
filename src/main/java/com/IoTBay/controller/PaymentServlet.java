package com.IoTBay.controller;

import com.IoTBay.model.Payment;
import com.IoTBay.model.PaymentMethod;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");

        if (dao == null || user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int methodId = Integer.parseInt(request.getParameter("methodId"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String status = "Pending";
            String date = LocalDate.now().toString();

            PaymentMethod method = dao.PaymentMethods().get(new PaymentMethod(methodId, user.getId(), null, null, null, null, null));
            if (method == null || method.getUserId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid or unauthorized payment method.");
                return;
            }

            Payment payment = new Payment(user.getId(), methodId, amount, date, status);
            dao.Payments().add(payment);

            response.sendRedirect("viewPayments.jsp");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format.");
        } catch (SQLException e) {
            throw new ServletException("Database error when processing payment", e);
        }
    }
}
