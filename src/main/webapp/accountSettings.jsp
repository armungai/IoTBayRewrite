<%--<%@ page import="com.IoTBay.model.User" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>IoT Store - Register</title>--%>
<%--    <link rel="stylesheet" href="assets/styles.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--<%@ include file="Components/navbar.jsp" %>--%>
<%--<%--%>
<%--    User loggedinuser = (User)session.getAttribute("loggedInUser");--%>
<%--    if (loggedinuser != null && loggedinuser.getAdmin())--%>
<%--%>--%>




<%--<div class="account-settings-container">--%>
<%--    <div class="account-settings">--%>
<%--        <h1>Account Settings</h1>--%>
<%--        <a href="AccountPages/editPersonalDetails.jsp" class="account-settings-card">--%>
<%--            <h3><span class="icon">🪪</span> Edit Personal Details</h3>--%>
<%--        </a>--%>

<%--        <a href="AccountPages/SelectPaymentMethodToEdit.jsp" class="account-settings-card">--%>
<%--            <h3><span class="icon">💳</span> Edit Payment Details</h3>--%>
<%--        </a>--%>

<%--        <a href="AccountPages/viewAllOrders.jsp" class="account-settings-card">--%>
<%--            <h3><span class="icon">📦</span> View Order History</h3>--%>
<%--        </a>--%>

<%--        <a href="AccountPages/paymentHistory.jsp" class="account-settings-card">--%>
<%--            <h3><span class="icon">💵</span> View Payment History</h3>--%>
<%--        </a>--%>

<%--        <a href="AccountPages/userLog.jsp" class = "account-settings-card">--%>
<%--            <h3> View Website Access History</h3>--%>
<%--        </a>--%>

<%--        <%--%>
<%--            if(loggedinuser.getAdmin()){--%>
<%--        %>--%>
<%--        <a href ="AccountPages/AdminViewAllAccess.jsp" class = "account-settings-card">--%>
<%--            <h3>View All Website Access History</h3>--%>
<%--        </a>--%>

<%--        <%}%>--%>





<%--    </div>--%>
<%--</div>--%>

<%--</body>--%>


<%@ page import="com.IoTBay.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>IoT Bay – Account Settings</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<%@ include file="Components/navbar.jsp" %>

<%
    // get the logged-in user
    User me = (User) session.getAttribute("loggedInUser");
    if (me == null) {
        // not logged in? send them back to guest home
        response.sendRedirect("home.jsp");
        return;
    }
    // avoid name collisions: call it adminFlag instead of isAdmin
    boolean adminFlag = me.getAdmin();
%>

<div class="account-settings-container">
    <div class="account-settings">
        <h1>Account Settings</h1>

        <% if (adminFlag) { %>
        <!-- admin-only -->
        <a href="AdminViewAllOrders.jsp" class="account-settings-card">
            <h3><span class="icon">📦</span> View All Orders</h3>
        </a>
        <a href="AccountPages/AdminViewAllAccess.jsp" class="account-settings-card">
            <h3><span class="icon">🗂️</span> View All Website Access History</h3>
        </a>
        <% } else { %>
        <!-- regular user -->
        <a href="AccountPages/editPersonalDetails.jsp" class="account-settings-card">
            <h3><span class="icon">🪪</span> Edit Personal Details</h3>
        </a>
        <a href="AccountPages/SelectPaymentMethodToEdit.jsp" class="account-settings-card">
            <h3><span class="icon">💳</span> Edit Payment Details</h3>
        </a>
        <a href="AccountPages/viewAllOrders.jsp" class="account-settings-card">
            <h3><span class="icon">📦</span> View My Order History</h3>
        </a>
        <a href="AccountPages/paymentHistory.jsp" class="account-settings-card">
            <h3><span class="icon">💵</span> View My Payment History</h3>
        </a>
        <a href="AccountPages/userLog.jsp" class="account-settings-card">
            <h3><span class="icon">🕘</span> View My Website Access History</h3>
        </a>
        <% } %>

    </div>
</div>
</body>
</html>


