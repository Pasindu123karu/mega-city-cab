<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.megacab.registration.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Mega City Cab</title>
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
            width: 90%;
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
        .delete-btn {
            background: red;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
        }
        .delete-btn:hover {
            background: darkred;
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

<h2>Manage Users</h2>

<%
    List<User> userList = (List<User>) request.getAttribute("userList");
    if (userList == null) {
%>
    <p style="color: red;">Error: userList attribute is null. Check if ManageUsersServlet is setting it correctly.</p>
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
            <th>Action</th>
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
                <td>
                    <form action="deleteUser" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');">
                        <input type="hidden" name="userId" value="<%= user.getId() %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
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
