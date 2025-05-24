<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: andrewmungai--%>
<%--  Date: 6/5/2025--%>
<%--  Time: 2:22 pm--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>--%>
<%--<%@ page import="java.util.List" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page isELIgnored="false" %>--%>

<%--<%--%>
<%--    DAO dao = (DAO) session.getAttribute("db");--%>
<%--    User user = (User) session.getAttribute("loggedInUser");--%>

<%--    if (dao == null || user == null) {--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--        return;--%>
<%--    }--%>

<%--    List<Order> orders = dao.Orders().getOrdersByUserId(user.getId());--%>
<%--%>--%>

<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Your Orders</title>--%>
<%--    <link rel="stylesheet" href="../assets/styles.css">--%>
<%--</head>--%>
<%--<body>--%>

<%--<%@ include file="../Components/navbar.jsp" %>--%>

<%--<h1 style="text-align:center;">Order History</h1>--%>

<%--<div style="width: 80%; margin: 0 auto;" class="view-all-data">--%>
<%--    <% if (orders.isEmpty()) { %>--%>
<%--    <p>You haven’t placed any orders yet.</p>--%>
<%--&lt;%&ndash;    <a class="return-ref" href = "accountSettings.jsp">Back</a>&ndash;%&gt;--%>
<%--    <div style="margin-bottom: 20px;">--%>
<%--        <a href="accountSettings.jsp" style="--%>
<%--        display: inline-block;--%>
<%--        padding: 10px 20px;--%>
<%--        background-color: orange;--%>
<%--        color: white;--%>
<%--        text-decoration: none;--%>
<%--        border-radius: 5px;--%>
<%--        font-weight: bold;--%>
<%--        font-size: 16px;--%>
<%--        transition: background-color 0.3s ease;--%>
<%--    ">Back</a>--%>
<%--    </div>--%>
<%--    <% } else { %>--%>
<%--    <table class="order-history-table">--%>
<%--        <div style="margin-bottom: 20px;">--%>
<%--            <a href="accountSettings.jsp" style="--%>
<%--                display: inline-block;--%>
<%--                padding: 10px 20px;--%>
<%--                background-color: orange;--%>
<%--                color: white;--%>
<%--                text-decoration: none;--%>
<%--                border-radius: 5px;--%>
<%--                font-weight: bold;--%>
<%--                font-size: 16px;--%>
<%--                transition: background-color 0.3s ease;--%>
<%--            ">Back</a>--%>
<%--        </div>--%>
<%--        <tr>--%>
<%--            <th>Order ID</th>--%>
<%--            <th>Payment ID</th>--%>
<%--            <th>Date</th>--%>
<%--        </tr>--%>
<%--        <% for (Order order : orders) { %>--%>
<%--        <tr>--%>
<%--            <td><%= order.getOrderId() %></td>--%>
<%--            <td><%= order.getPaymentId() %></td>--%>
<%--            <td><%= order.getOrderDate() %></td>--%>
<%--        </tr>--%>
<%--        <% } %>--%>
<%--    </table>--%>
<%--    <% } %>--%>
<%--</div>--%>
<%--<%@ include file="/Components/footer.jsp" %>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page import="java.time.format.DateTimeFormatter,java.util.List" %>
<%@ page import="com.IoTBay.model.Order" %>
<%@ page isELIgnored="false" %>
<%
    List<Order> orders = (List<Order>)request.getAttribute("orders");
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd / HH:mm");
%>
<!DOCTYPE html><html><head>
<title>Order History</title>
<link rel="stylesheet" href="assets/styles.css">
</head><body>
<jsp:include page="Components/navbar.jsp"/>

<h1>Order History</h1>
<form method="get" action="../OrderHistoryServlet">
    Order ID:
    <input name="orderId" value="${param.orderId}"/>
    Sort:
    <select name="sort">
        <option value="">--</option>
        <option value="dateAsc">Old → New</option>
        <option value="dateDesc">New → Old</option>
    </select>
    <button>Filter</button>
    <a href="../OrderHistoryServlet">Reset</a>
</form>

<table class="order-history-table">
    <tr><th>ID</th><th>Pay ID</th><th>Date</th><th>Status</th><th>Action</th></tr>
    <%
        for (Order o: orders) {
    %>
    <tr>
        <td><%=o.getOrderId()%></td>
        <td><%=o.getPaymentId()%></td>
        <td><%=o.getOrderDate().format(fmt)%></td>
        <td><%=o.getStatus()%></td>
        <td>
            <% if ("saved".equals(o.getStatus()) || "Pending".equals(o.getStatus())) { %>
            <form method="post" action="../CancelOrderServlet"
                  onsubmit="return confirm('Cancel #<%=o.getOrderId()%>?');"
                  style="display:inline">
                <input type="hidden" name="orderId" value="<%=o.getOrderId()%>"/>
                <button>Cancel</button>
            </form>
            <% } else { %>
            &mdash;
            <% } %>
        </td>
    </tr>
    <% } %>
</table>

<jsp:include page="Components/footer.jsp"/>
</body></html>
