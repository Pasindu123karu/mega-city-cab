<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Driver - Mega City Cab</title>
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
        form {
            background: #fff;
            padding: 20px;
            width: 50%;
            margin: 20px auto;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #FFC107;
            color: black;
            padding: 12px 18px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }
        input[type="submit"]:hover {
            background-color: #FFA000;
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
    <h2>Add a New Driver</h2>
    <form action="addDriver" method="post">
        <input type="text" name="name" placeholder="Name" required><br>
        <input type="password" name="password" placeholder="Password" required><br>
        <input type="email" name="email" placeholder="Email" required><br>
        <input type="text" name="mobile" placeholder="Mobile" required><br>
        <input type="text" name="nic" placeholder="NIC" required><br>
        <input type="text" name="vehicle" placeholder="Vehicle" required><br>
        <input type="text" name="vehicle_type" placeholder="Vehicle Type" required><br>
        <input type="submit" value="Add Driver">
    </form>
    
    <% if (request.getAttribute("status") != null) { %>
        <% if (request.getAttribute("status").equals("success")) { %>
            <p style="color:green;">Driver added successfully!</p>
        <% } else { %>
            <p style="color:red;">Failed to add driver. Try again.</p>
        <% } %>
    <% } %>
    
    <button class="home-btn" onclick="goHome()">🏠 Home</button>
    
    <script>
        function goHome() {
            window.location.href = 'adminHome.jsp';
        }
    </script>
</body>
</html>
