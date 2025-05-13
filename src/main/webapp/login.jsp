<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login – IoT Bay</title>
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
            margin-bottom: 8px;
        }
        .login-card button {
            background-color: #ff9800;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            color: white;
            cursor: pointer;
            font-size: 1rem;
        }
        .login-card .error {
            background: #a00000;
            padding: 8px;
            border-radius: 4px;
            margin-bottom: 12px;
            text-align: center;
        }
        .login-card a {
            color: #ff9800;
            text-decoration: none;
        }
        .login-card a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<jsp:include page="Components/navbar.jsp"/>

<div class="login-card">
    <h1>Login</h1>

    <%
        HttpSession s = request.getSession(false);
        String err = null;
        if (s!=null) {
            err = (String)s.getAttribute("loginError");
            s.removeAttribute("loginError");
        }
        if (err != null) {
    %>
    <div class="error"><%= err %></div>
    <% } %>

    <form action="LoginServlet" method="post">
        <label for="email">Email Address</label>
        <input id="email" type="text" name="email" placeholder="Enter your email" required/>

        <label for="pwd">Password</label>
        <input id="pwd" type="password" name="password" placeholder="Password" required/>

        <button type="submit">Login</button>
    </form>

    <p style="margin-top:12px;">
        New here? <a href="register.jsp">Register now!</a><br>
        <a href="home.jsp" style="color:#bbb; font-size:.9em;">Continue without signing in</a>
    </p>
</div>
</body>
</html>
