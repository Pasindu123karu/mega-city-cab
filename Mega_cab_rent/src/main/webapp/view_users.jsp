<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.megacab.registration.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Registered Users - Mega City Cab</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #FFF8DC; /* Light yellow background */
            color: #333;
            text-align: center;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #FFC107; /* Taxi Yellow */
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
            background: #FFC107; /* Taxi Yellow */
            color: black;
            font-size: 16px;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
        p {
            font-size: 18px;
            color: #333;
        }

        /* Floating Home Button */
        .home-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #FFC107; /* Taxi Yellow */
            color: #000; /* Black text */
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
            background-color: #FFA000; /* Darker Yellow */
            transform: scale(1.1);
        }
    </style>
</head>
<body>

<h2>Registered Users</h2>

<%
    List<User> userList = (List<User>) request.getAttribute("userList");
    if (userList == null) {
%>
    <p style="color: red;">Error: userList attribute is null. Check if ViewUsersServlet is setting it correctly.</p>
<%
    } else if (userList.isEmpty()) {
%>
    <p>No users found.</p>
<%
    } else {
%>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Mobile</th>
            <th>Address</th>
            <th>NIC</th>  
        </tr>
        <%
            for (User user : userList) {
        %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getMobile() %></td>
                <td><%= user.getAddress() %></td>
                <td><%= user.getNic() %></td>
            </tr>
        <%
            }
        %>
    </table>
<%
    }
%>

<!-- Floating Home Button -->
<button class="home-btn" onclick="goHome()">🏠 Home</button>

<script>
    function goHome() {
        window.location.href = 'adminHome.jsp'; 
    }
</script>

</body>
</html>
