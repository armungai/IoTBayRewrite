
<%@include file="Components/navbar.jsp"%>
<%
    String logoutStatus = request.getParameter("logout");
%>
<% if ("success".equals(logoutStatus)) { %>
<script>
    alert("You have been logged out successfully.");
    // Optional: remove the query from the URL so it doesn't trigger on refresh
    window.history.replaceState(null, null, window.location.pathname);
</script>
<% } %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Welcome to IoT Bay!</title>
        <link rel="stylesheet" href="assets/styles.css">
    </head>
    <body>
    <div class="welcome-heading">
        <h1>Welcome to IoT Bay</h1>
        <h2>Your one-stop shop for all things smart!</h2>
    </div>

    <div class="login-signup-card-container">
        <div class="login-signup-card">
            <h1>Login</h1>



            <form action="LoginServlet" method="post" class="login-form">
                <div class="login-signup-form-field">
                    <label for="email">Email Address</label><br>
                    <input type="email" id="email" name="email" required placeholder="Enter your email">
                </div>
                <br>
                <div class="login-signup-form-field">
                    <label for="password">Password</label><br>
                    <input type="password" id="password" name="password" required placeholder="Password">
                </div>
                <br>
                <%
                    String error = request.getParameter("error");
                    if ("1".equals(error)) {
                %>
                <p style="color:red;">Invalid email or password.</p>
                <%
                    }
                %>

                <button type="submit" class="register-button">Login</button>

                <br>
                <div class="login-and-signup-container">
                    <p>New Here? <a href="register.jsp" class ="register-button">Register now!</a></p>
                </div>
            </form>

            <p class="continue-wo-signing-in">
                <a href="products.jsp">Continue without signing in</a>
            </p>
        </div>
    </div>
    </body>
</html>