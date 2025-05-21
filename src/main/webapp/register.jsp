<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IoT Store - Register</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>

<main class="register-container">
    <section class="register-section">
        <h1>Create Your Account</h1>

        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" class="login-form">
            <div class="form-group">
                <label for="email">Email address:</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required placeholder="Create your password">
            </div>

            <div class="form-group">
                <label for="firstname">First Name:</label>
                <input type="text" id="firstname" name="firstname" required placeholder="Enter your first name">
            </div>

            <div class="form-group">
                <label for="lastname">Last Name:</label>
                <input type="text" id="lastname" name="lastname" required placeholder="Enter your last name">
            </div>

            <div class="form-group">
                <label for="mobile">Phone Number:</label>
                <input type="tel" id="mobile" name="mobile" required placeholder="Enter your phone number">
            </div>

            <div class="form-group">
                <label for="street">Street Address:</label>
                <input type="text" id="street" name="street" required placeholder="Enter street address">
            </div>
            <div class="form-group">
                <label for="city">City:</label>
                <input type="text" id="city" name="city" required placeholder="Enter city">
            </div>
            <div class="form-group">
                <label for="state">State:</label>
                <select id="state" name="state" required>
                    <option value="" disabled selected>Select a state</option>
                    <option value="NSW">NSW</option>
                    <option value="VIC">VIC</option>
                    <option value="TAS">TAS</option>
                    <option value="QLD">QLD</option>
                    <option value="WA">WA</option>
                    <option value="SA">SA</option>
                </select>
            </div>
            <div class="form-group">
                <button type="submit" class="register-button" >Register</button>
            </div>
            <p>Already have an account? <a href="index.jsp" class="login-here">Login here</a></p>
        </form>

    </section>
</main>
</body>
</html>
