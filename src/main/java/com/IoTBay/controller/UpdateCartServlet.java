package com.IoTBay.controller;

import com.IoTBay.model.*;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        Cart cart = (Cart) session.getAttribute("cart");

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        try {
            Product product = dao.Products().getById(productId);
            if (product == null || cart == null) {
                response.sendRedirect("cart.jsp");
                return;
            }

            CartItem item = cart.getItem(productId);
            if (item == null) {
                response.sendRedirect("cart.jsp");
                return;
            }

            int currentQty = item.getQuantity();

            if ("plus".equals(action)) {
                // never exceed available stock
                int max = product.getStock();
                int newQty = Math.min(currentQty + 1, max);
                cart.updateQuantity(productId, newQty);
            } else if ("minus".equals(action)) {
                if (currentQty <= 1) {
                    cart.removeProduct(productId);
                } else {
                    cart.updateQuantity(productId, currentQty - 1);
                }
            }

            response.sendRedirect("cart.jsp");

        } catch (SQLException | NumberFormatException e) {
            throw new ServletException("Error updating cart", e);
        }
    }
}