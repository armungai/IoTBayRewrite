package com.IoTBay.controller;

import com.IoTBay.model.Product;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

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
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");

        if (dao == null || user == null || !user.getAdmin()) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            float price = Float.parseFloat(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Product oldProduct = dao.Products().getById(id); // may throw SQLException
            Product updatedProduct = new Product(id, name, price, description, image, stock);

            dao.Products().updateProduct(oldProduct, updatedProduct); // may throw SQLException

            response.sendRedirect("manageDevices.jsp?edited=1");

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("manageDevices.jsp?error=EditFailed");
        }
    }

}
