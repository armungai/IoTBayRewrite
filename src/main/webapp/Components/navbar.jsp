<%@ page import="com.IoTBay.model.User" %>

<%
    User navbarUser = (User) session.getAttribute("loggedInUser");
    boolean isLoggedIn = (navbarUser != null);
    boolean isAdmin = isLoggedIn && navbarUser.getAdmin();
    String cp = request.getContextPath();
%>

<% if (isLoggedIn) { %>
<!DOCTYPE html>
<html>
<head>
    <base href="<%= cp %>/">
    <link rel="stylesheet" href="assets/styles.css">
</head>

<nav class="navbar">
    <a href="<%= cp %>/home.jsp" class="logo">IoT Bay</a>
    <ul class="nav-links">
        <li><a href="<%= cp %>/home.jsp">Home</a></li>
        <li><a href="<%= cp %>/products.jsp">Products</a></li>
        <li><a href="<%= cp %>/accountSettings.jsp">Account</a></li>

        <% if (!isAdmin) { %>
        <li><a href="<%= cp %>/cart.jsp">Cart</a></li>
        <% } %>

        <li><a href="<%= cp %>/LogoutServlet">Logout</a></li>
    </ul>
</nav>
</html>
<% } else { %>
<!DOCTYPE html>
<html>
<head>
    <base href="<%= cp %>/">
    <link rel="stylesheet" href="assets/styles.css">
</head>

<nav class="navbar">
    <a href="index.jsp" class="logo">IoT Bay</a>
    <ul class="nav-links">
        <li><a href="index.jsp">Home</a></li>
        <li><a href="products.jsp">Products</a></li>
        <li><a href="login.jsp">Login</a></li>
    </ul>
</nav>
</html>
<% } %>
