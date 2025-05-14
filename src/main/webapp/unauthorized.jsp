<%--
  Created by IntelliJ IDEA.
  User: Nguyen Tran
  Date: 5/10/2025
  Time: 10:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="true" %>
<%@ page import="com.IoTBay.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Access Denied</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<main class="unauthorized-container">
    <div class="unauthorized-card">
        <h1>Access Denied</h1>
        <p>You do not have permission to view this page.</p>
        <%
            User u = (User) session.getAttribute("loggedInUser");
            String target = (u != null && u.getAdmin()) ? "adminHome.jsp" : "home.jsp";
        %>
        <a href="<%= target %>" class="btn">Go Back</a>
    </div>
</main>

<%@ include file="Components/footer.jsp" %>
</body>
</html>



