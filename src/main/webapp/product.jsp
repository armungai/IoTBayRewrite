<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
  DAO dao = (DAO) session.getAttribute("db");
  if (dao == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  String productIdParam = request.getParameter("productId");
  if (productIdParam == null) {
    response.sendRedirect("products.jsp");
    return;
  }

  int productId = Integer.parseInt(productIdParam);
    Product product = null;
    try {
        product = dao.Products().getById(productId);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }

    if (product == null) {
    response.getWriter().write("Product not found.");
    return;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= product.getProductName() %></title>
  <link rel="stylesheet" href="assets/styles.css">

</head>
<body>

<%@ include file="Components/navbar.jsp" %>

<div class="product-detail-container">
  <img src="<%= product.getProductImageAddress() %>" alt="Product Image">
  <div class="product-detail-content">
    <h1><%= product.getProductName() %></h1>
    <p class="product-price"><strong>$<%= product.getPrice() %></strong></p>
    <p><%= product.getProductDescription() %></p>

    <form action="<%= request.getContextPath() %>/AddToCartServlet" method="post">
      <input type="hidden" name="productId" value="<%= product.getProductID() %>">
      <label for="quantity">Quantity:</label>
      <input type="number" id="quantity" name="quantity" value="1" min="1" class="quantity-input" required>
      <br><br>
      <button type="submit" class="register-button" style="width: 150px">Add to Cart 🛒</button>
    </form>
  </div>
</div>
<%@ include file="Components/footer.jsp" %>
</body>
</html>
