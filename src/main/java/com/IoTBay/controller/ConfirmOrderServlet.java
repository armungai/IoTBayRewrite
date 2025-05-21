package com.IoTBay.controller;

import com.IoTBay.model.*;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
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
            PaymentMethod method = dao.PaymentMethods().get(methodId);

            if (method == null || method.getUserId() != user.getId()) {
                response.sendRedirect("cart.jsp?error=invalidMethod");
                return;
            }

            // this is where we set the selected payment attribute
            session.setAttribute("selectedPaymentMethod", method);

            String shippingAddress = request.getParameter("address");
            String shippingMethod = request.getParameter("shippingMethod");
            String shippingDate = request.getParameter("shippingDate");

            session.setAttribute("selectedShippingAddress", shippingAddress);
            session.setAttribute("selectedShippingMethod", shippingMethod);
            session.setAttribute("selectedShippingDate", shippingDate);

            response.sendRedirect("checkout.jsp");

        } catch (NumberFormatException | SQLException e) {
            response.sendRedirect("cart.jsp?error=invalidInput");
        }
    }
}
