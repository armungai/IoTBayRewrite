package com.IoTBay.controller;

import com.IoTBay.model.*;
import com.IoTBay.model.dao.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;

@WebServlet("/SubmitOrderServlet")
public class SubmitOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        DAO dao       = (DAO) session.getAttribute("db");
        User user     = (User) session.getAttribute("loggedInUser");
        Cart cart     = (Cart) session.getAttribute("cart");

        int methodId       = Integer.parseInt(req.getParameter("methodId"));
        String address     = req.getParameter("address");
        String shipMethod  = req.getParameter("shippingMethod");
        String shipDate    = req.getParameter("shippingDate");  // "YYYY-MM-DD"

        LocalDateTime now  = LocalDateTime.now();
        float total        = cart.getTotalPrice();

        try {
            // 1) payment
            Payment pay = new Payment(
                    0,
                    user.getId(),
                    methodId,
                    total,
                    now.toString(),
                    "Pending"
            );
            pay = dao.Payments().add(pay);

            // 2) order (saved)
            Order ord = new Order(
                    user.getId(),
                    pay.getPaymentId(),
                    now
            );
            ord.setStatus("saved");
            ord = dao.Orders().add(ord);

            // 3) shipment
            Shipment sh = new Shipment(
                    0,
                    ord.getOrderId(),
                    shipMethod,
                    shipDate,
                    address
            );
            dao.Shipments().add(sh);

            // 4) line-items + stock
            for (CartItem ci : cart.getItems()) {
                OrderItem line = new OrderItem(
                        ord.getOrderId(),
                        ci.getProduct().getProductID(),
                        ci.getProduct().getProductName(),
                        ci.getProduct().getPrice(),
                        ci.getQuantity()
                );
                dao.OrderItems().add(line);

                Product p = ci.getProduct();
                p.setStock(p.getStock() - ci.getQuantity());
                dao.Products().update(p, p);
            }

            // 5) clear + confirm
            cart.clear();
            resp.sendRedirect("orderConfirmation.jsp?orderId=" + ord.getOrderId());

        } catch (SQLException e) {
            throw new ServletException("Error submitting order", e);
        }
    }
}