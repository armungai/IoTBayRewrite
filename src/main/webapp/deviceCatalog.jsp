<%--
  Created by IntelliJ IDEA.
  User: Nguyen Tran
  Date: 5/12/2025
  Time: 2:22 AM
--%>
<%@ page import="java.util.*, com.IoTBay.model.Product, com.IoTBay.model.dao.DAO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
  DAO dao = (DAO) session.getAttribute("db");
  if (dao == null) {
%>
<p style="text-align:center; color:darkred;">
  <em>Database connection not available.</em>
</p>
<%
    return;
  }

  String searchName = request.getParameter("searchName");
  String searchType = request.getParameter("searchType");
  if (searchName == null) searchName = "";
  if (searchType == null) searchType = "";

  List<Product> filtered = new ArrayList<>();
  try {
    List<Product> all = dao.Products().getAllProducts();
    for (Product p : all) {
      boolean matchName = p.getProductName()
              .toLowerCase()
              .contains(searchName.toLowerCase());
      boolean matchType = p.getProductDescription()
              .toLowerCase()
              .contains(searchType.toLowerCase());
      if (matchName && matchType) {
        filtered.add(p);
      }
    }
  } catch (Exception e) {
%>
<p style="text-align:center; color:darkred;">
  <em>Error loading products: <%= e.getMessage() %></em>
</p>
<%
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>IoTBay Device Catalogue</title>
  <link rel="stylesheet" href="assets/styles.css">
  <style>
    .search-form {
      text-align: center;
      margin: 20px 0;
    }
    .search-form input {
      padding: 8px;
      width: 180px;
      border-radius: 4px;
      border: 1px solid #ccc;
      margin-right: 8px;
    }
    .search-form button {
      padding: 8px 16px;
      border: none;
      background: #ff9800;
      color: #fff;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 500;
    }
    .search-form button:hover {
      background: #e68a00;
    }
  </style>
</head>
<body>
<jsp:include page="Components/navbar.jsp" />

<h1 style="text-align:center;">IoT Device Catalogue</h1>

<form method="get" action="deviceCatalog.jsp" class="search-form">
  <input
          type="text"
          name="searchName"
          placeholder="Search by name"
          value="<%= searchName %>"/>
  <input
          type="text"
          name="searchType"
          placeholder="Search by type"
          value="<%= searchType %>"/>
  <button type="submit">Search</button>
</form>

<!-- 5) Grid of product cards -->
<div class="product-grid">
  <% for (Product p : filtered) { %>
  <div class="product-card">
    <img
            src="<%= p.getProductImageAddress() %>"
            alt="<%= p.getProductName() %>" />
    <div class="product-card-content">
      <h3><%= p.getProductName() %></h3>
      <p class="product-price">
        $<%= String.format("%.2f", p.getPrice()) %>
      </p>
      <p><%= p.getProductDescription() %></p>
    </div>
  </div>
  <% } %>
</div>
</body>
</html>

