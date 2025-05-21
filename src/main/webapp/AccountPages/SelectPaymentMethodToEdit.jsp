<%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 6/5/2025
  Time: 9:52 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
  DAO dao = (DAO) session.getAttribute("db");
  User user = (User) session.getAttribute("loggedInUser");

  if (user == null || dao == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  List<PaymentMethod> methods = dao.PaymentMethods().getMethodsByUserId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IoT Store - Register</title>
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>

<%@ include file="../Components/navbar.jsp" %>

<main class="select-payment-method-container">
  <div class = "select-payment">
    <h1>Your Payment Methods</h1>

    <%
      if (methods == null || methods.isEmpty()) {
    %>
    <p>You don't have any saved payment methods.</p>
    <%
    } else {
    %>
    <table class = "order-history-table">
      <thead>
      <tr>
        <th>Type</th>
        <th>Card Number</th>
        <th>Name on Card</th>
        <th>Expiry</th>
        <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <% for (PaymentMethod method : methods) { %>
      <tr>
        <td><%= method.getType() %></td>
        <td>
          <%= method.getCardNumber() != null && method.getCardNumber().length() >= 4
                  ? "**** **** **** " + method.getCardNumber().substring(method.getCardNumber().length() - 4)
                  : "N/A" %>
        </td>
        <td><%= method.getNameOnCard() != null ? method.getNameOnCard() : "N/A" %></td>
        <td><%= method.getExpiry() != null ? method.getExpiry() : "N/A" %></td>
        <td>
          <a href="editPaymentDetails.jsp?methodId=<%= method.getMethodId() %>">Edit</a>
          |
          <a href="<%= request.getContextPath() %>/DeletePaymentMethodServlet?methodId=<%= method.getMethodId() %>"
             onclick="return confirm('Are you sure you want to delete this payment method?');">Delete</a>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
    <%
      }
    %>

    <div class="link-button">

      <br>
      <a href="<%= request.getContextPath() %>/accountSettings.jsp" class="link-button">← Back to Account Settings</a>

      <div style="margin-top: 20px; font-size: large; text-align: center; ">
        <a href="addNewPaymentMethod.jsp" class="link-button" style="color: white;  padding: 5px">➕ Add New Payment Method</a>
      </div>


    </div>
  </div>
</main>

</body>
</html>