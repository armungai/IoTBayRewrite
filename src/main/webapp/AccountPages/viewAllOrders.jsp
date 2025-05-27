<%@ page import="java.util.List, com.IoTBay.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%
    @SuppressWarnings("unchecked")
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null) {
        response.sendRedirect(request.getContextPath() + "/OrderHistoryServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>
<%@ include file="../Components/navbar.jsp" %>

<h1 style="text-align:center;">Order History</h1>

<!-- ─── Search / Sort / Reset ─── -->
<div class="controls-container">
    <form method="get"
          action="<%= request.getContextPath() %>/OrderHistoryServlet"
          class="search-sort-form">
        <label>Search by Order ID:</label>
        <input name="orderId" type="text"
               value="<%= request.getParameter("orderId") != null
                    ? request.getParameter("orderId") : "" %>"/>

        <label>Sort by:</label>
        <select name="sort">
            <option value="">-- Select --</option>
            <option value="date-desc"
                    <%= "date-desc".equals(request.getParameter("sort")) ? "selected" : "" %>>
                Date (Newest→Oldest)
            </option>
            <option value="date-asc"
                    <%= "date-asc".equals(request.getParameter("sort"))  ? "selected" : "" %>>
                Date (Oldest→Newest)
            </option>
            <option value="id-desc"
                    <%= "id-desc".equals(request.getParameter("sort"))    ? "selected" : "" %>>
                Order ID (Newest→Oldest)
            </option>
            <option value="id-asc"
                    <%= "id-asc".equals(request.getParameter("sort"))    ? "selected" : "" %>>
                Order ID (Oldest→Newest)
            </option>
        </select>

        <button type="submit">Go</button>

        <a href="<%= request.getContextPath() %>/OrderHistoryServlet" class="reset-link">Reset</a>
    </form>
</div>
<!-- ─────────────────────────────── -->

<div class="view-all-data" style="width:80%; margin:0 auto;">
    <% if (orders.isEmpty()) { %>
    <p>You haven’t placed any orders yet.</p>
    <a class="return-ref" href="<%= request.getContextPath() %>/accountSettings.jsp">Back</a>
    <% } else { %>
    <table class="order-history-table">
        <tr>
            <th>Order ID</th>
            <th>Payment ID</th>
            <th>Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <% for (Order order : orders) {
            String st = order.getStatus();
            if (st == null || st.isEmpty()) st = "Pending";
        %>
        <tr>
            <td><%= order.getOrderId() %></td>
            <td><%= order.getPaymentId() %></td>
            <td><%= order.getOrderDate().toLocalDate() %></td>
            <td><%= st %></td>
            <td>
                <% if ("Pending".equalsIgnoreCase(st)) { %>
                <form action="<%= request.getContextPath() %>/CancelOrderServlet"
                      method="post"
                      onsubmit="return confirm('Cancel order #<%= order.getOrderId() %>?');"
                      style="display:inline">
                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>"/>
                    <button type="submit" class="btn-cancel">Cancel</button>
                </form>
                <% } else { %>
                <button class="btn-cancelled" disabled>Cancelled</button>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>

<%@ include file="../Components/footer.jsp" %>
</body>
</html>