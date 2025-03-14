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

@WebServlet("/viewBookings")
public class ViewBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Booking> bookingList = new ArrayList<>();
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

            // Updated query to include 'confirmed' and 'driverId'
            String query = "SELECT id, user_name, pickup, dropoff, vehicle, distance, fare, booked_date, confirmed, driver_id FROM bookings";
            PreparedStatement pst = con.prepareStatement(query);
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
                booking.setConfirmed(rs.getBoolean("confirmed")); // Setting confirmed status
                booking.setDriverId(rs.getInt("driver_id")); // Setting driver ID
                bookingList.add(booking);
            }

            request.setAttribute("bookingList", bookingList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("view_bookings.jsp");
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
