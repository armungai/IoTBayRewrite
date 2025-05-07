package com.IoTBay.controller;

import com.IoTBay.model.PaymentMethod;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/EditPaymentServlet")
public class EditPaymentMethodServlet extends HttpServlet {
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

            PaymentMethod existing = dao.PaymentMethods().get(methodId);

            if (existing == null || existing.getUserId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized access.");
                return;
            }

            String type = request.getParameter("method");
            String cardNumber = request.getParameter("cardNumber");
            String nameOnCard = request.getParameter("nameOnCard");
            String expiry = request.getParameter("expiry");
            String cvv = request.getParameter("cvv");

            PaymentMethod updated = new PaymentMethod(
                    methodId,
                    user.getId(),
                    type,
                    cardNumber,
                    nameOnCard,
                    expiry,
                    cvv
            );

            dao.PaymentMethods().update(existing, updated);
            response.sendRedirect("AccountPages/SelectPaymentMethodToEdit.jsp");

        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error updating payment method", e);
        }
    }
}
