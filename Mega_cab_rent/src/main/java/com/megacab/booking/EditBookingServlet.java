package com.megacab.booking;

import java.io.IOException;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditBookingServlet
 */
@WebServlet("/editBooking")
public class EditBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handle GET requests to display the booking details for editing
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int bookingId = Integer.parseInt(request.getParameter("id"));
        Booking booking = getBookingById(bookingId);  // Get the booking details by ID
        
        // Set the booking object in the request attribute to forward to the JSP
        request.setAttribute("booking", booking);
        
        // Forward to the edit_booking.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("edit_booking.jsp");
        dispatcher.forward(request, response);
    }

    // Retrieve booking details by booking ID
    private Booking getBookingById(int id) {
        Booking booking = null;
        Connection con = null;
        
        try {
            // Establish connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");
            
            // SQL query to get the booking by its ID
            String query = "SELECT * FROM bookings WHERE id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            
            // If booking exists, map the result to the Booking object
            if (rs.next()) {
                booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setUserName(rs.getString("user_name"));
                booking.setPickupLocation(rs.getString("pickup"));
                booking.setDropoffLocation(rs.getString("dropoff"));
                booking.setVehicleType(rs.getString("vehicle"));
                booking.setDistance(rs.getDouble("distance"));
                booking.setFare(rs.getDouble("fare"));
                booking.setBookedDate(rs.getString("booked_date"));
                booking.setConfirmed(rs.getBoolean("confirmed"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return booking;
    }

    // Handle POST requests to update the booking details
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the booking details from the form
        int bookingId = Integer.parseInt(request.getParameter("id"));
        String userName = request.getParameter("user_name");
        String pickup = request.getParameter("pickup");
        String dropoff = request.getParameter("dropoff");
        String vehicle = request.getParameter("vehicle");
        double distance = Double.parseDouble(request.getParameter("distance"));
        double fare = Double.parseDouble(request.getParameter("fare"));
        
        // Update the booking in the database
        updateBooking(bookingId, userName, pickup, dropoff, vehicle, distance, fare);
        
        // Redirect to the bookings list page after update
        response.sendRedirect("viewBookings");
    }

    // Update the booking details in the database
    private void updateBooking(int id, String userName, String pickup, String dropoff, String vehicle, double distance, double fare) {
        Connection con = null;
        
        try {
            // Establish connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");
            
            // SQL query to update the booking
            String query = "UPDATE bookings SET user_name = ?, pickup = ?, dropoff = ?, vehicle = ?, distance = ?, fare = ? WHERE id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, userName);
            pst.setString(2, pickup);
            pst.setString(3, dropoff);
            pst.setString(4, vehicle);
            pst.setDouble(5, distance);
            pst.setDouble(6, fare);
            pst.setInt(7, id);
            
            // Execute the update query
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
