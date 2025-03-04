<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.megacab.booking.Booking" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Bookings - Mega City Cab</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #FFF8DC; /* Light yellow background */
            color: #333;
            text-align: center;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #FFC107; /* Taxi Yellow */
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
            background: #FFC107; /* Taxi Yellow */
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

        /* Floating Home Button */
        .home-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #FFC107; /* Taxi Yellow */
            color: #000; /* Black text */
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
            background-color: #FFA000; /* Darker Yellow */
            transform: scale(1.1);
        }
    </style>
</head>
<body>

<h2>All Bookings</h2>

<%
    List<Booking> bookingList = (List<Booking>) request.getAttribute("bookingList");
    if (bookingList == null) {
%>
    <p style="color: red;">Error: bookingList attribute is null. Check if ViewBookingsServlet is setting it correctly.</p>
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
        window.location.href = 'adminHome.html'; // Change to your actual home page URL
    }
</script>

</body>
</html>
