package com.megacab.booking;

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
        // Database connection and query execution
        String jdbcURL = "jdbc:mysql://localhost:3306/mega_city_cab";
        String jdbcUsername = "root";
        String jdbcPassword = "Hprk@1234";
        
        String query = "SELECT b.id AS booking_id, b.user_name AS customer_name, b.pickup AS pickup_location, " +
                       "b.dropoff AS dropoff_location, b.vehicle AS vehicle_type, b.fare AS fare, b.booked_date AS booked_date, " +
                       "d.dname AS driver_name, d.vehicle AS driver_vehicle, d.vehicle_type AS driver_vehicle_type " +
                       "FROM bookings b JOIN drivers d ON LOWER(b.vehicle) = LOWER(d.vehicle_type)";
        
        // Store results in a list
        List<BookingDetails> bookingList = new ArrayList<>();
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            
            while (resultSet.next()) {
                // Create booking object and set data
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
                
                // Add to list
                bookingList.add(booking);
            }
        } catch (SQLException e) {
            // You can log the exception instead of printing stack trace
            e.printStackTrace(); // Replace with logging as per your logging setup
        }
        
        // Set the result as an attribute to the request
        request.setAttribute("bookingList", bookingList);
        
        // Forward the request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("view_booking_details.jsp");
        dispatcher.forward(request, response);
    }
}
