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

@WebServlet("/viewProfile")
public class ViewProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("driverEmail");

        if (email == null) {
            System.out.println("No driver email found in session.");
            response.sendRedirect("login.jsp"); // Redirect if not logged in
            return;
        }

        System.out.println("Driver Email from Session: " + email);

        Connection con = null;
        RequestDispatcher dispatcher = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

            String query = "SELECT * FROM drivers WHERE demail = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);

            System.out.println("SQL Query Executed for Email: " + email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                System.out.println("Driver Profile Found");
                System.out.println("Driver Name: " + rs.getString("dname"));
                System.out.println("Driver Mobile: " + rs.getString("dmobile"));
                System.out.println("Driver NIC: " + rs.getString("dnic"));
                System.out.println("Driver Vehicle: " + rs.getString("vehicle"));
                System.out.println("Driver Vehicle Type: " + rs.getString("vehicle_type"));

                request.setAttribute("name", rs.getString("dname"));
                request.setAttribute("email", rs.getString("demail"));
                request.setAttribute("mobile", rs.getString("dmobile"));
                request.setAttribute("nic", rs.getString("dnic"));
                request.setAttribute("vehicle", rs.getString("vehicle"));
                request.setAttribute("vehicleType", rs.getString("vehicle_type"));

                System.out.println("Setting attributes for profile.jsp");
                dispatcher = request.getRequestDispatcher("profile.jsp");
            } else {
                System.out.println("No driver profile found in DB for email: " + email);
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("driver_home.jsp");
            }

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
