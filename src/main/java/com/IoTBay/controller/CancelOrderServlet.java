package com.IoTBay.controller;

import com.IoTBay.model.dao.DAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        int oid = Integer.parseInt(req.getParameter("orderId"));
        try {
            dao.Orders().updateOrderStatus(oid, "cancelled");
            resp.sendRedirect("AccountPages/viewAllOrders.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
