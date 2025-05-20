<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
  DAO dao = (DAO) session.getAttribute("db");
  User user = (User) session.getAttribute("loggedInUser");

  if (dao == null || user == null) {
    response.sendRedirect("../login.jsp");
    return;
  }

  String shipmentIdParam = request.getParameter("shipmentId");
  String fromDate = request.getParameter("fromDate");
  String toDate = request.getParameter("toDate");

  List<Shipment> shipments = dao.Shipments().getByUserId(user.getId());

  if ((shipmentIdParam != null && !shipmentIdParam.isEmpty()) ||
          (fromDate != null && !fromDate.isEmpty()) ||
          (toDate != null && !toDate.isEmpty())) {

    List<Shipment> filtered = new ArrayList<>();

    for (Shipment s : shipments) {
      boolean matches = true;

      if (shipmentIdParam != null && !shipmentIdParam.isEmpty()) {
        try {
          int searchId = Integer.parseInt(shipmentIdParam);
          if (s.getShipmentId() != searchId) matches = false;
        } catch (NumberFormatException e) {
          matches = false;
        }
      }

      if (fromDate != null && !fromDate.isEmpty() && s.getShippingDate().compareTo(fromDate) < 0) {
        matches = false;
      }

      if (toDate != null && !toDate.isEmpty() && s.getShippingDate().compareTo(toDate) > 0) {
        matches = false;
      }

      if (matches) filtered.add(s);
    }

    shipments = filtered;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Shipment History</title>
  <link rel="stylesheet" href="../assets/styles.css">
  <style>
    .search-bar {
      display: flex;
      justify-content: end;
      align-items: center;
      gap: 10px;
      margin: 20px 0;
    }

    .search-bar input[type="text"],
    .search-bar input[type="date"],
    .search-bar button,
    .search-bar a.reset-button {
      padding: 6px 10px;
      border-radius: 6px;
      border: 1px solid #ccc;
      font-size: 14px;
    }

    .search-bar button {
      background-color: orange;
      color: white;
      border: none;
      font-weight: bold;
    }

    .search-bar input[name="shipmentId"] {
      width: 80px;
    }

    .search-bar .reset-button {
      background-color: #eee;
      text-decoration: none;
      color: #000;
      font-weight: bold;
      padding: 6px 12px;
    }

    .order-history-table {
      width: 100%;
      border-collapse: collapse;
    }

    .order-history-table th, .order-history-table td {
      padding: 10px 15px;
      text-align: center;
    }

    .order-history-table th:last-child,
    .order-history-table td:last-child {
      text-align: right;
    }

    .order-history-table td:nth-child(3) {
      max-width: 300px;
      word-break: break-word;
    }
  </style>
</head>
<body>

<%@ include file="../Components/navbar.jsp" %>

<h1 style="text-align:center;">Shipment History</h1>

<div style="width: 80%; margin: 0 auto;" class="view-all-data">

  <form method="get" class="search-bar">
    Shipment ID:
    <input type="text" name="shipmentId" placeholder="e.g. 105" value="<%= shipmentIdParam != null ? shipmentIdParam : "" %>">
    From:
    <input type="date" name="fromDate" value="<%= fromDate != null ? fromDate : "" %>">
    To:
    <input type="date" name="toDate" value="<%= toDate != null ? toDate : "" %>">
    <button type="submit">Search</button>
    <a href="viewShipmentHistory.jsp" class="reset-button">Reset</a>
  </form>

  <% if (shipments.isEmpty()) { %>
  <p style="text-align:center;">You haven’t had any shipments yet.</p>
  <% } else { %>
  <table class="order-history-table">
    <tr>
      <th>Shipment ID</th>
      <th>Order ID</th>
      <th>Address</th>
      <th>Method</th>
      <th>Date</th>
    </tr>
    <% for (Shipment s : shipments) { %>
    <tr>
      <td><%= s.getShipmentId() %></td>
      <td><%= s.getOrderId() %></td>
      <td><%= s.getAddress() %></td>
      <td><%= s.getShippingMethod() %></td>
      <td><%= s.getShippingDate() %></td>
    </tr>
    <% } %>
  </table>
  <% } %>

</div>
<%@ include file="/Components/footer.jsp" %>
</body>
</html>