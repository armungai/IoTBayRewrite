<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Shipping Address</title>
    <link rel="stylesheet" href="assets/styles.css">
    <style>
        .address-form {
            width: 320px;
            margin: 40px auto;
            padding: 20px;
            background: #e0e0e0;
            border-radius: 12px;
            text-align: left;
        }

        .address-form h1 {
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: inline-block;
            width: 80px;
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            width: 200px;
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #999;
        }

        .form-group button {
            width: 100%;
            background-color: orange;
            color: white;
            font-weight: bold;
            padding: 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: darkorange;
        }
    </style>
</head>
<body>

<div class="address-form">
    <h1>Add New Shipping Address</h1>
    <form action="SaveShippingAddressServlet" method="post">
        <div class="form-group">
            <label for="street">Street:</label>
            <input type="text" id="street" name="street" required>
        </div>

        <div class="form-group">
            <label for="city">City:</label>
            <input type="text" id="city" name="city" required>
        </div>

        <div class="form-group">
            <label for="state">State:</label>
            <select name="state" id="state" required>
                <option value="NSW">NSW</option>
                <option value="VIC">VIC</option>
                <option value="QLD">QLD</option>
                <option value="WA">WA</option>
                <option value="SA">SA</option>
                <option value="TAS">TAS</option>
                <option value="ACT">ACT</option>
                <option value="NT">NT</option>
            </select>
        </div>

        <div class="form-group">
            <button type="submit">Save Address</button>
        </div>
    </form>
</div>

</body>
</html>