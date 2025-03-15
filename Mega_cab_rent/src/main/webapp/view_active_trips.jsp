<%@ page import="java.util.List" %>
<%@ page import="com.megacab.booking.Booking" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Active Trips</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <h1>Active Trips</h1>

    <%
        // Get the booking list from the request attribute
        List<Booking> bookingList = (List<Booking>) request.getAttribute("bookingList");

        // Check if there are any active trips for the logged-in driver
        if (bookingList != null && !bookingList.isEmpty()) {
    %>
        <table border="1">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>User Name</th>
                    <th>Pickup Location</th>
                    <th>Dropoff Location</th>
                    <th>Vehicle Type</th>
                    <th>Distance</th>
                    <th>Fare</th>
                    <th>Booked Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Loop through the booking list and display each active trip
                    for (Booking booking : bookingList) {
                %>
                    <tr>
                        <td><%= booking.getId() %></td>
                        <td><%= booking.getUserName() %></td>
                        <td><%= booking.getPickupLocation() %></td>
                        <td><%= booking.getDropoffLocation() %></td>
                        <td><%= booking.getVehicleType() %></td>
                        <td><%= booking.getDistance() %></td>
                        <td><%= booking.getFare() %></td>
                        <td><%= booking.getBookedDate() %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <p>No active trips available at the moment.</p>
    <%
        }
    %>

</body>
</html>
