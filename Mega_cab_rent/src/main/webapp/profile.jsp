<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.megacab.driver.Driver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Profile</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh;
            flex-direction: column;
        }
        h2 {
            color: #3498db;
            font-size: 28px;
            margin-bottom: 20px;
        }
        .profile-container {
            background: #fff;
            padding: 20px;
            width: 50%;
            margin: 0 auto;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: left;
        }
        p {
            font-size: 18px;
            color: #333;
            margin: 10px 0;
        }
        .label {
            font-weight: bold;
            color: #555;
        }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 12px 24px;
            border: none;
            margin: 20px 0;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Your Profile</h2>

        <%
            Driver driver = (Driver) request.getAttribute("driver");
            if (driver == null) {
        %>
            <p style="color: red;">Error: No driver data found.</p>
        <%
            } else {
        %>
            <div class="profile-container">
                <p><span class="label">ID:</span> <%= driver.getId() %></p>
                <p><span class="label">Name:</span> <%= driver.getName() %></p>
                <p><span class="label">Email:</span> <%= driver.getEmail() %></p>
                <p><span class="label">Mobile:</span> <%= driver.getMobile() %></p>
                <p><span class="label">NIC:</span> <%= driver.getNic() %></p>
                <p><span class="label">Vehicle:</span> <%= driver.getVehicle() %></p>
                <p><span class="label">Vehicle Type:</span> <%= driver.getVehicle_type() %></p>
            </div>
        <%
            }
        %>

        <!-- Button to return to the driver home page -->
        <a href="<%= request.getContextPath() %>/driver_home.jsp" class="btn">Back to Home</a>
    </div>

</body>
</html>
