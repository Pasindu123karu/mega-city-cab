package com.megacab.registration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class adminLogin {
    
    private static final String URL = "jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "Hprk@1234";
    
    public boolean validateAdmin(String adminEmail, String adminPassword) {
        boolean isValid = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
            
            String query = "SELECT * FROM admin WHERE admin_email = ? AND admin_password = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, adminEmail);
            pst.setString(2, adminPassword);
            
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                isValid = true;
            }
            
            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return isValid;
    }
}
