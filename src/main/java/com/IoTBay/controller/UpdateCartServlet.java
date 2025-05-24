package com.IoTBay.controller;

import com.IoTBay.model.Cart;
import com.IoTBay.model.CartItem;
import com.IoTBay.model.Product;
import com.IoTBay.model.dao.DAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        Cart cart = (Cart) session.getAttribute("cart");
        int pid = Integer.parseInt(req.getParameter("productId"));
        String action = req.getParameter("action");

        try {
            Product p = dao.Products().getById(pid);
            if (p == null || cart == null) {
                resp.sendRedirect("cart.jsp");
                return;
            }

            CartItem ci = cart.getItems().stream()
                    .filter(i -> i.getProduct().getProductID() == pid)
                    .findFirst()
                    .orElse(null);

            int curQty = (ci == null) ? 0 : ci.getQuantity();
            if ("plus".equals(action) && curQty < p.getStock()) {
                cart.updateQuantity(pid, curQty + 1);
            } else if ("minus".equals(action)) {
                cart.updateQuantity(pid, curQty - 1);
            }

            resp.sendRedirect("cart.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
