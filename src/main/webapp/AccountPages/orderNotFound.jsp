<%--
  Created by IntelliJ IDEA.
  User: Nguyen Tran
  Date: 5/27/2025
  Time: 5:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../Components/navbar.jsp" %>

<%
  String id = request.getParameter("orderId");
%>
<div style="text-align:center; padding: 50px;">
  <h1>Order Not Found</h1>
  <p>Sorry, we couldn’t find Order ID <strong><%= id %></strong>.<br/>
    Please check the number and try again.</p>
  <a href="<%= request.getContextPath() %>/OrderHistoryServlet"
     class="register-button">Back to Order History</a>
</div>

<%@ include file="../Components/footer.jsp" %>