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

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String driverEmail = (String) session.getAttribute("driverEmail"); // Get driver email from session

        if (driverEmail != null) {
            Connection con = null;
            try {
                // Load MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Create connection to the database
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");
                
                // SQL query to fetch driver details using email
                String query = "SELECT * FROM drivers WHERE demail = ?";
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, driverEmail);
                
                // Execute query
                ResultSet rs = pst.executeQuery();
                
                if (rs.next()) {
                    // Retrieve data from ResultSet
                    String driverName = rs.getString("dname");
                    String mobile = rs.getString("dmobile");
                    String nic = rs.getString("dnic");
                    String vehicle = rs.getString("vehicle");
                    String vehicleType = rs.getString("vehicle_type");
                    
                    // Set the retrieved data as request attributes
                    request.setAttribute("driverName", driverName);
                    request.setAttribute("driverEmail", driverEmail);
                    request.setAttribute("driverMobile", mobile);
                    request.setAttribute("driverNIC", nic);
                    request.setAttribute("driverVehicle", vehicle);
                    request.setAttribute("driverVehicleType", vehicleType);
                    
                    // Forward to profile.jsp to display data
                    RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // Handle case if the driver is not found in the database
                    request.setAttribute("status", "not_found");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred while fetching profile.");
            } finally {
                try {
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            // If the driverEmail is not set in the session
            response.sendRedirect("login.jsp");
        }
    }
}
