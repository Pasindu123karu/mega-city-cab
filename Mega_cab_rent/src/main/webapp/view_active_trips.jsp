<%@ page import="java.util.List, com.megacab.booking.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Active Trips</title>
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
            font-size: 20px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 18px;
        }
        .container {
            width: 80%;
            margin: auto;
            margin-top: 20px;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
            color: #2c3e50;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .no-trips {
            text-align: center;
            font-size: 18px;
            color: #777;
            padding: 20px;
        }
        .back-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            text-align: center;
            background-color: #3498db;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }
        .back-btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>Active Trips</h1>
        <a href="<%= request.getContextPath() %>/driver_home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
    </div>

    <div class="container">
        <h2>Your Active Trips</h2>

        <%
            List<Booking> bookingList = (List<Booking>) request.getAttribute("bookingList");
            if (bookingList != null && !bookingList.isEmpty()) {
        %>
            <table>
                <tr>
                    <th>ID</th>
                    <th>User Name</th>
                    <th>Pickup</th>
                    <th>Dropoff</th>
                    <th>Vehicle</th>
                    <th>Distance</th>
                    <th>Fare</th>
                    <th>Booked Date</th>
                    <th>Confirmed</th>
                </tr>
                <% for (Booking booking : bookingList) { %>
                <tr>
                    <td><%= booking.getId() %></td>
                    <td><%= booking.getUserName() %></td>
                    <td><%= booking.getPickupLocation() %></td>
                    <td><%= booking.getDropoffLocation() %></td>
                    <td><%= booking.getVehicleType() %></td>
                    <td><%= booking.getDistance() %> km</td>
                    <td>Rs <%= booking.getFare() %></td>
                    <td><%= booking.getBookedDate() %></td>
                    <td><%= booking.isConfirmed() ? "Yes" : "No" %></td>
                </tr>
                <% } %>
            </table>
        <%
            } else {
        %>
            <p class="no-trips">No active trips found.</p>
        <%
            }
        %>

        <a href="<%= request.getContextPath() %>/driver_home.jsp" class="back-btn">Back to Home</a>
    </div>

</body>
</html>
