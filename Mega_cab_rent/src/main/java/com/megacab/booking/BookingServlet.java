package com.megacab.booking;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/mega_city_cab";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "Hprk@1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username").trim();
        String pickup = request.getParameter("pickup").trim();
        String dropoff = request.getParameter("dropoff").trim();
        String vehicle = request.getParameter("vehicle").trim();
        String bookedDate = request.getParameter("booked_date").trim();

        if (username.isEmpty() || pickup.isEmpty() || dropoff.isEmpty() || vehicle.isEmpty() || bookedDate.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("booking.jsp").forward(request, response);
            return;
        }

        double distance = 0, fare = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure driver is loaded
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
                
                String query = "SELECT distance FROM locations WHERE LOWER(TRIM(pickup)) = LOWER(?) AND LOWER(TRIM(dropoff)) = LOWER(?)";
                
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, pickup);
                    stmt.setString(2, dropoff);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            distance = rs.getDouble("distance");
                            fare = calculateFare(distance, vehicle); // Calculate fare based on vehicle type
                        } else {
                            request.setAttribute("errorMessage", "Invalid locations provided.");
                            request.getRequestDispatcher("booking.jsp").forward(request, response);
                            return;
                        }
                    }
                }

                // Updated query to include booked_date
                String insertBookingQuery = "INSERT INTO bookings (user_name, pickup, dropoff, vehicle, distance, fare, booked_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertBookingQuery)) {
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, pickup);
                    insertStmt.setString(3, dropoff);
                    insertStmt.setString(4, vehicle);
                    insertStmt.setDouble(5, distance);
                    insertStmt.setDouble(6, fare);
                    insertStmt.setDate(7, Date.valueOf(bookedDate)); // Insert the booked date into the database
                    insertStmt.executeUpdate();
                }

                request.setAttribute("successMessage", "Booking successful! Fare: Rs. " + fare);
                request.getRequestDispatcher("booking.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            request.setAttribute("errorMessage", "JDBC Driver not found.");
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        }
    }

    // Updated fare calculation based on vehicle type
    private double calculateFare(double distance, String vehicle) {
        double ratePerKm;

        switch (vehicle.toLowerCase()) {
            case "budget":
                ratePerKm = 50;
                break;
            case "city":
                ratePerKm = 60;
                break;
            case "car":
                ratePerKm = 70;
                break;
            case "9 seater":
                ratePerKm = 100;
                break;
            case "14 seater":
                ratePerKm = 110;
                break;
            default:
                ratePerKm = 50; 
        }

        return ratePerKm * distance;
    }
}
