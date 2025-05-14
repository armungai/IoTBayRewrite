<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");

    if (dao == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String,String>> entries = dao.Users().getAllWebsiteLogins();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Payments</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>

<%@ include file="../Components/navbar.jsp" %>

<h1 style="text-align:center;">Global Access History</h1>

<div style="width: 80%; margin: 0 auto;" class="view-all-data">
    <% if (entries.isEmpty()) { %>
    <p>You haven’t made any logins yet.</p>
    <% } else { %>
    <table class="order-history-table">
        <tr>
            <th>User ID</th>
            <th>Login Time</th>
            <th>Logout Time</th>

        </tr>
        <% for (Map<String,String> entry : entries) { %>
        <tr>
            <td><%= entry.get("userID")%></td>
            <td><%= entry.get("loginTime")%></td>
            <td><%= entry.get("logoutTime") %></td>

        </tr>
        <% } %>
    </table>
    <% } %>
</div>

</body>
</html>