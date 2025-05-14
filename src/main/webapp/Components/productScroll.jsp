<%@ page import="com.IoTBay.model.PaymentMethod" %>
<%@ page import="com.IoTBay.model.dao.DAO" %>
<%@ page import="com.IoTBay.model.Product" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 13/5/2025
  Time: 7:49 pm
  To change this template use File | Settings | File Templates.

--%>
<%
  DAO dao = (DAO) session.getAttribute("db");
  List<Product> products = dao.Products().getAllProducts();
%>


<link rel="stylesheet" href="assets/styles.css">

<div class="product-scrolling-banner">
  <div class="product-scroll-track">
    <% for (Product product : products) { %>
    <div class="product-scroll-item">
      <a href="product.jsp?productId=<%= product.getProductID() %>" style="text-decoration: none; color: inherit;">
        <img src="<%= product.getProductImageAddress() %>" alt="Product image">
        <div class="">
          <h3><%= product.getProductName() %></h3>
        </div>
      </a>
    </div>
    <% } %>
  </div>
</div>
