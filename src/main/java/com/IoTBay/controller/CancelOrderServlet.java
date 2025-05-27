package com.IoTBay.controller;

import com.IoTBay.model.Order;
import com.IoTBay.model.OrderItem;
import com.IoTBay.model.dao.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        if (dao == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        try {
            // 1) Load the order
            Order order = dao.Orders().get(orderId);
            String status = order.getStatus();
            if (status == null || status.isEmpty()) {
                status = "Pending";
            }

            // 2) Only allow cancelling if still Pending
            if (!"Pending".equalsIgnoreCase(status)) {
                // not allowed → back with an error hint
                resp.sendRedirect(req.getContextPath() + "/OrderHistoryServlet?error=notAllowed");
                return;
            }

            // 3) Restore stock for each item
            List<OrderItem> items = dao.Orders().getOrderItemsByOrderId(orderId);
            for (OrderItem item : items) {
                dao.Products().increaseStock(item.getProductId(), item.getQuantity());
            }

            // 4) Mark the order as Cancelled
            dao.Orders().updateOrderStatus(orderId, "Cancelled");

            // 5) Redirect back to history
            resp.sendRedirect(req.getContextPath() + "/OrderHistoryServlet");

        } catch (SQLException e) {
            throw new ServletException("Failed to cancel order #" + orderId, e);
        }
    }
}