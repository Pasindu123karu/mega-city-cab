package com.megacab.booking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateBookingServlet")
public class UpdateBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        String userName = request.getParameter("user_name");
        String pickup = request.getParameter("pickup");
        String dropoff = request.getParameter("dropoff");
        String vehicle = request.getParameter("vehicle");
        int distance = Integer.parseInt(request.getParameter("distance"));
        double fare = Double.parseDouble(request.getParameter("fare"));
        int driverId = Integer.parseInt(request.getParameter("driver_id"));
        boolean confirmed = Boolean.parseBoolean(request.getParameter("confirmed")); // Ensure this is correct

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

            String sql = "UPDATE bookings SET user_name=?, pickup=?, dropoff=?, vehicle=?, distance=?, fare=?, driver_id=?, confirmed=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            pstmt.setString(2, pickup);
            pstmt.setString(3, dropoff);
            pstmt.setString(4, vehicle);
            pstmt.setInt(5, distance);
            pstmt.setDouble(6, fare);
            pstmt.setInt(7, driverId);
            pstmt.setBoolean(8, confirmed); // Ensure this is correctly set
            pstmt.setInt(9, bookingId);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("update_booking.jsp?id=" + bookingId + "&success=true");
            } else {
                response.sendRedirect("update_booking.jsp?id=" + bookingId + "&error=true");
            }


        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("update_booking.jsp?id=" + bookingId + "&error=true");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
