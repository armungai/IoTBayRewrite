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

    String methodIdParam = request.getParameter("methodId");
    if (methodIdParam == null) {
        response.sendRedirect("accountSettings.jsp");
        return;
    }

    int methodId = Integer.parseInt(methodIdParam);
    PaymentMethod method = dao.PaymentMethods().get(methodId);


%>



<head>
    <meta charset="UTF-8">
    <title>Edit Payment Details</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>


<body>
<%@ include file="../Components/navbar.jsp" %>

<main class="register-container">
    <section class="register-section">
        <h1>Edit Your Payment Details</h1>

        <form action="<%= request.getContextPath() %>/EditPaymentServlet" method="post" class="login-form">
            <input type="hidden" name="methodId" value="<%= method.getMethodId() %>">

            <div class="form-group">
                <label for="method">Payment Method:</label>
                <select id="method" name="method" required>
                    <option value="" disabled>Select payment method</option>
                    <option value="Credit Card" <%= "Credit Card".equals(method.getType()) ? "selected" : "" %>>Credit Card</option>
                    <option value="Debit Card" <%= "Debit Card".equals(method.getType()) ? "selected" : "" %>>Debit Card</option>
                    <option value="PayPal" <%= "PayPal".equals(method.getType()) ? "selected" : "" %>>PayPal</option>
                    <option value="Bank Transfer" <%= "Bank Transfer".equals(method.getType()) ? "selected" : "" %>>Bank Transfer</option>
                </select>
            </div>

            <div class="form-group">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" value="<%= method.getCardNumber() != null ? method.getCardNumber() : "" %>" required>
            </div>

            <div class="form-group">
                <label for="nameOnCard">Name on Card:</label>
                <input type="text" id="nameOnCard" name="nameOnCard" value="<%= method.getNameOnCard() != null ? method.getNameOnCard() : "" %>" required>
            </div>

            <div class="form-group">
                <label for="expiry">Expiry Date:</label>
                <input type="month" id="expiry" name="expiry" value="<%= method.getExpiry() != null ? method.getExpiry() : "" %>" required>
            </div>

            <div class="form-group">
                <label for="cvv">CVV:</label>
                <input type="password" id="cvv" name="cvv" value="<%= method.getCvv() != null ? method.getCvv() : "" %>" required>
            </div>

            <div class="form-group">
                <button type="submit" class="register-button">Update Payment</button>
            </div>
        </form>
    </section>
</main>
</body>