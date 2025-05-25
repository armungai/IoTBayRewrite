<%@ page import="com.IoTBay.model.dao.DAO" %>
<%@ page import="com.IoTBay.model.User" %>
<%@ page import="com.IoTBay.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.IoTBay.model.User" %>
<%@ page session="true" %>
<%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 5/5/2025
  Time: 1:25 pm
  To change this template use File | Settings | File Templates.
--%>

<%
  DAO dao   = (DAO) session.getAttribute("db");
  User user = (User) session.getAttribute("loggedInUser");

  if (user != null && user.getAdmin()) {
    response.sendRedirect("adminHome.jsp");
    return;
  }

  List<Product> products = dao.Products().getAllProducts();
  request.setAttribute("products", products);
  request.setAttribute("isAdmin", false);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Welcome to IoT Bay</title>
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<%@ include file="Components/navbar.jsp" %>
<div class ="welcome-heading">
  <% if (user != null) { %>
  <h1>Welcome, <%=user.getFName()%></h1>
  <h2>We're glad to see you back</h2>
  <% } else { %>
  <h1>Welcome to IoT Bay!</h1>
  <h2><a href="index.jsp">Log in</a> or keep browsing as guest.</h2>
  <% } %>
</div>

<div style="margin-left: 50px">
<h1>Featured Products</h1>
<jsp:include page="Components/productGrid.jsp" flush="true"/>
</div>
<%@include file="Components/footer.jsp"%>

</body>
</html>
