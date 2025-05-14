//package com.IoTBay.controller;
//
//import com.IoTBay.model.Product;
//import com.IoTBay.model.User;
//import com.IoTBay.model.dao.DAO;
//
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.*;
//import java.io.IOException;
//import java.sql.SQLException;
//
//@WebServlet("/EditDeviceServlet")
//public class EditDeviceServlet extends HttpServlet {
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        HttpSession session = request.getSession();
//        DAO dao = (DAO) session.getAttribute("db");
//        User user = (User) session.getAttribute("loggedInUser");
//
//        if (user == null || !user.getAdmin()) {
//            response.sendRedirect("unauthorized.jsp");
//            return;
//        }
//
//        try {
//            int id = Integer.parseInt(request.getParameter("id"));
//            String name = request.getParameter("name");
//            String description = request.getParameter("description");
//            String image = request.getParameter("image");
//            float price = Float.parseFloat(request.getParameter("price"));
//
//            Product oldProduct = dao.Products().getById(id); // fetch original
//            Product updatedProduct = new Product(id, name, price, description, image);
//
//            dao.Products().updateProduct(oldProduct, updatedProduct);
//
//            response.sendRedirect("manageDevices.jsp?edited=1");
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("manageDevices.jsp?error=EditFailed");
//        }
//    }
//}

// src/main/java/com/IoTBay/controller/EditDeviceServlet.java
package com.IoTBay.controller;

import com.IoTBay.model.Product;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/EditDeviceServlet")
public class EditDeviceServlet extends HttpServlet {

    // 1) Show the "edit" form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAO dao       = (DAO) session.getAttribute("db");
        User user     = (User) session.getAttribute("loggedInUser");

        // only admins may edit
        if (dao == null || user == null || !user.getAdmin()) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product p     = dao.Products().getById(productId);
            if (p == null) {
                response.sendRedirect("manageDevices.jsp?error=NoSuchProduct");
                return;
            }
            // stash it and go to the JSP
            session.setAttribute("productToEdit", p);
            response.sendRedirect("editDevice.jsp");

        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error loading product for edit", e);
        }
    }

    // 2) Handle the form submit
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAO dao       = (DAO) session.getAttribute("db");
        User user     = (User) session.getAttribute("loggedInUser");

        if (dao == null || user == null || !user.getAdmin()) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        try {
            int    id          = Integer.parseInt(request.getParameter("id"));
            String name        = request.getParameter("name");
            String description = request.getParameter("description");
            String image       = request.getParameter("image");
            float  price       = Float.parseFloat(request.getParameter("price"));

            // load original, create updated bean
            Product oldProduct     = dao.Products().getById(id);
            Product updatedProduct = new Product(id, name, price, description, image);

            // apply update
            dao.Products().update(oldProduct, updatedProduct);

            response.sendRedirect("manageDevices.jsp?edited=1");
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("manageDevices.jsp?error=EditFailed");
        }
    }
}

