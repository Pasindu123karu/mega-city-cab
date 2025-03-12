package com.megacab.booking;
import com.megacab.booking.Driver;  
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/viewBookingDetails")
public class BookingDetailsServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jdbcURL = "jdbc:mysql://localhost:3306/mega_city_cab";
        String jdbcUsername = "root";
        String jdbcPassword = "Hprk@1234";
        
        // Get booking ID from the request (either from URL parameter or session)
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        
        // Query to get booking details
        String query = "SELECT b.id AS booking_id, b.user_name AS customer_name, b.pickup AS pickup_location, " +
                       "b.dropoff AS dropoff_location, b.vehicle AS vehicle_type, b.fare AS fare, b.booked_date AS booked_date, " +
                       "d.dname AS driver_name, d.vehicle AS driver_vehicle, d.vehicle_type AS driver_vehicle_type " +
                       "FROM bookings b LEFT JOIN drivers d ON LOWER(b.vehicle) = LOWER(d.vehicle_type) WHERE b.id = ?";
        
        List<BookingDetails> bookingList = new ArrayList<>();
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setInt(1, bookingId);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                BookingDetails booking = new BookingDetails();
                booking.setBookingId(resultSet.getInt("booking_id"));
                booking.setCustomerName(resultSet.getString("customer_name"));
                booking.setPickupLocation(resultSet.getString("pickup_location"));
                booking.setDropoffLocation(resultSet.getString("dropoff_location"));
                booking.setVehicleType(resultSet.getString("vehicle_type"));
                booking.setFare(resultSet.getDouble("fare"));
                booking.setBookedDate(resultSet.getDate("booked_date"));
                booking.setDriverName(resultSet.getString("driver_name"));
                booking.setDriverVehicle(resultSet.getString("driver_vehicle"));
                booking.setDriverVehicleType(resultSet.getString("driver_vehicle_type"));
                bookingList.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Fetch available drivers based on vehicle type
        List<Driver> availableDrivers = new ArrayList<>();
        String driverQuery = "SELECT id, dname, vehicle, vehicle_type FROM drivers WHERE vehicle_type = ?";
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = connection.prepareStatement(driverQuery)) {
            
            stmt.setString(1, bookingList.get(0).getVehicleType());
            ResultSet driverResultSet = stmt.executeQuery();
            
            while (driverResultSet.next()) {
                Driver driver = new Driver();
                driver.setId(driverResultSet.getInt("id"));
                driver.setName(driverResultSet.getString("dname"));
                driver.setVehicle(driverResultSet.getString("vehicle"));
                driver.setVehicleType(driverResultSet.getString("vehicle_type"));
                availableDrivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Set the booking and available drivers as attributes to the request
        request.setAttribute("bookingList", bookingList);
        request.setAttribute("availableDrivers", availableDrivers);
        
        // Forward the request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("view_booking_details.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get booking ID and selected driver ID from the request
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        
        String updateQuery = "UPDATE bookings SET driver_id = ? WHERE id = ?";
        
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab", "root", "Hprk@1234");
             PreparedStatement stmt = connection.prepareStatement(updateQuery)) {
            
            stmt.setInt(1, driverId);
            stmt.setInt(2, bookingId);
            stmt.executeUpdate();
            
            // Redirect to the same page to reflect changes
            response.sendRedirect("viewBookingDetails?bookingId=" + bookingId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
