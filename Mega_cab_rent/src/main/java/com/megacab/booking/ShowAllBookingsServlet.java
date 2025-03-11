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

@WebServlet("/showAllBookings")
public class ShowAllBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Booking> bookingList = new ArrayList<>();
        Connection con = null;
        
        // Get the session object
        HttpSession session = request.getSession();
        
        // Retrieve the user name from the session
        String userName = (String) session.getAttribute("name");

        if (userName == null) {
            // Redirect to login page if session does not have a user name
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

            // Modify query based on the username in session
            String query = "SELECT id, user_name, pickup, dropoff, vehicle, distance, fare, booked_date FROM bookings WHERE user_name = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, userName); // Filter based on the session's username

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
                bookingList.add(booking);
            }

            // Set the filtered booking list in the request attribute
            request.setAttribute("bookingList", bookingList);

            // Forward the request to the JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("show_all_bookings.jsp");
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
