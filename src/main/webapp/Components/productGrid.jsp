<%@ page import="com.IoTBay.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%@ page import="com.IoTBay.model.User" %>

<%
  List<Product> products = (List<Product>) request.getAttribute("products");
  Boolean isAdmin = (Boolean) request.getAttribute("isAdmin");
  if (products == null || products.isEmpty()) {
%>
<p>No products available.</p>
<%
    return;
  }

  User me = (User) session.getAttribute("loggedInUser");
%>

<% if (me != null && me.getAdmin()) { %>
<div style="text-align:left; margin:1em 0;">
  <a href="addDevice.jsp" class="btn">➕ Add New Device</a>
</div>
<% } %>

<!-- Product grid -->
<div class="product-grid">
  <% for (Product p : products) { %>
  <div class="product-card">
    <a href="product.jsp?productId=<%= p.getProductID() %>" style="text-decoration:none; color:inherit;">
      <img src="<%= p.getProductImageAddress() %>" alt="<%= p.getProductName() %>" />
      <div class="product-card-content">
        <h3><%= p.getProductName() %></h3>
        <p class="product-price">$<%= String.format("%.2f", p.getPrice()) %></p>
        <p><%= p.getProductDescription() %></p>
      </div>
    </a>

    <% if (Boolean.TRUE.equals(isAdmin)) { %>
    <div class="admin-buttons">
      <a href="addDevice.jsp" class="btn-add">Add</a>
      <a href="EditDeviceLoaderServlet?id=<%= p.getProductID() %>" class="btn btn-warning">Edit</a>
      <a href="DeleteDeviceServlet?id=<%= p.getProductID() %>" class="btn btn-danger" onclick="return confirm('Delete this device?');">Delete</a>
    </div>
    <% } %>
  </div>
  <% } %>
</div>
