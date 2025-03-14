<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Booking - Mega City Cab</title>
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
        form {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 50%;
            margin: 0 auto;
        }
        label {
            font-size: 18px;
            margin-top: 10px;
        }
        input[type="text"], input[type="number"], select {
            padding: 8px;
            font-size: 16px;
            width: 100%;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #FFC107; /* Taxi Yellow */
            color: #000; /* Black text */
            padding: 12px 18px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease-in-out;
        }
        button:hover {
            background-color: #FFA000; /* Darker Yellow */
            transform: scale(1.05);
        }
        .success {
            color: green;
            font-size: 20px;
            margin-bottom: 20px;
        }
        .error {
            color: red;
            font-size: 20px;
            margin-bottom: 20px;
        }
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
<% 
      HttpSession adminSession = request.getSession(false);
      if (adminSession == null || adminSession.getAttribute("adminName") == null) {
         response.sendRedirect("adminLogin.jsp");
         return;
      }
   %>

<h2>Update Booking</h2>
<h3>Current Admin - <%= adminSession.getAttribute("adminName") %></h3>

<%
    // Display success or error messages based on query parameters
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    
    if ("true".equals(success)) {
%>
    <p class="success">Booking updated successfully!</p>
<%
    } else if ("true".equals(error)) {
%>
    <p class="error">Error updating booking!</p>
<%
    }

    String idParam = request.getParameter("id");

    if (idParam == null || idParam.trim().isEmpty()) { // If no ID, show list of bookings
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab", "root", "Hprk@1234");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, user_name, pickup, dropoff FROM bookings");

            out.println("<h3>Select a booking to update:</h3>");
            out.println("<table border='1' style='width:80%; margin: 20px auto; border-collapse: collapse;'>");
            out.println("<tr><th>ID</th><th>User</th><th>Pickup</th><th>Dropoff</th><th>Action</th></tr>");

            while (rs.next()) {
                int bookingId = rs.getInt("id");
                out.println("<tr>");
                out.println("<td>" + bookingId + "</td>");
                out.println("<td>" + rs.getString("user_name") + "</td>");
                out.println("<td>" + rs.getString("pickup") + "</td>");
                out.println("<td>" + rs.getString("dropoff") + "</td>");
                out.println("<td><a href='update_booking.jsp?id=" + bookingId + "'>Edit</a></td>");
                out.println("</tr>");
            }

            out.println("</table>");
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<h3 class='error'>Error fetching bookings!</h3>");
            e.printStackTrace(System.err); 
        }
    } else { 
        try {
            int bookingId = Integer.parseInt(idParam);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab", "root", "Hprk@1234");

            String sql = "SELECT * FROM bookings WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookingId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
%>
                <form action="UpdateBookingServlet" method="post">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

                    <label>User Name:</label>
                    <input type="text" name="user_name" value="<%= rs.getString("user_name") %>" required><br>

                    <label>Pickup:</label>
                    <input type="text" name="pickup" value="<%= rs.getString("pickup") %>" required><br>

                    <label>Dropoff:</label>
                    <input type="text" name="dropoff" value="<%= rs.getString("dropoff") %>" required><br>

                    <label>Vehicle:</label>
                    <input type="text" name="vehicle" value="<%= rs.getString("vehicle") %>" required><br>

                    <label>Distance (km):</label>
                    <input type="number" name="distance" value="<%= rs.getInt("distance") %>" required><br>

                    <label>Fare:</label>
                    <input type="text" name="fare" value="<%= rs.getDouble("fare") %>" required><br>

                    <label>Driver ID:</label>
                    <input type="number" name="driver_id" value="<%= rs.getInt("driver_id") %>" required><br>

                    <label>Confirmed:</label>
                    <select name="confirmed" required>
                        <option value="true" <%= rs.getBoolean("confirmed") ? "selected" : "" %>>Yes</option>
                        <option value="false" <%= !rs.getBoolean("confirmed") ? "selected" : "" %>>No</option>
                    </select><br>

                    <button type="submit">Update Booking</button>
                </form>
<%
            } else {
                out.println("<h3 class='error'>Booking Not Found!</h3>");
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<h3 class='error'>Error fetching booking!</h3>");
            e.printStackTrace(System.err); // Changed to print to standard error stream
        }
    }
%>

<!-- Floating Home Button -->
<button class="home-btn" onclick="goHome()">🏠 Home</button>

<script>
    function goHome() {
        window.location.href = 'adminHome.jsp'; 
    }
</script>

</body>
</html>
