package com.IoTBay.controller;

import com.IoTBay.model.OrderItem;
import com.IoTBay.model.dao.DAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try {
            // 1. Get order status
            String currentStatus = dao.Orders().get(orderId).getStatus();

            // Only cancel if it hasn't been submitted or cancelled yet
            if (!"saved".equalsIgnoreCase(currentStatus)) {
                response.sendRedirect("orderHistory.jsp?error=Cannot cancel this order.");
                return;
            }

            // 2. Get all items for this order
            List<OrderItem> items = dao.Orders().getOrderItemsByOrderId(orderId);

            // 3. Restore stock
            for (OrderItem item : items) {
                dao.Products().increaseStock(item.getProductId(), item.getQuantity());
            }

            // 4. Update order status
            dao.Orders().updateOrderStatus(orderId, "cancelled");

            // 5. Redirect
            response.sendRedirect("AccountPages/viewAllOrders.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to cancel order.");
            request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
        }
    }
}
