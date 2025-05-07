<%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 6/5/2025
  Time: 2:20 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%
    String orderId = request.getParameter("orderId");
    if (orderId == null || orderId.isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>

<%@ include file="Components/navbar.jsp" %>

<main style="text-align: center; margin-top: 50px;">
    <h1>✅ Thank You for Your Order!</h1>
    <p>Your order has been placed successfully.</p>
    <p><strong>Order ID:</strong> <%= orderId %></p>
    <a href="index.jsp" class="register-button" style="margin-top: 20px;">Continue Shopping</a>
</main>

</body>
</html>