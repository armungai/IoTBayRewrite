package com.IoTBay.controller;

import com.IoTBay.model.Order;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");
        if (dao == null || user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Order> all = dao.Orders().getOrdersByUserId(user.getId());
            String sid = req.getParameter("orderId"),
                    sort = req.getParameter("sort");

            if (sid != null && !sid.isEmpty()) {
                int filterId = Integer.parseInt(sid);
                all.removeIf(o -> o.getOrderId() != filterId);
            }

            if ("dateAsc".equals(sort)) {
                all.sort(Comparator.comparing(Order::getOrderDate));
            } else if ("dateDesc".equals(sort)) {
                all.sort(Comparator.comparing(Order::getOrderDate).reversed());
            }

            req.setAttribute("orders", all);
            req.getRequestDispatcher("/AccountPages/viewAllOrders.jsp")
                    .forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
