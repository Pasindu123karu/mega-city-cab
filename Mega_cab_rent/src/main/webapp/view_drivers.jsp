<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.megacab.driver.Driver" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Registered Drivers - Mega City Cab</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #FFF8DC;
            color: #333;
            text-align: center;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #FFC107;
            font-size: 28px;
            margin-bottom: 20px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background: #FFC107;
            color: black;
            font-size: 16px;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
        p {
            font-size: 18px;
            color: #333;
        }

        .home-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #FFC107;
            color: #000;
            padding: 12px 18px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease-in-out;
        }
        .home-btn:hover {
            background-color: #FFA000;
            transform: scale(1.1);
        }
    </style>
</head>
<body>

<h2>Registered Drivers</h2>

<%
    List<Driver> driverList = (List<Driver>) request.getAttribute("driverList");
    if (driverList == null) {
%>
    <p style="color: red;">Error: driverList attribute is null. Check if ViewDriverServlet is setting it correctly.</p>
<%
    } else if (driverList.isEmpty()) {
%>
    <p>No drivers found.</p>
<%
    } else {
%>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Mobile</th>
            <th>NIC</th>
            <th>Vehicle</th>
            <th>Vehicle_type</th>
        </tr>
        <%
            for (Driver driver : driverList) {
        %>
            <tr>
                <td><%= driver.getId() %></td>
                <td><%= driver.getName() %></td>
                <td><%= driver.getEmail() %></td>
                <td><%= driver.getMobile() %></td>
                <td><%= driver.getNic() %></td>
                <td><%= driver.getVehicle() %></td>
				<td><%= driver.getVehicle_type() %></td>
            </tr>
        <%
            }
        %>
    </table>
<%
    }
%>

<button class="home-btn" onclick="goHome()">🏠 Home</button>

<script>
    function goHome() {
        window.location.href = 'adminHome.html';
    }
</script>

</body>
</html>
