<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.megacab.booking.BookingDetails" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
</head>
<body>

<h2>Booking Details</h2>

<% 
    List<BookingDetails> bookingList = (List<BookingDetails>) request.getAttribute("bookingList");
    List<Driver> availableDrivers = (List<Driver>) request.getAttribute("availableDrivers");
    BookingDetails booking = bookingList.get(0); // Assuming only one booking is returned
%>

<p><strong>Booking ID:</strong> <%= booking.getBookingId() %></p>
<p><strong>Customer Name:</strong> <%= booking.getCustomerName() %></p>
<p><strong>Pickup Location:</strong> <%= booking.getPickupLocation() %></p>
<p><strong>Dropoff Location:</strong> <%= booking.getDropoffLocation() %></p>
<p><strong>Fare:</strong> <%= booking.getFare() %></p>
<p><strong>Booked Date:</strong> <%= booking.getBookedDate() %></p>

<h3>Assign Driver</h3>
<form action="viewBookingDetails" method="post">
    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
    
    <label for="driverId">Select Driver:</label>
    <select name="driverId" id="driverId" required>
        <option value="">-- Select a Driver --</option>
        <% for (Driver driver : availableDrivers) { %>
            <option value="<%= driver.getId() %>"><%= driver.getName() %> - <%= driver.getVehicleType() %></option>
        <% } %>
    </select>
    <br><br>
    
    <input type="submit" value="Assign Driver">
</form>

</body>
</html>
