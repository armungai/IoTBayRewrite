<%@ page import="com.IoTBay.model.dao.DAO" %>
<%@ page import="com.IoTBay.model.User" %>
<%@ page import="com.IoTBay.model.Product" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 5/5/2025
  Time: 1:25 pm
  To change this template use File | Settings | File Templates.
--%>

<%
  DAO dao = (DAO) session.getAttribute("db");
  User loggedInUser = (User) session.getAttribute("loggedInUser");
  List<Product> products = dao.Products().getAllProducts();
%>

<%@include file="Components/navbar.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Welcome back</title>
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<div class ="welcome-heading">
  <% if (loggedInUser != null) { %>
  <h1>Welcome to IoT Bay, <%= loggedInUser.getFName() %>!</h1>
  <h2>Your one-stop shop for all things smart!</h2>
  <% } else { %>
  <h1>Welcome to IoT Bay!</h1>
  <h2>Please <a href="index.jsp">log in</a> to see your dashboard.</h2>
  <% } %>
</div>

<h1>Featured Products</h1>
<%@ include file="Components/productGrid.jsp" %>
</body>
</html>