<%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 4/5/2025
  Time: 5:48 pm
  To change this template use File | Settings | File Templates.
--%>


<%-- This will let us use core tag library --%>
<link rel="stylesheet" href="assets/styles.css">

<nav class="navbar">
    <%
        Object userObj = session.getAttribute("loggedInUser");
    %>
    <% if (userObj == null) { %>
    <a href="index.jsp" class="logo">IoT Bay</a>
    <% } else { %>
    <a href="home.jsp" class="logo">IoT Bay</a>
    <% } %>
    <ul class="nav-links">
        <li><a href="<%= request.getContextPath() %>/products.jsp">Products</a></li>

        <%
            userObj = session.getAttribute("loggedInUser");
        %>
        <% if (userObj == null) { %>
        <li><a href="<%= request.getContextPath() %>/register.jsp">Register</a></li>
        <% } else { %>
        <li><a href="<%= request.getContextPath() %>/accountSettings.jsp">Account</a></li>
        <li><a href="<%= request.getContextPath() %>/cart.jsp">Cart</a></li>
        <li><a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a></li>
        <% } %>


    </ul>
</nav>