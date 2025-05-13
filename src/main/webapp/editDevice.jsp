<%--
  Created by IntelliJ IDEA.
  User: Nguyen Tran
  Date: 5/10/2025
  Time: 10:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.IoTBay.model.Product" %>
<%@ page session="true" %>
<%
    Product product = (Product) session.getAttribute("productToEdit");
    if (product == null) {
        response.sendRedirect("manageDevices.jsp?error=NoProduct");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit IoT Device</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/styles.css">
</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<div class="edit-form-container">
    <h1>Edit IoT Device</h1>
    <form action="EditDeviceServlet" method="post">
        <input type="hidden" name="id" value="<%= product.getProductID() %>"/>

        <label for="name">Product Name:</label>
        <input id="name" type="text" name="name"
               value="<%= product.getProductName() %>" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= product.getProductDescription() %></textarea>

        <label for="price">Price:</label>
        <input id="price" type="number" step="0.01" name="price"
               value="<%= product.getPrice() %>" required>

        <label for="image">Image Path:</label>
        <input id="image" type="text" name="image"
               value="<%= product.getProductImageAddress() %>" required>

        <button type="submit" class="btn">Update Device</button>
    </form>

    <a href="manageDevices.jsp" class="link-button">Cancel</a>
</div>
</body>
</html>

