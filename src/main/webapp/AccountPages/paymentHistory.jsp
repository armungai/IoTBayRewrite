<%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 6/5/2025
  Time: 2:45 pm
--%>
<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");

    if (dao == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Payment> payments = dao.Payments().getPaymentsByUserId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Payments</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>

<%@ include file="../Components/navbar.jsp" %>

<h1 style="text-align:center;">Payment History</h1>

<div style="width: 80%; margin: 0 auto;" class="view-all-data">
    <% if (payments.isEmpty()) { %>
    <p>You haven’t made any payments yet.</p>
    <% } else { %>
    <table class="order-history-table">
        <tr>
            <th>Payment ID</th>
            <th>Method ID</th>
            <th>Amount</th>
            <th>Date</th>
            <th>Status</th>
        </tr>
        <% for (Payment payment : payments) { %>
        <tr>
            <td><%= payment.getPaymentId() %></td>
            <td><%= payment.getMethodId() %></td>
            <td>$<%= String.format("%.2f", payment.getAmount()) %></td>
            <td><%= payment.getDate() %></td>
            <td><%= payment.getStatus() %></td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>

</body>
</html>
