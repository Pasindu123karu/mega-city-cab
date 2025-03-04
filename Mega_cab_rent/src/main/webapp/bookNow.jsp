 <%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking</title>
</head>
<body>
    <h2>Book a Cab</h2>
    
    <form action="bookCab.jsp" method="post">
        <label for="pickup">Pickup Location:</label>
        <input type="text" name="pickup" id="pickup" required><br><br>

        <label for="dropoff">Dropoff Location:</label>
        <input type="text" name="dropoff" id="dropoff" required><br><br>

        <label for="vehicle">Vehicle Type:</label>
        <select name="vehicle" id="vehicle" required>
            <option value="Sedan">Sedan</option>
            <option value="SUV">SUV</option>
            <option value="Minivan">Minivan</option>
        </select><br><br>

        <input type="submit" value="Book Now">
    </form>
    
    <h3>Available Locations</h3>
    <table border="1">
        <tr>
            <th>Pickup Location</th>
            <th>Dropoff Location</th>
            <th>Distance (km)</th>
        </tr>

        <%
            // Connect to the database
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Database connection (you should replace this with your own connection details)
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab", "root", "Hprk@1234");
                String sql = "SELECT pickup, dropoff, distance FROM locations";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    String pickup = rs.getString("pickup");
                    String dropoff = rs.getString("dropoff");
                    double distance = rs.getDouble("distance");
        %>

        <tr>
            <td><%= pickup %></td>
            <td><%= dropoff %></td>
            <td><%= distance %></td>
        </tr>

        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

    </table>
</body>
</html>
