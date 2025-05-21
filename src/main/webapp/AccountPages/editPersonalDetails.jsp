<%@ page import="com.IoTBay.model.User, com.IoTBay.model.dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");

    if (dao == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Personal Details</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<%@ include file="../Components/navbar.jsp" %>

<main class="register-container">
    <section class="register-section">
    <div style="margin-bottom: 20px;">
        <a href="accountSettings.jsp" style="
        display: inline-block;
        padding: 10px 20px;
        background-color: orange;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
        font-size: 16px;
        transition: background-color 0.3s ease;
    ">Back</a>
    </div>
        <h1>Edit Your Personal Details</h1>

        <form action="<%= request.getContextPath() %>/EditUserServlet" method="post" class="login-form">
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" value="<%= user.getFName() %>" required>
            </div>

            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" value="<%= user.getLName() %>" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="<%= user.getPhone() %>">
            </div>

            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%= user.getAddress() %>" required>
            </div>

            <div class="form-group">
                <label for="city">City:</label>
                <input type="text" id="city" name="city" value="<%= user.getCity() %>" required>
            </div>

            <div class="form-group">
                <label for="state">State:</label>
                <input type="text" id="state" name="state" value="<%= user.getState() %>" required>
            </div>

            <div class="form-group">
                <button type="submit" class="register-button" style="width: 120px">Update Details</button>
            </div>
        </form>
    </section>
</main>
</body>
</html>
