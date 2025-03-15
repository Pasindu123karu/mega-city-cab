package com.megacab.driver;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Connection con = null;
        RequestDispatcher dispatcher = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");
            
            // SQL query to check if the email and password match in the database
            String query = "SELECT driver_id, dname FROM drivers WHERE demail = ? AND dpwd = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            
            // Execute query
            ResultSet rs = pst.executeQuery();
            
            // Check if a record is found
            if (rs.next()) {
                int driverId = rs.getInt("driver_id"); // 🔴 Change 'did' to 'driver_id'
                String driverName = rs.getString("dname"); 

                // Store details in the session
                HttpSession session = request.getSession();
                session.setAttribute("driverId", driverId); // 🔴 Storing driver_id properly
                session.setAttribute("driverEmail", email);
                session.setAttribute("driverName", driverName);

                // Log for debugging
                System.out.println("Login successful: driverId=" + driverId + ", driverName=" + driverName);

                request.setAttribute("status", "success");
                dispatcher = request.getRequestDispatcher("driver_home.jsp");  // Redirect to driver home page
            } else {
                // Invalid credentials
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("driverlogin.jsp");  // Redirect back to login page
            }

            // Forward the request
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // This will print stack trace in the logs
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred during login.");
        } finally {
            try {
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
