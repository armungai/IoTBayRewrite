<%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 6/5/2025
  Time: 2:45 pm
--%>
<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    String sort = request.getParameter("sort");

    if (searchIdStr != null && !searchIdStr.trim().isEmpty()) {
        try {
            int searchId = Integer.parseInt(searchIdStr);
            Payment p = dao.Payments().getPaymentByIdAndUserId(searchId, user.getId());
            paymentsGeneric = new ArrayList<>();
            if (p != null) {
                paymentsGeneric.add(p);
            }
        } catch (NumberFormatException e) {
            paymentsGeneric = new ArrayList<>(); // no results if invalid ID
        }
    } else {
        paymentsGeneric = dao.Payments().getPaymentsByUserId(user.getId());

        if ("asc".equals(sort)) {
            paymentsGeneric.sort((a, b) -> a.getDate().compareTo(b.getDate()));
        } else if ("desc".equals(sort)) {
            paymentsGeneric.sort((a, b) -> b.getDate().compareTo(a.getDate()));
        }
    }


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
    <% if (paymentsGeneric.isEmpty()) { %>
    <% if (searchIdStr != null && !searchIdStr.trim().isEmpty()) { %>
    <p>No payment found with ID <strong><%= searchIdStr %></strong>. <span><a href="paymentHistory.jsp">Back</a> </span></p>
    <% } else { %>
    <p>You haven’t made any payments yet.</p>
    <% } %>
    <% } else { %>
    <form method="get" action="paymentHistory.jsp" style="text-align:center; margin-bottom: 20px;">
        <label for="search">Search by Payment ID:</label>
        <input type="text" id="search" name="paymentId" placeholder="Enter payment ID" value="<%= (searchIdStr != null) ? searchIdStr : "" %>">
        <input type="hidden" name="sort" value="<%= (sort != null) ? sort : "" %>">
        <button type="submit">Search</button><span><a style="margin-left: 15px" href="paymentHistory.jsp">Reset</a> </span>
    </form>
    <div style="text-align:center; margin-bottom: 20px;">
        <a href="paymentHistory.jsp?sort=asc">Sort by Date ↑</a> |
        <a href="paymentHistory.jsp?sort=desc">Sort by Date ↓</a>
    </div>
    <table class="order-history-table">
        <tr>
            <th>Payment ID</th>
            <th>Method ID</th>
            <th>Amount</th>
            <th>Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <% for (Payment payment : paymentsGeneric) { %>
        <tr>
            <td><%= payment.getPaymentId() %></td>
            <td><%= payment.getMethodId() %></td>
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
