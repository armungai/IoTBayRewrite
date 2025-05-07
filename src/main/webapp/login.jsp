


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
            <div class ="login-and-signup-container">
                <a href="home.jsp">Login</a>
                <a href="register.jsp">Register</a>
            </div>
        </form>
        <p class="continue-wo-signing-in"> <a href="products.jsp">continue without signing in</a> </p>
    </div>
</div>