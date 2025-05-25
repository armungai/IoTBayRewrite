<%--
  Created by IntelliJ IDEA.
  User: Nguyen Tran
  Date: 5/11/2025
  Time: 1:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.IoTBay.model.User, com.IoTBay.model.dao.DAO, com.IoTBay.model.Product, java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
  User user = (User) session.getAttribute("loggedInUser");
  if (user == null || !user.getAdmin()) {
    response.sendRedirect("unauthorized.jsp");
    return;
  }

  DAO dao = (DAO) session.getAttribute("db");
  List<Product> products = dao.Products().getAllProducts();

  request.setAttribute("products", products);
  request.setAttribute("isAdmin", true);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
 <jsp:include page="/Components/navbar.jsp" flush="true" />
<div style="margin-left: 50px">
  <div class="welcome-heading">
    <h1>Welcome, Admin <%= user.getFName() %>!</h1>
    <h2>Manage IoT Devices Below</h2>
  </div>

  <h1>All Products</h1>
  <jsp:include page="/Components/productGrid.jsp" flush="true" />
</div>
</body>
</html>


