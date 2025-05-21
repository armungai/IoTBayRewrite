<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.IoTBay.model.Product" %>
<%@ page import="java.sql.SQLException" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    if (dao == null) {
        try {
            dao = new DAO(); // Or however you instantiate i
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        session.setAttribute("db", dao);
    }
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

<%@ include file="Components/productGrid.jsp" %>
<%@ include file="Components/footer.jsp" %>
</body>
</html>
