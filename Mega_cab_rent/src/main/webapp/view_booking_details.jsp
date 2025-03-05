<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.megacab.booking.BookingDetails" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

<h2>Booking Details</h2>

<%
    List<BookingDetails> bookingList = (List<BookingDetails>) request.getAttribute("bookingList");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Format the date
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
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Customer Name</th>
                <th>Pickup Location</th>
                <th>Dropoff Location</th>
                <th>Vehicle Type</th>
                <th>Fare (LKR)</th>
                <th>Booked Date</th>
                <th>Driver Name</th>
                <th>Driver Vehicle</th>
                <th>Driver Vehicle Type</th>
            </tr>
        </thead>
        <tbody>
            <% 
                for (BookingDetails booking : bookingList) {
            %>
            <tr>
                <td><%= booking.getBookingId() %></td>
                <td><%= booking.getCustomerName() %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropoffLocation() %></td>
                <td><%= booking.getVehicleType() %></td>
                <td><%= booking.getFare() %></td>
                <td><%= sdf.format(booking.getBookedDate()) %></td> <!-- Format the booked date -->
                <td><%= booking.getDriverName() %></td>
                <td><%= booking.getDriverVehicle() %></td>
                <td><%= booking.getDriverVehicleType() %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
<%
    }
%>

<!-- Floating Home Button -->
<button class="home-btn" onclick="goHome()">🏠 Home</button>

<script>
    function goHome() {
        window.location.href = 'adminHome.html'; 
    }
</script>

</body>
</html>
