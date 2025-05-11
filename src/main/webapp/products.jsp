<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.IoTBay.model.Product" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");
    List<Product> all = dao.Products().getAllProducts();

    request.setAttribute("products", all);
    request.setAttribute("isAdmin", user!=null && user.getAdmin());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Products – IoT Bay</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<jsp:include page="Components/navbar.jsp" />

<h1 style="text-align:center;">All Products</h1>
<jsp:include page="Components/productGrid.jsp" />
</body>
</html>
