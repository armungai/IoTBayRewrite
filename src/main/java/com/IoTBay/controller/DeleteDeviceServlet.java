package com.IoTBay.controller;

import com.IoTBay.model.Product;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/DeleteDeviceServlet")
public class DeleteDeviceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null || !user.getAdmin()) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = new Product(id); // ✅ uses new constructor
            dao.Products().deleteProduct(product);
            response.sendRedirect("manageDevices.jsp?deleted=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageDevices.jsp?error=1");
        }
    }
}
