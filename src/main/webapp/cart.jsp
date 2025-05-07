<%@ page import="com.IoTBay.model.Cart" %>
<%@ page import="com.IoTBay.model.CartItem" %>
<%@ page import="com.IoTBay.model.dao.DAO" %>
<%@ page import="com.IoTBay.model.User" %>
<%@ page import="com.IoTBay.model.PaymentMethod" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");

    if (dao == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("emptyCart.jsp");
        return;
    }

    List<CartItem> items = cart.getItems();
    List<PaymentMethod> methods = dao.PaymentMethods().getMethodsByUserId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>

<%@ include file="Components/navbar.jsp" %>

<h1 style="text-align:center;">Your Cart</h1>

<table class="order-history-table">
    <thead>
    <tr>
        <th>Product</th>
        <th>Unit Price</th>
        <th>Quantity</th>
        <th>Item Total</th>
    </tr>
    </thead>
    <tbody>
    <%
        float grandTotal = 0;
        for (CartItem item : items) {
            float itemTotal = item.getProduct().getPrice() * item.getQuantity();
            grandTotal += itemTotal;
    %>
    <tr>
        <td><%= item.getProduct().getProductName() %></td>
        <td>$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
        <td><%= item.getQuantity() %></td>
        <td>$<%= String.format("%.2f", itemTotal) %></td>
    </tr>
    <% } %>
    <tr class="total-row">
        <td colspan="3">Total</td>
        <td>$<%= String.format("%.2f", grandTotal) %></td>
    </tr>
    </tbody>
</table>

<div class="confirm-order-wrapper">
    <h2>Select Payment Method</h2>

    <%
        if (methods == null || methods.isEmpty()) {
    %>
    <div class="form-group">
        <p>You don’t have any saved payment methods.</p>
        <a href="AccountPages/addNewPaymentMethod.jsp" class="register-button">➕ Add a Payment Method</a>
    </div>
    <%
    } else {
    %>

    <form action="ConfirmOrderServlet" method="post">
        <div>
            <label for="methodId">Choose a payment method:</label><br>
            <select name="methodId" id="methodId" required>
                <%
                    for (PaymentMethod method : methods) {
                        String label = method.getType() + " ending in " + method.getCardNumber().substring(method.getCardNumber().length() - 4);
                %>
                <option value="<%= method.getMethodId() %>"><%= label %></option>
                <% } %>
            </select>
        </div>
        <div >
            <button type="submit" class="register-button " style="width: 180px">Proceed to Checkout</button>
        </div>
    </form>
    <%
        }
    %>
</div>

</body>
</html>
