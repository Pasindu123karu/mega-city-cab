<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book Now - Cab Service</title>
    <style>
        .vehicle-option {
            display: inline-block;
            padding: 10px;
            margin: 5px;
            border: 1px solid black;
            cursor: pointer;
            user-select: none;
        }
        .vehicle-option.selected {
            background-color: lightblue;
        }
    </style>
</head>
<body>
    <h2>Book Your Ride</h2>
    <input type="text" id="pickup" placeholder="Enter Pickup Location">
    <input type="text" id="drop" placeholder="Enter Drop Location">

    <h3>Select Vehicle Type:</h3>
    <div class="vehicle-option" data-vehicle="car">Car</div>
    <div class="vehicle-option" data-vehicle="van">Van</div>
    <div class="vehicle-option" data-vehicle="tuk">Tuk</div>

    <br>
    <button onclick="bookNow()">Book Now</button>

    <script>
        // Vehicle selection logic
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".vehicle-option").forEach(option => {
                option.addEventListener("click", function () {
                    document.querySelectorAll(".vehicle-option").forEach(opt => opt.classList.remove("selected"));
                    this.classList.add("selected");
                });
            });
        });

        function bookNow() {
            let pickup = document.getElementById("pickup").value.trim();
            let drop = document.getElementById("drop").value.trim();
            let selectedVehicle = document.querySelector(".vehicle-option.selected");

            if (!pickup || !drop) {
                alert("Please enter both pickup and drop locations.");
                return;
            }

            if (!selectedVehicle) {
                alert("Please select a vehicle type.");
                return;
            }

            let vehicle = selectedVehicle.getAttribute("data-vehicle");

            fetch("BookingServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "pickup=" + encodeURIComponent(pickup) + "&drop=" + encodeURIComponent(drop) + "&vehicle=" + encodeURIComponent(vehicle)
            })
            .then(response => response.json())
            .then(data => {
                alert("Booking Confirmed!\nDistance: " + data.distance + " km\nTotal Fare: LKR " + data.fare);
            })
            .catch(error => {
                console.error("Error:", error);
                alert("An error occurred while processing your booking. Please try again.");
            });
        }
    </script>
</body>
</html>
