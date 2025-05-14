<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.IoTBay.model.Product" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    if (dao == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Product> products = dao.Products().getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IoTBay Products</title>
    <link rel="stylesheet" href="assets/styles.css">

</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<h1 style="text-align:center;">All Products</h1>

<%@ include file="Components/productGrid.jsp" %>
<%@ include file="Components/footer.jsp" %>

</body>
</html>