package com.megacab.booking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/viewActiveTrips")
public class ViewActiveTripsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get driver ID from session
        Integer driverId = (Integer) request.getSession().getAttribute("driverId");

        if (driverId == null) {
            // Handle case when driver is not logged in
            response.sendRedirect("login.jsp"); // Redirect to login if driverId is null
            return;
        }

        List<Booking> bookingList = new ArrayList<>();
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

            // Query to fetch active trips for the logged-in driver
            String query = "SELECT id, user_name, pickup, dropoff, vehicle, distance, fare, booked_date, confirmed, driver_id FROM bookings WHERE driver_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, driverId);  // Set driver ID dynamically
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setUserName(rs.getString("user_name"));
                booking.setPickupLocation(rs.getString("pickup"));
                booking.setDropoffLocation(rs.getString("dropoff"));
                booking.setVehicleType(rs.getString("vehicle"));
                booking.setDistance(rs.getDouble("distance"));
                booking.setFare(rs.getDouble("fare"));
                booking.setBookedDate(rs.getString("booked_date"));
                booking.setConfirmed(rs.getBoolean("confirmed"));
                booking.setDriverId(rs.getInt("driver_id"));
                bookingList.add(booking);
            }

            // Set the booking list in the request attribute
            request.setAttribute("bookingList", bookingList);

            // Forward to JSP to display active trips
            RequestDispatcher dispatcher = request.getRequestDispatcher("view_active_trips.jsp");
            dispatcher.forward(request, response);

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
