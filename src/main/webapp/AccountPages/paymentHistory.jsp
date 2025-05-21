<%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 6/5/2025
  Time: 2:45 pm
--%>
<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");

    if (dao == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Payment> paymentsGeneric = null;

    String searchIdStr = request.getParameter("paymentId");
    String userIdStr = request.getParameter("userId");
    String sort = request.getParameter("sort");

    if (user.getAdmin() && userIdStr != null && !userIdStr.trim().isEmpty()) {
        try {
            int searchUserId = Integer.parseInt(userIdStr);
            try {
                paymentsGeneric = dao.Payments().getPaymentsByUserId(searchUserId);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } catch (NumberFormatException e) {
            paymentsGeneric = new ArrayList<>(); // invalid user ID format
        }
    } else if (searchIdStr != null && !searchIdStr.trim().isEmpty()) {
        try {
            int searchId = Integer.parseInt(searchIdStr);
            Payment p = dao.Payments().getPaymentById(searchId);
            paymentsGeneric = new ArrayList<>();
            if (p != null) paymentsGeneric.add(p);
        } catch (NumberFormatException e) {
            paymentsGeneric = new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    } else {
        try {
            if (user.getAdmin()) {
                paymentsGeneric = dao.Payments().getAllPayments();
            } else {
                paymentsGeneric = dao.Payments().getPaymentsByUserId(user.getId());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if ("asc".equals(sort)) {
            paymentsGeneric.sort((a, b) -> a.getDate().compareTo(b.getDate()));
        } else if ("desc".equals(sort)) {
            paymentsGeneric.sort((a, b) -> b.getDate().compareTo(a.getDate()));
        } else if ("asc-price".equals(sort)) {
            paymentsGeneric.sort((a, b) -> Double.compare(a.getAmount(), b.getAmount()));
        } else if ("desc-price".equals(sort)) {
            paymentsGeneric.sort((a, b) -> Double.compare(b.getAmount(), a.getAmount()));
        }
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Payments</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>

<%@ include file="../Components/navbar.jsp" %>
<h1 style="text-align:center;">Payment History</h1>
<div style="width: 80%; margin: 0 auto; text-align: center" class="view-all-data">
    <% if (paymentsGeneric.isEmpty()) { %>
    <% if (searchIdStr != null && !searchIdStr.trim().isEmpty()) { %>
    <p>No payment found with ID <strong><%= searchIdStr %></strong>. <span><a href="AccountPages/paymentHistory.jsp">Back</a> </span></p>
    <% } else { %>
    <p>You haven’t made any payments yet.</p>
    <a class="return-ref" href = "AccountPages/paymentHistory.jsp">Back</a>
    <% } %>
    <% } else { %>
    <form method="get" action="AccountPages/paymentHistory.jsp" style="text-align:center; margin-bottom: 20px;">
        <label for="search">Search by Payment ID:</label>
        <input type="text" id="search" class="search-payment" name="paymentId" placeholder="Enter payment ID" value="<%= (searchIdStr != null) ? searchIdStr : "" %>">
        <input type="hidden" name="sort" value="<%= (sort != null) ? sort : "" %>">
        <% if (user.getAdmin()) { %>
        <br>
        <br>
        <label for="searchUser">Search By User ID:</label>
        <input type="text" id="searchUser" class="search-payment" name="userId" placeholder="Enter user ID"
               value="<%= request.getParameter("userId") != null ? request.getParameter("userId") : "" %>">
        <% } %>
        <br>
        <button type="submit" style="margin-top: 10px">Search</button><span><a class="search-payment" href="AccountPages/paymentHistory.jsp">Reset</a> </span>
    </form>

    <div style="text-align:center; margin-bottom: 20px;">
        <form method="get" action="AccountPages/paymentHistory.jsp" style="display: inline-block;">
            <input type="hidden" name="paymentId" value="<%= (searchIdStr != null) ? searchIdStr : "" %>">
            <label for="sort" style="font-weight: bold; margin-right: 10px;">Sort by:</label>
            <select name="sort" id="sort" onchange="this.form.submit()"
                    style="padding: 5px 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 14px;">
                <option value="">-- Select --</option>
                <option value="asc" <%= "asc".equals(sort) ? "selected" : "" %>>Date (Oldest to Newest)</option>
                <option value="desc" <%= "desc".equals(sort) ? "selected" : "" %>>Date (Newest to Oldest)</option>
                <option value="asc-price" <%= "asc-price".equals(sort) ? "selected" : "" %>>Price (Lowest to Highest)</option>
                <option value="desc-price" <%= "desc-price".equals(sort) ? "selected" : "" %>>Price (Highest to Lowest)</option>
            </select>
        </form>
    </div>
    <table class="order-history-table">
        <tr>
            <%if (user.getAdmin()){ %>
            <th>User Id</th>
            <% }%>
            <th>Payment ID</th>
            <th>Method</th>
            <th>Amount</th>
            <th>Date</th>
            <th>Status</th>
            <th>Actions</th>

        </tr>
        <% for (Payment payment : paymentsGeneric) { %>
        <%
            PaymentMethod pm = dao.PaymentMethods().get(payment.getMethodId());
        %>
        <tr>
            <%if (user.getAdmin()){ %>
            <td><%=payment.getUserId()%></td>
            <% }%>
            <td><%= payment.getPaymentId() %></td>
            <td>
                <% if (pm != null && pm.getCardNumber() != null && pm.getCardNumber().length() >= 4) { %>
                **** **** **** <%= pm.getCardNumber().substring(pm.getCardNumber().length() - 4) %>
                <% } else { %>
                N/A
                <% } %>
            </td>
            <td>$<%= String.format("%.2f", payment.getAmount()) %></td>
            <td><%= payment.getDate() %></td>
            <td><%= payment.getStatus() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/DeletePaymentServlet?paymentId=<%= payment.getPaymentId() %>"
                   onclick="return confirm('Are you sure you want to delete this payment?');">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>
</body>
</html>