
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IoTBay Login</title>
    <link rel="stylesheet" href="assets/styles.css">

</head>
<body>
    <div class="login-signup-card-container">
        <div class="login-signup-card">
            <h1>
                Login
            </h1>
            <form action="LoginServlet" method="post" class="login-form">
                <div class="login-signup-form-field">
                    <label for="email">Email Address</label><br>
                    <input type="email" id="email" name="email" required placeholder="Enter your email">
                </div>
                <br>
                <div class="login-signup-form-field">
                    <label for="password">Password</label><br>
                    <input type="password" id="password" name="email" required placeholder="Password">
                </div>
                <%
                    String error = request.getParameter("error");
                    if ("1".equals(error)) {
                %>
                <p style="color:red;">Invalid email or password.</p>
                <%
                    }
                %>
                <div class ="login-and-signup-container">
                    <a href="home.jsp">Login</a>
                    <a href="register.jsp">Register</a>
                </div>
            </form>
            <p class="continue-wo-signing-in"> <a href="products.jsp">continue without signing in</a> </p>
        </div>
    </div>
</body>
</html>