package com.megacab.driver;

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

@WebServlet("/manageDrivers")
public class ManageDriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Driver> driverList = new ArrayList<>();
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String query = "SELECT driver_id, dname, demail, dmobile, dnic, vehicle, vehicle_type FROM drivers";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                Driver driver = new Driver();
                driver.setId(rs.getInt("driver_id"));
                driver.setName(rs.getString("dname"));
                driver.setEmail(rs.getString("demail"));
                driver.setMobile(rs.getString("dmobile"));
                driver.setNic(rs.getString("dnic"));
                driver.setVehicle(rs.getString("vehicle"));
                driver.setVehicle_type(rs.getString("vehicle_type"));
                driverList.add(driver);
            }
            request.setAttribute("driverList", driverList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("manage_drivers.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int driverId = Integer.parseInt(request.getParameter("driverId"));

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            if ("delete".equals(action)) {
                PreparedStatement pst = con.prepareStatement("DELETE FROM drivers WHERE driver_id=?");
                pst.setInt(1, driverId);
                pst.executeUpdate();
            } else if ("update".equals(action)) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String mobile = request.getParameter("mobile");
                String nic = request.getParameter("nic");
                String vehicle = request.getParameter("vehicle");
                String vehicleType = request.getParameter("vehicleType");
                
                PreparedStatement pst = con.prepareStatement("UPDATE drivers SET dname=?, demail=?, dmobile=?, dnic=?, vehicle=?, vehicle_type=? WHERE driver_id=?");
                pst.setString(1, name);
                pst.setString(2, email);
                pst.setString(3, mobile);
                pst.setString(4, nic);
                pst.setString(5, vehicle);
                pst.setString(6, vehicleType);
                pst.setInt(7, driverId);
                pst.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("manageDrivers");
    }
}
