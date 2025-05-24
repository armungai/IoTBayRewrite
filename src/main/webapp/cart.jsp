<%@ page import="com.IoTBay.model.Cart" %>
<%@ page import="com.IoTBay.model.CartItem" %>
<%@ page import="com.IoTBay.model.dao.DAO" %>
<%@ page import="com.IoTBay.model.User" %>
<%@ page import="com.IoTBay.model.PaymentMethod" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%--<%--%>
<%--    DAO dao = (DAO) session.getAttribute("db");--%>
<%--    User user = (User) session.getAttribute("loggedInUser");--%>
<%--    String tempShippingAddress = (String) session.getAttribute("tempShippingAddress");--%>

<%--    if (dao == null || user == null) {--%>
<%--        response.sendRedirect("index.jsp");--%>
<%--        return;--%>
<%--    }--%>

<%--    Cart cart = (Cart) session.getAttribute("cart");--%>
<%--    if (cart == null || cart.getItems().isEmpty()) {--%>
<%--        response.sendRedirect("emptyCart.jsp");--%>
<%--        return;--%>
<%--    }--%>

<%--    List<CartItem> items = cart.getItems();--%>
<%--    List<PaymentMethod> methods = dao.PaymentMethods().getMethodsByUserId(user.getId());--%>
<%--%>--%>

<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Your Cart</title>--%>
<%--    <link rel="stylesheet" href="assets/styles.css">--%>
<%--    <style>--%>
<%--        #shippingMethod {--%>
<%--            width: 200px !important;--%>
<%--        }--%>
<%--        .form-group + .form-group {--%>
<%--            margin-top: 15px;--%>
<%--        }--%>
<%--    </style>--%>
<%--    <script>--%>
<%--        function handleShippingAddressChange(value) {--%>
<%--            if (value === 'new') {--%>
<%--                window.location.href = 'addShippingAddress.jsp';--%>
<%--            }--%>
<%--        }--%>
<%--    </script>--%>
<%--</head>--%>
<%--<body>--%>

<%--<%@ include file="Components/navbar.jsp" %>--%>

<%--<h1 style="text-align:center;">Your Cart</h1>--%>

<%--<table class="order-history-table">--%>
<%--    <thead>--%>
<%--    <tr>--%>
<%--        <th>Product</th>--%>
<%--        <th>Unit Price</th>--%>
<%--        <th>Quantity</th>--%>
<%--        <th>Item Total</th>--%>
<%--    </tr>--%>
<%--    </thead>--%>
<%--    <tbody>--%>
<%--    <%--%>
<%--        float grandTotal = 0;--%>
<%--        for (CartItem item : items) {--%>
<%--            float itemTotal = item.getProduct().getPrice() * item.getQuantity();--%>
<%--            grandTotal += itemTotal;--%>
<%--    %>--%>
<%--    <tr>--%>
<%--        <td><%= item.getProduct().getProductName() %></td>--%>
<%--        <td>$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>--%>
<%--        <td><%= item.getQuantity() %></td>--%>
<%--        <td>$<%= String.format("%.2f", itemTotal) %></td>--%>
<%--    </tr>--%>
<%--    <% } %>--%>
<%--    <tr class="total-row">--%>
<%--        <td colspan="3">Total</td>--%>
<%--        <td>$<%= String.format("%.2f", grandTotal) %></td>--%>
<%--    </tr>--%>
<%--    </tbody>--%>
<%--</table>--%>

