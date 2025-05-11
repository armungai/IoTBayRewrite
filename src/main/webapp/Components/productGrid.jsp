<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Collections" %>
<%@ page import="com.IoTBay.model.Product, com.IoTBay.model.User, com.IoTBay.model.dao.DAO" %>
<%@ page session="true" %>

<%
  DAO dao = (DAO) session.getAttribute("db");
  User me = (User) session.getAttribute("loggedInUser");

  List<Product> products = Collections.emptyList();
  if (dao != null) {
    products = dao.Products().getAllProducts();
  }
%>

<% if (me != null && me.getAdmin()) { %>
<div style="text-align:left; margin:1em 0;">
  <a href="addDevice.jsp" class="btn">➕ Add New Device</a>
</div>
<% } %>

<div class="product-grid">
  <% for (Product p : products) { %>
  <div class="product-card">
    <% if (me == null || !me.getAdmin()) { %>
    <a href="product.jsp?productId=<%=p.getProductID()%>">
      <img src="<%=p.getProductImageAddress()%>" alt="<%=p.getProductName()%>"/>
    </a>
    <% } else { %>
    <img src="<%=p.getProductImageAddress()%>" alt="<%=p.getProductName()%>"/>
    <% } %>

    <h3><%= p.getProductName() %></h3>
    <p class="product-price">$<%= String.format("%.2f", p.getPrice()) %></p>
    <p><%= p.getProductDescription() %></p>

    <% if (me == null || !me.getAdmin()) { %>
    <form action="AddToCartServlet" method="post">
      <input type="hidden" name="productId" value="<%= p.getProductID() %>"/>
      <input type="hidden" name="quantity"  value="1"/>
      <button type="submit" class="btn">Add to Cart</button>
    </form>
    <% } %>

      <div class="product-actions">
        <% if (me != null && me.getAdmin()) { %>
        <a href="EditDeviceServlet?productId=<%=p.getProductID()%>" class="btn btn-edit">Edit</a>
        <a href="DeleteDeviceServlet?productId=<%=p.getProductID()%>" class="btn btn-delete">Delete</a>
        <% } %>
      </div>
  </div>
  <% } %>
</div>


