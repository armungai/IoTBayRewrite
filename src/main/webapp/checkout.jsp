<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");
    Cart cart = (Cart) session.getAttribute("cart");
    PaymentMethod method = (PaymentMethod) session.getAttribute("selectedPaymentMethod");
    String shippingAddress = (String) session.getAttribute("selectedShippingAddress");
    String shippingMethod = (String) session.getAttribute("selectedShippingMethod");
    String shippingDate = (String) session.getAttribute("selectedShippingDate");

    if (user == null || cart == null || method == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<h1 style="text-align:center;">Checkout Summary</h1>

<div class="checkout-summary" style="width: 80%; margin: 0 auto;">

    <div class="checkout-section">
        <h2>Payment Method</h2>
        <p><%= method.getType() %> ending in <%= method.getCardNumber().substring(method.getCardNumber().length() - 4) %></p>
        <p>Name on card: <%= method.getNameOnCard() %></p>
        <p>Expiry: <%= method.getExpiry() %></p>
    </div>

    <div class="checkout-section">
        <h2>Shipping Details</h2>
        <p>Address: <%= shippingAddress %></p>
        <p>Method: <%= shippingMethod %></p>
        <p>Date: <%= shippingDate %></p>
    </div>

    <div class="checkout-section">
        <h2>Order Summary</h2>
        <table class="order-history-table">
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Qty</th>
                <th>Total</th>
            </tr>
            <%
                float grandTotal = 0;
                for (CartItem item : cart.getItems()) {
                    float total = item.getQuantity() * item.getProduct().getPrice();
                    grandTotal += total;
            %>
            <tr>
                <td><%= item.getProduct().getProductName() %></td>
                <td>$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", total) %></td>
            </tr>
            <% } %>
            <tr class="total-row">
                <td colspan="3">Grand Total</td>
                <td>$<%= String.format("%.2f", grandTotal) %></td>
            </tr>
        </table>
    </div>

    <button type="submit" class="register-button form-group-a" style="width: 190px">
        <a href="cart.jsp">← Back to Cart</a>
    </button>
    <%--
    Start of the payment creation process
   --%>

    <form action="PlaceOrderServlet" method="post" class="place-order-section">
        <input type="hidden" name="methodId" value="<%= method.getMethodId() %>">
        <button class="register-button" style="margin-top: 20px; width: 180px">Place Order</button>
    </form>
</div>

</body>
</html>
