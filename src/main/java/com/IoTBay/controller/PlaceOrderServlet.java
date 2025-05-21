package com.IoTBay.controller;

import com.IoTBay.model.*;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 * Implemented by Andrew
 *
 * This is a servlet that handles the placement of an order; performing the following:
 * - Validate session data (user, cart, payment method)
 * - Creates a Payment record (main functionality)
 * - Adds each cart item as an OrderItem
 * - Clears the cart and redirects to confirmation
 * -
 */


@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve session and objects needed to place the order
        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db"); // DAO object used to interact with the database
        User user = (User) session.getAttribute("loggedInUser"); // Get the logged-in user
        Cart cart = (Cart) session.getAttribute("cart"); // Get the current session shopping cart
        PaymentMethod method = (PaymentMethod) session.getAttribute("selectedPaymentMethod"); // Gets the selected payment method

        // Quick validation of all session attributes
        if (dao == null || user == null || cart == null || method == null || cart.isEmpty()) {
            // Send user back if somehow something was missing
            response.sendRedirect("cart.jsp?error=missingData");
            return;
        }


        try {
           // 1. Create and store a Payment object
            Payment payment = new Payment(
                    0, // can just be zero because we will set it in the DAO
                    user.getId(),
                    method.getMethodId(),
                    cart.getTotalPrice(),
                    LocalDateTime.now().toString(), // store a timestamp for records (needed for sorting later)
                    "Paid"
            );
            dao.Payments().add(payment); // ADDING IT TO THE DATABASE

            // 2. Create and store the order object, link it to the payment
            Order order = new Order(
                    user.getId(),
                    payment.getPaymentId(),
                    LocalDateTime.now()
            );
            order = dao.Orders().add(order); // ADDING IT TO THE DATABASE

            for (CartItem item : cart.getItems()) {
                OrderItem orderItem = new OrderItem(
                        order.getOrderId(),
                        item.getProduct().getProductID(),
                        item.getProduct().getProductName(),
                        item.getProduct().getPrice(),
                        item.getQuantity()
                );
                dao.OrderItems().add(orderItem);
            }

            String shippingAddress = (String) session.getAttribute("selectedShippingAddress");
            String shippingMethod = (String) session.getAttribute("selectedShippingMethod");
            String shippingDate = (String) session.getAttribute("selectedShippingDate");

            Shipment shipment = new Shipment(
                    0,
                    order.getOrderId(),
                    shippingAddress,
                    shippingMethod,
                    shippingDate
            );
            shipment = dao.Shipments().add(shipment);

            session.setAttribute("shipmentId", shipment.getShipmentId());

            cart.clear();
            session.removeAttribute("selectedPaymentMethod");
            session.removeAttribute("selectedShippingAddress");
            session.removeAttribute("selectedShippingMethod");
            session.removeAttribute("selectedShippingDate");

            response.sendRedirect("orderConfirmation.jsp?orderId=" + order.getOrderId());

        } catch (SQLException e) {
            throw new ServletException("Failed to place order", e);
        }
    }
}