<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.megacab.registration.adminLogin" %>

<%
    String adminEmail = request.getParameter("username");
    String adminPassword = request.getParameter("password");
    boolean isValid = false;

    if (adminEmail != null && adminPassword != null) {
        adminLogin loginValidator = new adminLogin();
        isValid = loginValidator.validateAdmin(adminEmail, adminPassword);

        if (isValid) {
            session.setAttribute("adminName", adminEmail);
            response.sendRedirect("adminHome.jsp");
            return;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Admin Login</title>
   <style>
      * {
         margin: 0;
         padding: 0;
         box-sizing: border-box;
         font-family: 'Poppins', sans-serif;
      }
      body {
         background-color: #121212;
         color: #fff;
         display: flex;
         justify-content: center;
         align-items: center;
         height: 100vh;
         padding: 20px;
      }
      .container {
         width: 90%;
         max-width: 400px;
         background: #1e1e1e;
         padding: 30px;
         border-radius: 12px;
         box-shadow: 0px 8px 20px rgba(255, 193, 7, 0.3);
         text-align: center;
      }
      .header {
         background-color: #FFC107;
         padding: 15px;
         border-radius: 8px;
         margin-bottom: 20px;
         color: #000;
      }
      .header h1 {
         font-size: 22px;
         font-weight: bold;
      }
      .input-group {
         margin-bottom: 15px;
         text-align: left;
      }
      .input-group label {
         display: block;
         font-size: 14px;
         margin-bottom: 5px;
      }
      .input-group input {
         width: 100%;
         padding: 10px;
         border: none;
         border-radius: 6px;
         background: #2a2a2a;
         color: #fff;
      }
      .btn {
         display: block;
         width: 100%;
         padding: 12px;
         background-color: #FFC107;
         color: #121212;
         text-decoration: none;
         font-size: 16px;
         font-weight: bold;
         border-radius: 6px;
         transition: all 0.3s ease;
         text-align: center;
         box-shadow: 0 4px 8px rgba(255, 193, 7, 0.3);
         border: none;
         cursor: pointer;
      }
      .btn:hover {
         background-color: #FFA000;
         transform: scale(1.05);
      }
   </style>
</head>
<body>
   <div class="container">
      <div class="header">
         <h1>Admin Login</h1>
      </div>
      <form action="adminlogin.jsp" method="POST">
         <div class="input-group">
            <label for="username">Email</label>
            <input type="text" id="username" name="username" required>
         </div>
         <div class="input-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
         </div>
         <button type="submit" class="btn">Login</button>
      </form>
      <% if (!isValid && adminEmail != null) { %>
         <p style="color: red; margin-top: 10px;">Invalid email or password.</p>
      <% } %>
   </div>
</body>
</html>
