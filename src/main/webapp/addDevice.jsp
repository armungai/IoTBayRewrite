<%--
  Created by IntelliJ IDEA.
  User: Nguyen Tran
  Date: 5/10/2025
  Time: 10:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="true" %>
<%@ page import="com.IoTBay.model.User" %>
<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !user.getAdmin()) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Device</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<div class="form-container">
    <h1>Add New IoT Device</h1>
    <form action="AddDeviceServlet" method="post">
        <label>Device Name:</label>
        <input type="text" name="name" required>

        <label>Description:</label>
        <textarea name="description" required></textarea>

        <label>Price:</label>
        <input type="number" step="0.01" name="price" required>

        <label>Image Path:</label>
        <input type="text" name="image" required>

        <input type="submit" value="Add Device" class="btn">
        <a href="manageDevices.jsp" class="btn btn-secondary">Back to Manager</a>
    </form>
</div>
</body>
</html>

