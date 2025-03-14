<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.megacab.driver.Driver" %>

<%
    // Retrieve driver details from request
    Driver driver = (Driver) request.getAttribute("driver");
    if (driver == null) {
%>
    <p style="color: red;">Error: Driver details not found.</p>
<%
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Driver</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FFF8DC;
            text-align: center;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 40%;
            margin: auto;
        }
        input {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #FFC107;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover {
            background-color: #FFA000;
        }
    </style>
</head>
<body>

<h2>Update Driver</h2>
<form action="updateDriver" method="post">
    <input type="hidden" name="driver_id" value="<%= driver.getId() %>">
    <label>Name:</label><br>
    <input type="text" name="dname" value="<%= driver.getName() %>" required><br>
    
    <label>Email:</label><br>
    <input type="email" name="demail" value="<%= driver.getEmail() %>" required><br>

    <label>Mobile:</label><br>
    <input type="text" name="dmobile" value="<%= driver.getMobile() %>" required><br>

    <label>NIC:</label><br>
    <input type="text" name="dnic" value="<%= driver.getNic() %>" required><br>

    <label>Vehicle:</label><br>
    <input type="text" name="vehicle" value="<%= driver.getVehicle() %>" required><br>

    <label>Vehicle Type:</label><br>
    <input type="text" name="vehicle_type" value="<%= driver.getVehicle_type() %>" required><br>

    <button type="submit">Update</button>
</form>

</body>
</html>
<% } %>
