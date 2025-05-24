<%--
  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 6/5/2025
  Time: 2:37 pm
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Cart</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<%@ include file="Components/navbar.jsp" %>--%>
<%--<div class="empty-cart-message">--%>
<%--    <h1>Your Cart is Empty</h1>--%>
<%--    <p>Looks like you haven't added anything yet.</p>--%>
<%--</div>--%>
<%--<%@ include file="Components/footer.jsp" %>--%>
<%--</body>--%>
<%--</html>--%>

<!DOCTYPE html><html><head><title>Empty Cart</title></head><body>
<jsp:include page="Components/navbar.jsp"/>
<h2>Your cart is empty.</h2>
<a href="productGrid.jsp">Continue Shopping</a>
<jsp:include page="Components/footer.jsp"/>
</body></html>

