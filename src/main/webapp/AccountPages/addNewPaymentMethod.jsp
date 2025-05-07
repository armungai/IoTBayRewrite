<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");

    if (dao == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Payment Method</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>

<body>
<%@ include file="../Components/navbar.jsp" %>

<main class="register-container">
    <section class="register-section">
        <h1>Add New Payment Method</h1>

        <form action="<%= request.getContextPath() %>/AddPaymentMethodServlet" method="post" class="login-form">

            <div class="form-group">
                <label for="method">Payment Method:</label>
                <select id="method" name="method" required>
                    <option value="" disabled selected>Select payment method</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Debit Card">Debit Card</option>
                    <option value="PayPal">PayPal</option>
                    <option value="Bank Transfer">Bank Transfer</option>
                </select>
            </div>

            <div class="form-group">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" placeholder="Enter card number">
            </div>

            <div class="form-group">
                <label for="nameOnCard">Name on Card:</label>
                <input type="text" id="nameOnCard" name="nameOnCard" placeholder="Enter name as on card">
            </div>

            <div class="form-group">
                <label for="expiry">Expiry Date:</label>
                <input type="month" id="expiry" name="expiry">
            </div>

            <div class="form-group">
                <label for="cvv">CVV:</label>
                <input type="password" id="cvv" name="cvv" placeholder="Enter CVV">
            </div>

            <div class="form-group">
                <button type="submit"  class="btn btn-secondary"style="width: 220px"> Confirm Payment Method</button>
            </div>
            <div class="form-group">
            <button type="submit"  class="btn btn-secondary" style="width: 250px">
                <a href="<%= request.getContextPath() %>/AccountPages/SelectPaymentMethodToEdit.jsp">← Back to Payment Methods</a>
            </button>
            </div>
        </form>
    </section>
</main>

</body>
</html>
