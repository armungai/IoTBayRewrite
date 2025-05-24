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
//@WebServlet("/AddDeviceServlet")
//public class AddDeviceServlet extends HttpServlet {
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
//        String name = request.getParameter("name");
//        String description = request.getParameter("description");
//        String image = request.getParameter("image");
//        double price;
//
//        try {
//            price = Double.parseDouble(request.getParameter("price"));
//        } catch (NumberFormatException e) {
//            response.sendRedirect("addDevice.jsp?error=1");
//            return;
//        }
//
//        Product product = new Product(name, (float) price, description, image);
//
//        try {
//            dao.Products().addProduct(product);
//            response.sendRedirect("manageDevices.jsp?success=1");
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.sendRedirect("addDevice.jsp?error=1");
//        }
//    }
//}

package com.IoTBay.controller;

import com.IoTBay.model.Product;
import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AddDeviceServlet")
public class AddDeviceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");

        if (dao == null || user == null || !user.getAdmin()) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        String name        = request.getParameter("name");
        String description = request.getParameter("description");
        String image       = request.getParameter("image");
        float  price;
        int    stock;

        try {
            price = Float.parseFloat(request.getParameter("price"));
            stock = Integer.parseInt(request.getParameter("stock"));
        } catch (NumberFormatException e) {
            response.sendRedirect("addDevice.jsp?error=badInput");
            return;
        }

        // CALL the 5-ARG ctor: (name,price,description,image,stock)
        Product product = new Product(name, price, description, image, stock);
        product.setStock(stock);

        try {
            dao.Products().addProduct(product);
            response.sendRedirect("manageDevices.jsp?success=1");
        } catch (SQLException e) {
            throw new ServletException("Could not add device", e);
        }
    }
}

