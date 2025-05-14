//package com.IoTBay.controller;
//
//import com.IoTBay.model.*;
//import com.IoTBay.model.dao.*;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//import java.io.IOException;
//import java.sql.SQLException;
//
//@WebServlet("/AddToCartServlet")
//public class AddToCartServlet extends HttpServlet {
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        DAO dao = (DAO) session.getAttribute("db");
//
//        if (dao == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        int productId = Integer.parseInt(request.getParameter("productId"));
//        int quantity = Integer.parseInt(request.getParameter("quantity"));
//
//        try {
//            Product product = dao.Products().getById(productId);
//            if (product == null) {
//                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found.");
//                return;
//            }
//
//            Cart cart = (Cart) session.getAttribute("cart");
//            if (cart == null) {
//                cart = new Cart();
//                session.setAttribute("cart", cart);
//            }
//
//            cart.addProduct(product, quantity);
//
//            response.sendRedirect("cart.jsp");
//
//        } catch (SQLException e) {
//            throw new ServletException("DB error while adding to cart", e);
//        }
//    }
//}
// src/main/java/com/IoTBay/controller/AddToCartServlet.java
package com.IoTBay.controller;

import com.IoTBay.model.Cart;
import com.IoTBay.model.Product;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // either redirect or send method-not-allowed
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET not supported");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = (DAO) request.getSession().getAttribute("db");
        if (dao == null) {
            response.sendRedirect("login.jsp");  // no DB = not logged in
            return;
        }

        // guard against missing params
        String pid  = request.getParameter("productId");
        String qty  = request.getParameter("quantity");
        if (pid == null || qty == null) {
            // bad request
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing productId or quantity");
            return;
        }

        try {
            int productId = Integer.parseInt(pid);
            int quantity  = Integer.parseInt(qty);

            Product product = dao.Products().getById(productId);
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found.");
                return;
            }

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            cart.addProduct(product, quantity);

            response.sendRedirect("cart.jsp");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid productId or quantity");
        } catch (SQLException e) {
            throw new ServletException("Database error while adding to cart", e);
        }
    }
}



