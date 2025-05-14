<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%
    String orderId = request.getParameter("orderId");
    Integer shipmentId = (Integer) session.getAttribute("shipmentId");

    if (orderId == null || orderId.isEmpty()) {
        response.sendRedirect("products.jsp");
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

    <% if (shipmentId != null) { %>
    <p><strong>Shipment ID:</strong> <%= shipmentId %></p>
    <% } %>

    <a href="products.jsp" class="register-button" style="margin-top: 20px;">Continue Shopping</a>
</main>

</body>
</html>