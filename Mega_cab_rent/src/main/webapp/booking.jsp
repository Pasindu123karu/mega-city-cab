<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Now - Cab Service</title>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }

        /* Header Styles */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background: #1d1f21;
            color: #fff;
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            padding: 10px 15px;
            font-size: 16px;
            font-weight: 500;
            transition: background 0.3s;
        }

        .navbar a:hover {
            background: #ff9800;
            border-radius: 5px;
        }

        .container {
            max-width: 1100px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .form-container input,
        .form-container select,
        .form-container button {
            padding: 12px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-container button {
            background: #1d1f21;
            color: white;
            cursor: pointer;
            transition: background 0.3s;
        }

        .form-container button:hover {
            background: #333;
        }

        .footer {
            background: #1d1f21;
            color: #fff;
            text-align: center;
            padding: 15px 0;
            margin-top: 50px;
        }

        @media screen and (max-width: 768px) {
            .form-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="navbar">
        <div class="logo">Cab Service</div>
        <div>
            <a href="index.jsp">Home</a>
            <a href="login.jsp"><%= session.getAttribute("name") %></a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <h2>Book a Cab</h2>

        <!-- Display Error Message -->
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>

        <!-- Display Success Message -->
        <% if (request.getAttribute("successMessage") != null) { %>
            <p style="color: green;"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <form action="BookingServlet" method="post" class="form-container">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" value="<%= session.getAttribute("name") %>" readonly><br><br>

            <label for="pickup">Pickup Location:</label>
            <input type="text" name="pickup" id="pickup" required><br><br>

            <label for="dropoff">Dropoff Location:</label>
            <input type="text" name="dropoff" id="dropoff" required><br><br>

            <label for="vehicle">Vehicle Type:</label>
            <select name="vehicle" id="vehicle" required>
                <option value="Budget">Budget</option>
                <option value="City">City</option>
                <option value="Car">Car</option>
                <option value="9 Seater">9 Seater</option>
                <option value="14 Seater">14 Seater</option>
                
            </select><br><br>

            <!-- Booked Date Selection -->
            <label for="booked_date">Choose Your Booking Date:</label>
            <input type="date" name="booked_date" id="booked_date" required><br><br>

            <button type="submit">Book Now</button>
        </form>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Cab Service. All Rights Reserved.</p>
    </div>

</body>
</html>
