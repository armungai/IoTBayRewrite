<%@ page import="com.IoTBay.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections, java.util.Comparator" %>

<%-- Sorting the existing 'products' list passed in by the parent JSP --%>
<%
  String sortParam = request.getParameter("sort");

  if (sortParam != null) {
    switch (sortParam) {
      case "price-htl":
        products.sort(Comparator.comparing(Product::getPrice).reversed());
        break;
      case "price-lth":
        products.sort(Comparator.comparing(Product::getPrice));
        break;
      case "alphabetically-atz":
        products.sort(Comparator.comparing(Product::getProductName, String.CASE_INSENSITIVE_ORDER));
        break;
      case "alphabetically-zta":
        products.sort(Comparator.comparing(Product::getProductName, String.CASE_INSENSITIVE_ORDER).reversed());
        break;
    }
  }
%>


<div class="sort-bar navbar" style="background-color: #666666">
  <form method="get" action="<%= request.getRequestURI() %>">
    <label for="filter-option" style="margin-right: 20px">Sort & Filter:</label>
    <select id="filter-option" name="sort" onchange="this.form.submit()" required style="padding: 5px; border-radius: 5px">
      <option value="" disabled <%= request.getParameter("sort") == null ? "selected" : "" %>>Sort By</option>
      <option value="price-htl" <%= "price-htl".equals(request.getParameter("sort")) ? "selected" : "" %>>Price (High - Low)</option>
      <option value="price-lth" <%= "price-lth".equals(request.getParameter("sort")) ? "selected" : "" %>>Price (Low - High)</option>
      <option value="alphabetically-atz" <%= "alphabetically-atz".equals(request.getParameter("sort")) ? "selected" : "" %>>(A - Z)</option>
      <option value="alphabetically-zta" <%= "alphabetically-zta".equals(request.getParameter("sort")) ? "selected" : "" %>>(Z - A)</option>
    </select>
  </form>
</div>

<div class="product-grid">
  <% for (Product product : products) { %>
  <div class="product-card">
    <a href="product.jsp?productId=<%= product.getProductID() %>" style="text-decoration: none; color: inherit;">
      <img src="<%= product.getProductImageAddress() %>" alt="Product image">
      <div class="product-card-content">
        <h3><%= product.getProductName() %></h3>
        <p class="product-price">$<%= product.getPrice() %></p>
        <p> <%=product.getProductDescription()%></p>
      </div>
    </a>
  </div>
  <% } %>
</div>
