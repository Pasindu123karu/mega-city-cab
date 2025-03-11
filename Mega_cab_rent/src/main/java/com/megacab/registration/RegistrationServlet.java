package com.megacab.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String uname = request.getParameter("name");
        String uemail = request.getParameter("email");
        String upwd = request.getParameter("pass");
        String re_pass = request.getParameter("re_pass"); // Get repeated password
        String umobile = request.getParameter("contact");
        String uaddress = request.getParameter("address");
        String unic = request.getParameter("nic");

        RequestDispatcher dispatcher = request.getRequestDispatcher("registration.jsp");

        // Validate that no field is empty
        if (uname == null || uname.trim().isEmpty() ||
            uemail == null || uemail.trim().isEmpty() ||
            upwd == null || upwd.trim().isEmpty() ||
            re_pass == null || re_pass.trim().isEmpty() ||
            umobile == null || umobile.trim().isEmpty() ||
            uaddress == null || uaddress.trim().isEmpty() ||
            unic == null || unic.trim().isEmpty()) {
            
            request.setAttribute("status", "empty");
            dispatcher.forward(request, response);
            return;
        }

        // Check if passwords match
        if (!upwd.equals(re_pass)) {
            request.setAttribute("status", "password_mismatch");
            dispatcher.forward(request, response);
            return;
        }

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");
            PreparedStatement pst = con.prepareStatement("INSERT INTO users(uname, upwd, uemail, umobile, uaddress, unic) VALUES(?, ?, ?, ?, ?, ?)");
            
            pst.setString(1, uname);
            pst.setString(2, upwd);
            pst.setString(3, uemail);
            pst.setString(4, umobile);
            pst.setString(5, uaddress);
            pst.setString(6, unic);

            int rowCount = pst.executeUpdate();
            
            if (rowCount > 0) {
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "failed");
            }

            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
