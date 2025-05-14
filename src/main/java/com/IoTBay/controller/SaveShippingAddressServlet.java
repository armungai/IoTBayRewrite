package com.IoTBay.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SaveShippingAddressServlet")
public class SaveShippingAddressServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");

        String fullAddress = street + ", " + city + ", " + state;

        HttpSession session = request.getSession();
        session.setAttribute("tempShippingAddress", fullAddress);

        response.sendRedirect("cart.jsp");
    }
}