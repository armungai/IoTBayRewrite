package com.IoTBay.controller;

import com.IoTBay.model.OrderItem;
import com.IoTBay.model.dao.DAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/SubmitOrderServlet")
public class SubmitOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");

        // Get the orderId to submit
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try {
            // 1. Get all items from the order
            List<OrderItem> items = dao.Orders().getOrderItemsByOrderId(orderId);

            // 2. Deduct stock
            for (OrderItem item : items) {
                dao.Products().decreaseStock(item.getProductId(), item.getQuantity());
            }

            // 3. Update status
            dao.Orders().updateOrderStatus(orderId, "submitted");

            // 4. Redirect to confirmation
            response.sendRedirect("orderConfirmation.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to submit order.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }
}

