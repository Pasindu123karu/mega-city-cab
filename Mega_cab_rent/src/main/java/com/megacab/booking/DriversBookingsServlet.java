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
import javax.servlet.http.HttpSession;

@WebServlet("/DriversBookingsServlet")
public class DriversBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve session
        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println("Session is null. Redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        Object driverIdObj = session.getAttribute("driverId");
        if (driverIdObj == null) {
            System.out.println("driverId not found in session. Redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        int driverId;
        try {
            driverId = Integer.parseInt(driverIdObj.toString()); // Convert to int
        } catch (NumberFormatException e) {
            System.out.println("Invalid driverId format. Redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("Driver ID from session: " + driverId); // Debugging

        List<Booking> bookingList = new ArrayList<>();
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

            String query = "SELECT id, user_name, pickup, dropoff, vehicle, distance, fare, booked_date, confirmed FROM bookings WHERE driver_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, driverId);
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

                bookingList.add(booking);
            }

            request.setAttribute("bookingList", bookingList);
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
