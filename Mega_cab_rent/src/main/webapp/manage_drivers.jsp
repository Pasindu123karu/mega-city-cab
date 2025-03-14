<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Drivers - Mega City Cab</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #FFF8DC;
            color: #333;
            text-align: center;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #FFC107;
            font-size: 28px;
            margin-bottom: 20px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background: #FFC107;
            color: black;
            font-size: 16px;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
        .btn {
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            border-radius: 5px;
            transition: 0.3s;
        }
        .delete-btn {
            background-color: red;
            color: white;
        }
        .delete-btn:hover {
            background-color: darkred;
        }
        .update-btn {
            background-color: blue;
            color: white;
        }
        .update-btn:hover {
            background-color: darkblue;
        }
        .home-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #FFC107;
            color: #000;
            padding: 12px 18px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease-in-out;
        }
        .home-btn:hover {
            background-color: #FFA000;
            transform: scale(1.1);
        }
    </style>
</head>
<body>

<h2>Manage Drivers</h2>

<%
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mega_city_cab?useSSL=false", "root", "Hprk@1234");

        String query = "SELECT driver_id, dname, demail, dmobile, dnic, vehicle, vehicle_type FROM drivers";
        pst = con.prepareStatement(query);
        rs = pst.executeQuery();

        if (!rs.isBeforeFirst()) { // Check if result set is empty
%>
        <p>No drivers found.</p>
<%
        } else {
%>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Mobile</th>
            <th>NIC</th>
            <th>Vehicle</th>
            <th>Vehicle Type</th>
            <th>Actions</th>
        </tr>
<%
            while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("driver_id") %></td>
            <td><%= rs.getString("dname") %></td>
            <td><%= rs.getString("demail") %></td>
            <td><%= rs.getString("dmobile") %></td>
            <td><%= rs.getString("dnic") %></td>
            <td><%= rs.getString("vehicle") %></td>
            <td><%= rs.getString("vehicle_type") %></td>
            <td style="display: flex; justify-content: space-between; align-items: center;">
    <form action="deleteDriver" method="post" style="display:inline;">
        <input type="hidden" name="driver_id" value="<%= rs.getInt("driver_id") %>">
        <button type="submit" class="btn delete-btn">Delete</button>
    </form> 
    <a href="editDriver?driver_id=<%= rs.getInt("driver_id") %>" class="btn update-btn" style="text-decoration: none;">Update</a>
</td>


        </tr>
<%
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
    </table>

<button class="home-btn" onclick="goHome()">🏠 Home</button>

<script>
    function goHome() {
        window.location.href = 'adminHome.jsp';
    }
</script>

</body>
</html>
