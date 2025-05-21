<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: Nguyen Tran--%>
<%--  Date: 5/11/2025--%>
<%--  Time: 10:09 PM--%>
<%--&ndash;%&gt;--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.IoTBay.model.dao.DAO" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>IoT Bay – All Customer Orders</title>
  <link rel="stylesheet" href="assets/styles.css">
  <style>
    .filter-form {
      margin: 1rem 0;
      text-align: right;
    }
    .filter-form input {
      width: 80px;
      padding: 0.3em;
    }
    .filter-form button {
      padding: 0.3em 0.8em;
    }
    .order-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 1rem;
    }
    .order-table th,
    .order-table td {
      padding: 0.5em;
      border: 1px solid #ccc;
    }
    .order-table th {
      background: #444;
      color: white;
    }
    .order-table tr:nth-child(even) {
      background: #f9f9f9;
    }
  </style>
</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<h1>All Customer Orders</h1>

<%
  // pull DAO+connection
  DAO dao = (DAO) session.getAttribute("db");
  if (dao == null) {
    response.sendRedirect("login.jsp");
    return;
  }
  Connection conn = dao.getConnection();

  // read the orderId filter
  String orderIdParam = request.getParameter("orderId");
  boolean hasFilter = (orderIdParam != null && orderIdParam.matches("\\d+"));
  int filterId = -1;
  if (hasFilter) {
    filterId = Integer.parseInt(orderIdParam);
  }

  // build & prepare SQL
  String sql =
          "SELECT o.orderId, " +
                  "       u.FirstName || ' ' || u.LastName AS customerName, " +
                  "       o.paymentId, " +
                  "       o.orderDate " +
                  "  FROM Orders o " +
                  "  JOIN Users u ON o.userId = u.UserId";
  if (hasFilter) {
    sql += " WHERE o.orderId = ?";
  }
  PreparedStatement ps = conn.prepareStatement(sql);
  if (hasFilter) {
    ps.setInt(1, filterId);
  }
  ResultSet rs = ps.executeQuery();
%>

<form class="filter-form" method="get" action="AdminViewAllOrders.jsp">
  <label>
    Order ID:
    <input
            type="text"
            name="orderId"
            value="<%= hasFilter ? filterId : "" %>"
            placeholder="e.g. 3"
    />
  </label>
  <button type="submit">Filter</button>
  <% if (hasFilter) { %>
  <button type="button" onclick="window.location='AdminViewAllOrders.jsp'">
    Clear
  </button>
  <% } %>
</form>

<table class="order-table">
  <thead>
  <tr>
    <th>ORDER ID</th>
    <th>CUSTOMER</th>
    <th>PAYMENT ID</th>
    <th>ORDER DATE</th>
  </tr>
  </thead>
  <tbody>
  <%
    while (rs.next()) {
  %>
  <tr>
    <td><%= rs.getInt("orderId") %></td>
    <td><%= rs.getString("customerName") %></td>
    <td><%= rs.getInt("paymentId") %></td>
    <td><%= rs.getString("orderDate") %></td>
  </tr>
  <%
    }
    rs.close();
    ps.close();
  %>
  </tbody>
</table>
</body>
</html>