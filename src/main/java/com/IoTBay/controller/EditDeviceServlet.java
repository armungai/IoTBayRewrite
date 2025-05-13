package com.IoTBay.controller;

import com.IoTBay.model.Product;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/EditDeviceServlet")
public class EditDeviceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null || !user.getAdmin()) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            float price = Float.parseFloat(request.getParameter("price"));

            Product oldProduct = dao.Products().getById(id); // fetch original
            Product updatedProduct = new Product(id, name, price, description, image);

            dao.Products().updateProduct(oldProduct, updatedProduct);

            response.sendRedirect("manageDevices.jsp?edited=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageDevices.jsp?error=EditFailed");
        }
    }
}
