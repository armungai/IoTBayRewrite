<%--

  Created by IntelliJ IDEA.
  User: andrewmungai
  Date: 6/5/2025
  Time: 2:45 pm
--%>
<%@ page import="com.IoTBay.model.*, com.IoTBay.model.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<%

    // GETTING THE DAO and USER IN SESSION
    DAO dao = (DAO) session.getAttribute("db");
    User user = (User) session.getAttribute("loggedInUser");

    // ERROR HANDLING FOR NULL USER AND NULL DAO
    if (dao == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // GETTING OUT PARAMETERS
    String searchIdStr = request.getParameter("paymentId"); // return from "seach by payment-id" form
    String userIdStr = request.getParameter("userId"); // return from "search by user-id" form
    String filterDate = request.getParameter("filterDate"); // return from "filter by date" form
    String sort = request.getParameter("sort"); // return from "sort-by" form

    List<Payment> paymentsGeneric = new ArrayList<>(); // the list of payments that we are going to construct

    try {
        // determine base list (what we will be working with
        if (searchIdStr != null && !searchIdStr.trim().isEmpty()) {
            // SEARCH BY PAYMENT-ID
            int paymentId = Integer.parseInt(searchIdStr.trim());
            Payment p = dao.Payments().getPaymentById(paymentId);
            if (p != null) paymentsGeneric.add(p);
            // ADMIN SEARCH BY USER-ID
        } else if (user.getAdmin() && userIdStr != null && !userIdStr.trim().isEmpty()) {
            int searchUserId = Integer.parseInt(userIdStr.trim()); // from the "search by user-id form"
            paymentsGeneric = dao.Payments().getPaymentsByUserId(searchUserId); // returns all payments that have specified user id
        } else {
            // default: user views their own payments or admin views all payments in the database
            paymentsGeneric = user.getAdmin() ? dao.Payments().getAllPayments() : dao.Payments().getPaymentsByUserId(user.getId());
        }

        // then we apply the filter date
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        if ((startDate != null && !startDate.trim().isEmpty()) || (endDate != null && !endDate.trim().isEmpty())) {
            List<Payment> filteredPayments = new ArrayList<>();
            for (Payment p : paymentsGeneric) {
                if (p.getDate() != null) {
                    String paymentDate = p.getDate().trim().substring(0, 10); // yyyy-MM-dd

                    boolean isAfterOrEqualStart = (startDate == null || startDate.isEmpty()) || paymentDate.compareTo(startDate) >= 0;
                    boolean isBeforeOrEqualEnd = (endDate == null || endDate.isEmpty()) || paymentDate.compareTo(endDate) <= 0;

                    if (isAfterOrEqualStart && isBeforeOrEqualEnd) {
                        filteredPayments.add(p);
                    }
                }
            }
            paymentsGeneric = filteredPayments;
        }


        // Apply sorting
        if ("asc".equals(sort)) {
            paymentsGeneric.sort((a, b) -> a.getDate().compareTo(b.getDate()));
        } else if ("desc".equals(sort)) {
            paymentsGeneric.sort((a, b) -> b.getDate().compareTo(a.getDate()));
        } else if ("asc-price".equals(sort)) {
            paymentsGeneric.sort((a, b) -> Double.compare(a.getAmount(), b.getAmount()));
        } else if ("desc-price".equals(sort)) {
            paymentsGeneric.sort((a, b) -> Double.compare(b.getAmount(), a.getAmount()));
        }

    } catch (NumberFormatException | SQLException e) {
        paymentsGeneric = new ArrayList<>(); // fallback
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Payments</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>

<%@ include file="../Components/navbar.jsp" %>
<h1 style="text-align:center;">Payment History</h1>
<div class="payment-controls-container">

    <form method="get" action="paymentHistory.jsp" class="search-form">
        <label for="search">Search by Payment ID:</label>
        <input type="text" id="search" class="search-payment" name="paymentId" placeholder="Enter payment ID" value="<%= (searchIdStr != null) ? searchIdStr : "" %>">
        <input type="hidden" name="sort" value="<%= (sort != null) ? sort : "" %>">
        <button type="submit">Search</button>

        <% if (user.getAdmin()) { %>
        <br>
        <label for="searchUser">Search By User ID:</label>
        <input type="text" id="searchUser" class="search-payment" name="userId" placeholder="Enter user ID"
               value="<%= request.getParameter("userId") != null ? request.getParameter("userId") : "" %>">
        <button type="submit">Search</button>
        <% } %>
    </form>

    <form method="get" action="paymentHistory.jsp" class="filter-form">
        <input type="hidden" name="paymentId" value="<%= request.getParameter("paymentId") != null ? request.getParameter("paymentId") : "" %>">
        <input type="hidden" name="userId" value="<%= request.getParameter("userId") != null ? request.getParameter("userId") : "" %>">

        <label for="start-date">Start Date</label>
        <input type="date" id="start-date" name="startDate"
               value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>">

        <label for="end-date">End Date</label>
        <input type="date" id="end-date" name="endDate"
               value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>">
        <button type="submit">Filter</button>
    </form>

    <form method="get" action="paymentHistory.jsp" class="sort-form">
        <input type="hidden" name="paymentId" value="<%= (searchIdStr != null) ? searchIdStr : "" %>">
        <input type="hidden" name="userId" value="<%= (userIdStr != null) ? userIdStr : "" %>">
        <input type="hidden" name="startDate" value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>">
        <input type="hidden" name="endDate" value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>">

        <label for="sort">Sort by:</label>
        <select name="sort" id="sort" onchange="this.form.submit()" class="sort-select">
            <option value="">-- Select --</option>
            <option value="asc" <%= "asc".equals(sort) ? "selected" : "" %>>Date (Oldest to Newest)</option>
            <option value="desc" <%= "desc".equals(sort) ? "selected" : "" %>>Date (Newest to Oldest)</option>
            <option value="asc-price" <%= "asc-price".equals(sort) ? "selected" : "" %>>Price (Lowest to Highest)</option>
            <option value="desc-price" <%= "desc-price".equals(sort) ? "selected" : "" %>>Price (Highest to Lowest)</option>
        </select>
    </form>

    <div class="reset-button">
        <a class="search-payment" href="paymentHistory.jsp">Reset</a>
    </div>
    <% if (paymentsGeneric.isEmpty()) { %>
    <div class="no-payments-message">
        No payments found for the current filter/search.
    </div>
    <% } %>

</div>



<table class="order-history-table" style="margin-bottom: 50px">
    <tr>
        <%if (user.getAdmin()){ %>
        <th>User Id</th>
        <% }%>
        <th>Payment ID</th>
        <th>Method</th>
        <th>Amount</th>
        <th>Date</th>
        <th>Status</th>
        <th>Actions</th>

    </tr>
    <% for (Payment payment : paymentsGeneric) { %>
    <%PaymentMethod pm = dao.PaymentMethods().get(payment.getMethodId());%>
    <tr>
        <%if (user.getAdmin()){ %>
        <td><%=payment.getUserId()%></td>
        <% }%>
        <td><%= payment.getPaymentId() %></td>
        <td>
            <%=pm.getCardNumber() != null && pm.getCardNumber().length() >= 4
                    ? "**** **** **** " + pm.getCardNumber().substring(pm.getCardNumber().length() - 4)
                    : "N/A" %>
        </td>
        <td>$<%= String.format("%.2f", payment.getAmount()) %></td>
        <td><%= payment.getDate() %></td>
        <td><%= payment.getStatus() %></td>
        <td>
            <a href="<%= request.getContextPath() %>/DeletePaymentServlet?paymentId=<%= payment.getPaymentId() %>"
               onclick="return confirm('Are you sure you want to delete this payment?');">Delete</a>
        </td>
    </tr>
    <% } %>
</table>
</div>
</body>

<%@ include file="../Components/footer.jsp" %>
</html>
