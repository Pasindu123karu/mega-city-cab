<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Home Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .navbar {
            background-color: #2c3e50;
            padding: 15px;
            color: white;
            text-align: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 18px;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh;
            flex-direction: column;
        }
        .welcome-text {
            font-size: 24px;
            color: #333;
        }
        .buttons {
            margin-top: 20px;
        }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            margin: 10px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>Driver Portal</h1>
        <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a> <!-- Point to the LogoutServlet -->
    </div>

    <div class="container">
        <div class="welcome-text">
            Welcome, 
            <%
                String driverName = (String) session.getAttribute("driverName");
                if (driverName != null) {
                    out.print(driverName);
                } else {
                    out.print("Driver");
                }
            %>!
        </div>
        <div class="buttons">
            <a href="<%= request.getContextPath() %>/DriversBookingsServlet" class="btn">View Active Trips</a>
            <a href="<%= request.getContextPath() %>/DriverProfileServlet" class="btn">View Profile</a>
            <a href="<%= request.getContextPath() %>/earnings.jsp" class="btn">View Earnings</a>
        </div>
    </div>

</body>
</html>
