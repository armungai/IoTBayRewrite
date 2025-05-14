<%--
  Created by IntelliJ IDEA.
  User: Nguyen Tran
  Date: 5/11/2025
  Time: 10:09 PM
--%>

<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.IoTBay.model.User, com.IoTBay.model.dao.DAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>All Customer Orders</title>
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<%
  DAO dao = (DAO) session.getAttribute("db");
  if (dao == null) {
%>
<div class="error"><em>Database not available.</em></div>
<%
    return;
  }

  User u = (User) session.getAttribute("loggedInUser");
  if (u == null || !u.getAdmin()) {
    response.sendRedirect("home.jsp");
    return;
  }

  Connection conn = dao.getConnection();
  String sql =
          "SELECT o.orderId, o.userId, " +
                  "       u.firstName || ' ' || u.lastName AS customerName, " +
                  "       o.paymentId, o.orderDate " +
                  "  FROM Orders o " +
                  "  JOIN users u ON o.userId = u.userID";
  PreparedStatement ps = conn.prepareStatement(sql);
  ResultSet rs = ps.executeQuery();
%>

<h1>All Customer Orders</h1>
<table class="order-history-table">
  <thead>
  <tr>
    <th>Order ID</th>
    <th>Customer</th>
    <th>Payment ID</th>
    <th>Order Date</th>
  </tr>
  </thead>
  <tbody>
  <% while (rs.next()) { %>
  <tr>
    <td><%= rs.getInt("orderId") %></td>
    <td><%= rs.getString("customerName") %></td>
    <td><%= rs.getInt("paymentId") %></td>
    <td><%= rs.getString("orderDate") %></td>
  </tr>
  <% } %>
  </tbody>
</table>

<%
  rs.close();
  ps.close();
%>
</body>
</html>