<%--<div class="confirm-order-wrapper">--%>
<%--    <%--%>
<%--        if (methods == null || methods.isEmpty()) {--%>
<%--    %>--%>
<%--    <div class="form-group">--%>
<%--        <p>You don’t have any saved payment methods.</p>--%>
<%--        <a href="AccountPages/addNewPaymentMethod.jsp" class="register-button">➕ Add a Payment Method</a>--%>
<%--    </div>--%>
<%--    <%--%>
<%--    } else {--%>
<%--    %>--%>
<%--    <form action="ConfirmOrderServlet" method="post">--%>
<%--        <div class="checkout-grid">--%>

<%--            <div class="left-column">--%>
<%--                <h2>Select Payment Method</h2>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="methodId">Choose a payment method:</label><br>--%>
<%--                    <select name="methodId" id="methodId" required>--%>
<%--                        <% for (PaymentMethod method : methods) {--%>
<%--                            String label = method.getType() + " ending in " + method.getCardNumber().substring(method.getCardNumber().length() - 4); %>--%>
<%--                        <option value="<%= method.getMethodId() %>"><%= label %></option>--%>
<%--                        <% } %>--%>
<%--                    </select>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="right-column">--%>
<%--                <h2>Shipping Information</h2>--%>

<%--                <div class="form-group">--%>
<%--                    <label for="address">Choose a shipping address:</label>--%>
<%--                    <select name="address" id="address" onchange="handleShippingAddressChange(this.value)" required>--%>
<%--                        <% if (tempShippingAddress != null) { %>--%>
<%--                        <option value="<%= tempShippingAddress %>" selected>--%>
<%--                            New Address: <%= tempShippingAddress %>--%>
<%--                        </option>--%>
<%--                        <% } %>--%>
<%--                        <option value="<%= user.getAddress() + ", " + user.getCity() + ", " + user.getState() %>" <%= (tempShippingAddress == null ? "selected" : "") %>>--%>
<%--                            Use my registered address: <%= user.getAddress() %>, <%= user.getCity() %>, <%= user.getState() %>--%>
<%--                        </option>--%>
<%--                        <option value="new">Change address</option>--%>
<%--                    </select>--%>
<%--                </div>--%>

<%--                <div class="form-group">--%>
<%--                    <label for="shippingMethod">Shipping Method:</label>--%>
<%--                    <select name="shippingMethod" id="shippingMethod" required>--%>
<%--                        <option value="Standard">Standard</option>--%>
<%--                        <option value="Express">Express</option>--%>
<%--                        <option value="Same Day">Same Day</option>--%>
<%--                    </select>--%>
<%--                </div>--%>

<%--                <div class="form-group">--%>
<%--                    <label for="shippingDate">Shipping Start Date:</label>--%>
<%--                    <input type="date" id="shippingDate" name="shippingDate" required min="<%= java.time.LocalDate.now()%>">--%>
<%--                </div>--%>

<%--                <input type="hidden" name="orderId" value="123">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div>--%>
<%--            <button type="submit" class="register-button" style="width: 180px; margin-top: 30px;">--%>
<%--                Proceed to Checkout--%>
<%--            </button>--%>
<%--        </div>--%>
<%--    </form>--%>
<%--    <%--%>
<%--        }--%>
<%--    %>--%>
<%--</div>--%>

<%--<%@ include file="Components/footer.jsp" %>--%>

<%--</body>--%>
<%--</html>--%>

<%@ page import="com.IoTBay.model.*,com.IoTBay.model.dao.DAO" %>
<%@ page session="true" %>
<%
    DAO dao   = (DAO)session.getAttribute("db");
    Cart cart = (Cart)session.getAttribute("cart");
    if (dao==null || cart==null || cart.isEmpty()) {
        response.sendRedirect("emptyCart.jsp");
        return;
    }
    List<CartItem> items = cart.getItems();
%>
<!DOCTYPE html>
<html><head>
    <title>Your Cart</title>
    <link rel="stylesheet" href="assets/styles.css">
</head><body>
<jsp:include page="Components/navbar.jsp"/>
<h1>Your Cart</h1>
<c:if test="${param.error=='exceedsStock'}">
    <p style="color:red;">Cannot add more than available stock.</p>
</c:if>
<table class="order-history-table">
    <tr><th>Product</th><th>Unit</th><th>Qty</th><th>Total</th></tr>
    <%
        float grand=0;
        for(CartItem ci:items){
            float row = ci.getTotalPrice();
            grand += row;
    %>
    <tr>
        <td><%=ci.getProduct().getProductName()%></td>
        <td>$<%=String.format("%.2f",ci.getProduct().getPrice())%></td>
        <td>
            <form method="post" action="UpdateCartServlet" style="display:inline">
                <input type="hidden" name="productId" value="<%=ci.getProduct().getProductID()%>"/>
                <input type="hidden" name="action" value="minus"/>
                <button>−</button>
            </form>
            <%=ci.getQuantity()%>
            <form method="post" action="UpdateCartServlet" style="display:inline">
                <input type="hidden" name="productId" value="<%=ci.getProduct().getProductID()%>"/>
                <input type="hidden" name="action" value="plus"/>
                <button>+</button>
            </form>
        </td>
        <td>$<%=String.format("%.2f",row)%></td>
    </tr>
    <% } %>
    <tr><td colspan="3"><strong>Total</strong></td>
        <td><strong>$<%=String.format("%.2f",grand)%></strong></td></tr>
</table>
<form action="SubmitOrderServlet" method="post">
    <!-- payment + shipping inputs here -->
    <button>Proceed to Checkout</button>
</form>
<jsp:include page="Components/footer.jsp"/>
</body></html>

