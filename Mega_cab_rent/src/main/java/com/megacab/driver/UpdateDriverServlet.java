package com.megacab.driver;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateDriver")
public class UpdateDriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection con = null;
        PreparedStatement pst = null;

        try {
            int driverId = Integer.parseInt(request.getParameter("driver_id"));
            String name = request.getParameter("dname");
            String email = request.getParameter("demail");
            String mobile = request.getParameter("dmobile");
            String nic = request.getParameter("dnic");
            String vehicle = request.getParameter("vehicle");
            String vehicleType = request.getParameter("vehicle_type");

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

            String query = "UPDATE drivers SET dname=?, demail=?, dmobile=?, dnic=?, vehicle=?, vehicle_type=? WHERE driver_id=?";
            pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, mobile);
            pst.setString(4, nic);
            pst.setString(5, vehicle);
            pst.setString(6, vehicleType);
            pst.setInt(7, driverId);

            int rowsUpdated = pst.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("manage_drivers.jsp");
            } else {
                response.getWriter().println("Error: Could not update driver details.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
