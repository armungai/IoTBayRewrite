package com.IoTBay.controller;

import com.IoTBay.model.User;
import com.IoTBay.model.Order;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Comparator;
import java.util.List;
import java.util.Collections;


@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");
        if (dao == null || user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String searchIdStr = request.getParameter("orderId");
        String sort = request.getParameter("sort");

        try {
            // 1️⃣ If they searched by ID, fetch exactly that one
            if (searchIdStr != null && !searchIdStr.isEmpty()) {
                int searchId = Integer.parseInt(searchIdStr);
                Order o = dao.Orders().get(searchId);
                if (o == null || o.getUserId() != user.getId()) {
                    // not found or not theirs → pop up a “not found” page
                    response.sendRedirect("AccountPages/orderNotFound.jsp?orderId=" + searchId);
                    return;
                }
                // found it → send a single‐item list to the JSP
                request.setAttribute("orders", Collections.singletonList(o));
                request.getRequestDispatcher("AccountPages/viewAllOrders.jsp")
                        .forward(request, response);
                return;
            }

            // 2️⃣ Otherwise load their whole history
            List<Order> orders = dao.Orders().getOrdersByUserId(user.getId());

            // 3️⃣ Sort in all four directions
            if ("date-desc".equals(sort)) {
                // Date: newest → oldest
                orders.sort(Comparator.comparing(Order::getOrderDate).reversed());
            } else if ("date-asc".equals(sort)) {
                // Date: oldest → newest
                orders.sort(Comparator.comparing(Order::getOrderDate));
            } else if ("id-desc".equals(sort)) {
                // Order ID: highest → lowest
                orders.sort(Comparator.comparingInt(Order::getOrderId).reversed());
            } else if ("id-asc".equals(sort)) {
                // Order ID: lowest → highest
                orders.sort(Comparator.comparingInt(Order::getOrderId));
            }

            // 4️⃣ Forward to the JSP
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("AccountPages/viewAllOrders.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Failed to retrieve order history", e);
        }
    }

}
