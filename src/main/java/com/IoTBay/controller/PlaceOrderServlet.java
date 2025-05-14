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

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");
        Cart cart = (Cart) session.getAttribute("cart");
        PaymentMethod method = (PaymentMethod) session.getAttribute("selectedPaymentMethod");

        if (dao == null || user == null || cart == null || method == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=missingData");
            return;
        }

        try {
            Payment payment = new Payment(
                    0,
                    user.getId(),
                    method.getMethodId(),
                    cart.getTotalPrice(),
                    LocalDateTime.now().toString(),
                    "Paid"
            );
            dao.Payments().add(payment);

            Order order = new Order(
                    user.getId(),
                    payment.getPaymentId(),
                    LocalDateTime.now()
            );
            order = dao.Orders().add(order);

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