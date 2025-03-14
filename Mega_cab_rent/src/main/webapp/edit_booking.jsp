<%@ page import="com.megacab.booking.Booking" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Booking</title>
</head>
<body>
    <h1>Edit Booking</h1>

    <form action="editBooking" method="POST">
        <input type="hidden" name="id" value="${booking.id}">

        <label for="user_name">User Name:</label>
        <input type="text" name="user_name" value="${booking.userName}" required><br>

        <label for="pickup">Pickup Location:</label>
        <input type="text" name="pickup" value="${booking.pickupLocation}" required><br>

        <label for="dropoff">Dropoff Location:</label>
        <input type="text" name="dropoff" value="${booking.dropoffLocation}" required><br>

        <label for="vehicle">Vehicle:</label>
        <input type="text" name="vehicle" value="${booking.vehicleType}" required><br>

        <label for="distance">Distance:</label>
        <input type="number" name="distance" value="${booking.distance}" required><br>

        <label for="fare">Fare:</label>
        <input type="number" step="0.01" name="fare" value="${booking.fare}" required><br>

        <button type="submit">Update Booking</button>
    </form>

    <br>
    <a href="viewBookings">Back to Bookings</a>
</body>
</html>
