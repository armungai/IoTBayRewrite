<%--
  Created by IntelliJ IDEA.
  User: Nguyen Tran
  Date: 5/10/2025
  Time: 10:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.IoTBay.model.dao.DAO" %>
<%@ page import="com.IoTBay.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.IoTBay.model.User" %>
<%@ page session="true" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !user.getAdmin()) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    DAO dao = (DAO) session.getAttribute("db");
    List<Product> products = dao.Products().getAllProducts();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage IoT Devices</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/styles.css">
</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<div class="manage-container">
    <h1>Manage IoT Devices</h1>
    <div class="manage-actions">
        <a href="adminHome.jsp" class="btn btn-secondary">Back to Shop</a>
        <a href="addDevice.jsp" class="btn">Add New Device</a>
    </div>

    <div class="manage-table-wrapper">
        <table class="manage-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th style="min-width: 180px;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Product p : products) { %>
            <tr>
                <td><%= p.getProductID() %></td>
                <td><%= p.getProductName() %></td>
                <td>$<%= String.format("%.2f", p.getPrice()) %></td>
                <td>
                    <a href="EditDeviceLoaderServlet?id=<%= p.getProductID() %>" class="btn">Edit</a>
                    <a href="DeleteDeviceServlet?id=<%= p.getProductID() %>"
                       class="btn btn-secondary"
                       onclick="return confirm('Are you sure you want to delete this device?');">
                        Delete
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

