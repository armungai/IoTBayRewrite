<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>IoT Bay – Login</title>
    <link rel="stylesheet" href="assets/styles.css">

</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<div class="login-card">
    <h1>Login</h1>
    <%
        HttpSession sess = request.getSession(false);
        String err = null;
        if (sess != null) {
            err = (String) sess.getAttribute("loginError");
            sess.removeAttribute("loginError");
        }
        if (err != null) {
    %>
    <div class="error"><%= err %></div>
    <% } %>

    <form action="LoginServlet" method="post">
        <label for="email">Email Address</label>
        <input
                type="email"
                id="email"
                name="email"
                required
                placeholder="you@example.com"
                value="<%= request.getParameter("email") == null ? "" : request.getParameter("email") %>"
        />

        <label for="password">Password</label>
        <input
                type="password"
                id="password"
                name="password"
                required
                placeholder="***********"
        />

        <button type="submit">Login</button>
    </form>

    <div class="links">
        <a href="register.jsp">Register</a> |
        <a href="product.jsp">Continue as Guest</a>
    </div>
</div>

<%@ include file="Components/footer.jsp" %>
</body>
</html>
