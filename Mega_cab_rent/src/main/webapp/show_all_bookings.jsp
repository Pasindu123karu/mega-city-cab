<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.megacab.booking.Booking" %>
<%
    if(session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Show All Bookings - Mega City Cab</title>
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
            width: 90%;
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

<h2><%= session.getAttribute("name") %>, this is your bookings</h2>

<%
    List<Booking> bookingList = (List<Booking>) request.getAttribute("bookingList");
    if (bookingList == null) {
%>
    <p style="color: red;">Error: bookingList attribute is null. Check if ShowAllBookingsServlet is setting it correctly.</p>
<%
    } else if (bookingList.isEmpty()) {
%>
    <p>No bookings found.</p>
<%
    } else {
%>
    <table>
        <tr>
            <th>ID</th>
            <th>User Name</th>
            <th>Pickup Location</th>
            <th>Dropoff Location</th>
            <th>Vehicle Type</th>
            <th>Distance (km)</th>
            <th>Booked Date</th>
            <th>Fare (LKR)</th>
            <th>Confirmed</th> <!-- New column for Booking Confirmed -->
        </tr>
        <%
            for (Booking booking : bookingList) {
        %>
            <tr>
                <td><%= booking.getId() %></td>
                <td><%= booking.getUserName() %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropoffLocation() %></td>
                <td><%= booking.getVehicleType() %></td>
                <td><%= booking.getDistance() %></td>
                <td><%= booking.getBookedDate() %></td>
                <td><%= booking.getFare() %></td>
                <td>
                    <%= booking.isConfirmed() ? "Yes" : "No" %> <!-- Display "Yes" or "No" based on confirmed value -->
                </td>
            </tr>
        <%
            }
        %>
    </table>
<%
    }
%>

<!-- Floating Home Button -->
<button class="home-btn" onclick="goHome()">🏠 Home</button>

<script>
    function goHome() {
        window.location.href = 'index.jsp';
    }
</script>

</body>
</html>
