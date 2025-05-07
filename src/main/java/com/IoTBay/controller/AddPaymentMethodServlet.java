package com.IoTBay.controller;

import com.IoTBay.model.PaymentMethod;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AddPaymentMethodServlet")
public class AddPaymentMethodServlet extends HttpServlet {

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

        String methodType = request.getParameter("method");
        String cardNumber = request.getParameter("cardNumber");
        String nameOnCard = request.getParameter("nameOnCard");
        String expiry = request.getParameter("expiry");
        String cvv = request.getParameter("cvv");

        try {
            PaymentMethod newMethod = new PaymentMethod(
                    0,
                    user.getId(),
                    methodType,
                    cardNumber,
                    nameOnCard,
                    expiry,
                    cvv
            );

            dao.PaymentMethods().add(newMethod);
            response.sendRedirect("AccountPages/SelectPaymentMethodToEdit.jsp");

        } catch (SQLException e) {
            throw new ServletException("Failed to add new payment method", e);
        }
    }
}
