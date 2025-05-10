<%--
  Created by IntelliJ IDEA.
  User: gunst
  Date: 8/05/2025
  Time: 11:48 pm
  To change this template use File | Settings | File Templates.
--%>
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

  String dateSelected = null;
  List<Map<String,String>> entries = dao.Users().getUserLoginTimesByUserID(user.getId());
  if((String)session.getAttribute("selectedDate") != null){
    dateSelected = (String) session.getAttribute("selectedDate");
  }

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

<h1 style="text-align:center;">Access History</h1>

<% if(dateSelected != null){ %>
<h2  style="text-align:center;">Date Selected: <%=dateSelected%></h2>
<% } %>

<form action="${pageContext.request.contextPath}/FilterLogsServlet" method="post">
  <label for="date">Select Date:</label>
  <input type="date" id="date" name="selectedDate">
  <button type="submit">Filter Logs</button>
</form>

<div style="width: 80%; margin: 0 auto;" class="view-all-data">
  <% if (entries.isEmpty()) { %>
  <p>You haven’t made any logins yet.</p>
  <% } else { %>
  <table class="order-history-table">
    <tr>
      <th>Login Time</th>
      <th>Logout Time</th>

    </tr>
      <% if(dateSelected != null){
        for (Map<String,String> entry : entries) {
          if(entry.get("loginTime").contains(dateSelected)){%>
            <tr>
              <td><%= entry.get("loginTime")%></td>
              <td><%= entry.get("logoutTime") %></td>
            </tr>
    <% }

    }}

    else{
      for (Map<String,String> entry : entries) {%>
        <tr>
          <td><%= entry.get("loginTime")%></td>
          <td><%= entry.get("logoutTime") %></td>
        </tr>
      <%}}%>

  </table>
  <% } %>
</div>

</body>
</html>
