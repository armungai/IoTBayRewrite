<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>IoT Bay – Login</title>
    <link rel="stylesheet" href="assets/styles.css">
    <style>
        .login-card {
            max-width: 400px;
            margin: 60px auto;
            background: #2c2c2c;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            color: white;
        }
        .login-card h1 { margin-top: 0; }
        .login-card label { display: block; margin: 12px 0 4px; }
        .login-card input {
            width: 100%;
            padding: 8px;
            border-radius: 4px;
            border: none;
            margin-bottom: 12px;
        }
        .login-card button {
            background-color: #ff9800;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            color: white;
            cursor: pointer;
            font-size: 1rem;
            width: 100%;
        }
        .login-card .error {
            background: #a00000;
            padding: 8px;
            border-radius: 4px;
            margin-bottom: 16px;
            text-align: center;
        }
        .login-card .links {
            text-align: center;
            margin-top: 16px;
        }
        .login-card .links a {
            color: #ff9800;
            text-decoration: none;
            margin: 0 8px;
        }
        .login-card .links a:hover { text-decoration: underline; }
    </style>
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
