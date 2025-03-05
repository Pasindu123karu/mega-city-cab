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

@WebServlet("/viewDriver")
public class ViewDriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Driver> driverList = new ArrayList<>();
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

            String query = "SELECT driver_id, dname, dpwd, demail, dmobile, dnic, vehicle, vehicle_type FROM drivers";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Driver driver = new Driver();
                driver.setId(rs.getInt("driver_id"));
                driver.setName(rs.getString("dname"));
                driver.setPassword(rs.getString("dpwd"));
                driver.setEmail(rs.getString("demail"));
                driver.setMobile(rs.getString("dmobile"));
                driver.setNic(rs.getString("dnic"));
                driver.setVehicle(rs.getString("vehicle"));
                driver.setVehicle_type(rs.getString("vehicle_type"));
                driverList.add(driver);
            }

            request.setAttribute("driverList", driverList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("view_drivers.jsp");
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
