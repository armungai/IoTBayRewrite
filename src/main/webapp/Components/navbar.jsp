<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: andrewmungai--%>
<%--  Date: 4/5/2025--%>
<%--  Time: 5:48 pm--%>
<%@ page import="com.IoTBay.model.User" %>

<%
    User navbarUser = (User)session.getAttribute("loggedInUser");
    boolean isAdmin = (navbarUser != null && navbarUser.getAdmin());
    String productsTarget = isAdmin ? "adminHome.jsp" : "home.jsp";
%>

<!DOCTYPE html>
<html>
<head>
    <% String cp = request.getContextPath(); %>
    <base href="<%=cp%>/">
    <link rel="stylesheet" href="assets/styles.css">
</head>

<nav class="navbar">
    <%
        Object userObj = session.getAttribute("loggedInUser");
    %>
    <% if (userObj == null) { %>
    <a href="index.jsp" class="logo">IoT Bay</a>
    <% } else { %>
    <a href="<%= request.getContextPath() %>/home.jsp" class="logo">IoT Bay</a>
    <% } %>
    <ul class="nav-links">
        <li><a href="<%=cp%>/home.jsp">Home</a></li>
        <li><a href="<%=cp%>/products.jsp">Products</a></li>
        <li><a href="<%=cp%>/accountSettings.jsp">Account</a></li>
        <% if (!isAdmin) { %>
        <li><a href="<%=cp%>/cart.jsp">Cart</a></li>
        <% } %>
        <li><a href="<%=cp%>/LogoutServlet">Logout</a></li>
    </ul>
</nav>
</html>
