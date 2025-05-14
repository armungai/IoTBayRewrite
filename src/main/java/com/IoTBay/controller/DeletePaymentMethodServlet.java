package com.IoTBay.controller;

import com.IoTBay.model.User;
import com.IoTBay.model.PaymentMethod;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeletePaymentMethodServlet")
public class DeletePaymentMethodServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleDelete(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleDelete(request, response);  // Also allow GET for link-based deletion
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        DAO dao = (DAO) session.getAttribute("db");
        User user = (User) session.getAttribute("loggedInUser");

        if (dao == null || user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int methodId = Integer.parseInt(request.getParameter("methodId"));

            System.out.println(user.getId());
            PaymentMethod method = dao.PaymentMethods().get(new PaymentMethod(methodId, user.getId(), null, null, null, null, null));
            System.out.println(method.getMethodId());
            System.out.println(method.getUserId());
            if (method.getUserId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not authorized to delete this payment method.");
                return;
            }

            dao.PaymentMethods().delete(method);
            response.sendRedirect("AccountPages/SelectPaymentMethodToEdit.jsp"); // or wherever the list is shown

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid method ID.");
        } catch (SQLException e) {
            throw new ServletException("Database error during deletion", e);
        }
    }
}
